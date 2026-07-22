using StringTools;

var extraExtraPlayer;

public var bf3;

public var extraExtraIdleSuffix = '';
public var extraExtraAnimSuffix = '';
public var tauntAnim2 = 'hey';

var direction = 'Left';

var bf3StageRim;

function onCreatePost()
{
	extraExtraPlayer = ClientPrefs.equipment.get('extraExtraPlayerSkin');

	if (extraExtraPlayer == null) return;

	bf3 = new Character(0, 0, extraExtraPlayer, true);
	boyfriendGroup.insert(3, bf3);
	bf3.x += bf3.getFlag('offsetX') ?? -250;
	bf3.y += bf3.getFlag('offsetY') ?? 225;

	bf3Icon = new HealthIcon(bf3.healthIcon, true);

	if (bf2 != null)
	{
		playHUD.insert(5, bf3Icon);
	}
	else
	{
		playHUD.insert(4, bf3Icon);
	}

	shadersCheck();
}

function shadersCheck()
{
	if (bf3 != null && bf3.getFlag('backlit') != true)
	{
		if (ClientPrefs.shaders)
		{
			switch (PlayState.SONG.stage)
			{
				case "defeat":
					bf3StageRim = new funkin.game.shaders.ExtraDropShadowShader();
		
					bf3StageRim.threshold = .05;
					bf3StageRim.strength = .85;
					bf3StageRim.setColorMatrix([
						.4, .5, -.2, 0, -50,
						-.25, .7, -.15, 0, -20,
						.42, -.35, .85, 0, -72,
						0, 0, 0, 1, 0
					]);
					bf3StageRim.addLayer([
						.7, .5, 1, 0, 192,
						.3, .4, -.5, 0, 64,
						-.1, .2, .35, 0, 74,
						0, 0, 0, 1, 0
					], 10, 14, .01);
					bf3StageRim.addLayer(
						bf3StageRim.addLayer([
							.9, .6, .4, 0, 4,
							-.2, .5, .1, 0, -18,
							-.2, .2, .4, 0, -28,
							0, 0, 0, 1, 0
						], 12, 40, .01, .4)
					.colorMatrix, 96, 24, .01, .4);

				case "reactor":
					bf3StageRim = new funkin.game.shaders.ExtraDropShadowShader();
		
					bf3StageRim.threshold = .05;
					bf3StageRim.setColorMatrix([
						.8, .1, .2, 0, -40,
						0, .35, .1, 0, 2,
						.15, .12, .56, 0, -5,
						0, 0, 0, 1, 0
					]);
					bf3StageRim.addLayer([
						1, .3, 0, 0, 125,
						.1, 1, 0, 0, 114,
						-.1, -.1, 1, 0, 80,
						0, 0, 0, 1, 0
					], 120, 20, .05);
					bf3StageRim.addLayer(
						bf3StageRim.addLayer([
							.8, .2, .2, 0, 14,
							-.05, .6, 0, 0, 12,
							-.1, .5, .81, 0, -20,
							0, 0, 0, 1, 0
						], 95, 38, .05)
					.colorMatrix, 140, 32, .05);
			}

			if (bf3StageRim == null)
			{
				bf3.shader = boyfriend.shader;
				return;
			}

			bf3Rim = bf3StageRim;
			bf3Rim.attachedSprite = bf3;
			bf3.useRenderTexture = true;
		}
	}
}

function onBeatHit()
{
	if (bf3 == null) return;

	if (curBeat % bf3.danceEveryNumBeats == 0)
	{
		if (bf3.getAnimName().contains('idle'))
		{
			bf3.playAnim('idle' + extraIdleSuffix);
		}

		if (bf3.getAnimName().contains('dance'))
		{
			bf3.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf3.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function onCountdownTick(tick)
{
	if (bf3 == null) return;

	if (tick % bf3.danceEveryNumBeats == 0)
	{
		if (bf3.getAnimName().contains('idle'))
		{
			bf3.playAnim('idle' + extraIdleSuffix);
		}

		if (bf3.getAnimName().contains('dance'))
		{
			bf3.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf3.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function goodNoteHit(note)
{
	if (bf3 == null) return;

	bf3.holdTimer = 0;

	if (note.isSustainNote && bf3.vSliceSustains) return;

	bf3.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
}

function noteMiss(note)
{
	if (bf3 == null) return;

	bf3.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf3.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (bf3 == null) return;

	bf3Icon.x = iconP1.x - 75;
	bf3Icon.y = iconP1.y + 25;
	bf3Icon.scale.set(iconP1.scale.x, iconP1.scale.y);
	bf3Icon.shader = iconP1.shader;
	bf3Icon.updateIconAnim(healthBar.percent * 0.01);
	bf3Icon.alpha = iconP1.alpha;
	bf3Icon.visible = iconP1.visible;

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf3.hasAnim(tauntAnim))
	{
		bf3.playAnim(tauntAnim);
		bf3.specialAnim = true;
	}
}