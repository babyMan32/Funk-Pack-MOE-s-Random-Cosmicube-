using StringTools;

var extraPlayer;

public var bf2;

public var extraIdleSuffix = '';
public var extraAnimSuffix = '';
public var tauntAnim = 'hey';

var direction = 'Left';

var bf2StageRim;

function onCreatePost()
{
	extraPlayer = ClientPrefs.equipment.get('extraPlayerSkin');

	if (extraPlayer == null) return;

	bf2 = new Character(0, 0, extraPlayer, true);
	boyfriendGroup.insert(0, bf2);
	bf2.x += bf2.getFlag('offsetX') ?? 250;
	bf2.y += bf2.getFlag('offsetY') ?? 75;

	bf2Icon = new HealthIcon(bf2.healthIcon, true);
	playHUD.insert(2, bf2Icon);

	shadersCheck();
}

function shadersCheck()
{
	if (bf2 != null && bf2.getFlag('backlit') != true)
	{
		if (ClientPrefs.shaders)
		{
			switch (PlayState.SONG.stage)
			{
				case "defeat":
					bf2StageRim = new funkin.game.shaders.ExtraDropShadowShader();
		
					bf2StageRim.threshold = .05;
					bf2StageRim.strength = .85;
					bf2StageRim.setColorMatrix([
						.4, .5, -.2, 0, -50,
						-.25, .7, -.15, 0, -20,
						.42, -.35, .85, 0, -72,
						0, 0, 0, 1, 0
					]);
					bf2StageRim.addLayer([
						.7, .5, 1, 0, 192,
						.3, .4, -.5, 0, 64,
						-.1, .2, .35, 0, 74,
						0, 0, 0, 1, 0
					], 10, 14, .01);
					bf2StageRim.addLayer(
						bf2StageRim.addLayer([
							.9, .6, .4, 0, 4,
							-.2, .5, .1, 0, -18,
							-.2, .2, .4, 0, -28,
							0, 0, 0, 1, 0
						], 12, 40, .01, .4)
					.colorMatrix, 96, 24, .01, .4);

				case "reactor":
					bf2StageRim = new funkin.game.shaders.ExtraDropShadowShader();
		
					bf2StageRim.threshold = .05;
					bf2StageRim.setColorMatrix([
						.8, .1, .2, 0, -40,
						0, .35, .1, 0, 2,
						.15, .12, .56, 0, -5,
						0, 0, 0, 1, 0
					]);
					bf2StageRim.addLayer([
						1, .3, 0, 0, 125,
						.1, 1, 0, 0, 114,
						-.1, -.1, 1, 0, 80,
						0, 0, 0, 1, 0
					], 120, 20, .05);
					bf2StageRim.addLayer(
						bf2StageRim.addLayer([
							.8, .2, .2, 0, 14,
							-.05, .6, 0, 0, 12,
							-.1, .5, .81, 0, -20,
							0, 0, 0, 1, 0
						], 95, 38, .05)
					.colorMatrix, 140, 32, .05);
			}

			if (bf2StageRim == null)
			{
				bf2.shader = boyfriend.shader;
				return;
			}

			bf2Rim = bf2StageRim;
			bf2Rim.attachedSprite = bf2;
			bf2.useRenderTexture = true;
		}
	}
}

function onBeatHit()
{
	if (bf2 == null) return;

	if (curBeat % bf2.danceEveryNumBeats == 0)
	{
		if (bf2.getAnimName().contains('idle'))
		{
			bf2.playAnim('idle' + extraIdleSuffix);
		}

		if (bf2.getAnimName().contains('dance'))
		{
			bf2.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf2.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function onCountdownTick(tick)
{
	if (bf2 == null) return;

	if (tick % bf2.danceEveryNumBeats == 0)
	{
		if (bf2.getAnimName().contains('idle'))
		{
			bf2.playAnim('idle' + extraIdleSuffix);
		}

		if (bf2.getAnimName().contains('dance'))
		{
			bf2.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf2.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function goodNoteHit(note)
{
	if (bf2 == null) return;

	bf2.holdTimer = 0;

	if (note.isSustainNote && bf2.vSliceSustains) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
}

function noteMiss(note)
{
	if (bf2 == null) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf2.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (bf2 == null) return;

	bf2Icon.x = iconP1.x + 75;
	bf2Icon.y = iconP1.y - 25;
	bf2Icon.scale.set(iconP1.scale.x, iconP1.scale.y);
	bf2Icon.shader = iconP1.shader;
	bf2Icon.updateIconAnim(healthBar.percent * 0.01);
	bf2Icon.alpha = iconP1.alpha;
	bf2Icon.visible = iconP1.visible;

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf2.hasAnim(tauntAnim))
	{
		bf2.playAnim(tauntAnim);
		bf2.specialAnim = true;
	}
}