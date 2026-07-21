using StringTools;

var extraExtraPlayer;

public var bf3;

public var extraIdleSuffix = '';
public var extraAnimSuffix = '';
public var tauntAnim = 'hey';

var direction = 'Left';

function onCreatePost()
{
	extraExtraPlayer = ClientPrefs.equipment.get('extraExtraPlayerSkin');

	if (extraExtraPlayer == null) return;

	bf3 = new Character(0, 0, extraExtraPlayer, true);
	boyfriendGroup.insert(3, bf3);
	bf3.x += bf3.getFlag('offsetX') ?? -250;
	bf3.y += bf3.getFlag('offsetY') ?? 75;

	bf3Icon = new HealthIcon(bf3.healthIcon, true);
	playHUD.insert(5, bf3Icon);

	if (boyfriend.shader == null) return;

	FlxG.signals.postUpdate.addOnce(function() {
		bf3Rim = new funkin.game.shaders.ExtraDropShadowShader().copyFrom(boyfriend.shader);
		bf3Rim.attachedSprite = bf3;
		bf3.useRenderTexture = true;
	});
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

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf3.hasAnim(tauntAnim))
	{
		bf3.playAnim(tauntAnim);
		bf3.specialAnim = true;
	}
}