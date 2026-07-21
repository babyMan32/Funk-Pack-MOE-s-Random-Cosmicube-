using StringTools;

var extraPlayer;

public var bf2;
public var extraIdleSuffix = '';
public var extraAnimSuffix = '';

public var tauntAnim = 'hey';

var direction = 'Left';

function onCreatePost()
{
	extraPlayer = ClientPrefs.equipment.get('extraPlayerSkin');

	if (extraPlayer == null) return;

	bf2 = new Character(0, 0, extraPlayer, true);
	boyfriendGroup.insert(0, bf2);
	bf2.x += bf2.getFlag('offsetX') ?? 250;
	bf2.y += bf2.getFlag('offsetY') ?? 75;

	FlxG.signals.postUpdate.addOnce(function() {
		bf2Rim = new funkin.game.shaders.ExtraDropShadowShader().copyFrom(boyfriend.shader);
		bf2Rim.attachedSprite = bf2;
		bf2.useRenderTexture = true;
	});
}

function onBeatHit()
{
	if (extraPlayer == null) return;

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
	if (extraPlayer == null) return;

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
	if (extraPlayer == null) return;

	bf2.holdTimer = 0;

	if (note.isSustainNote && bf2.vSliceSustains) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
}

function noteMiss(note)
{
	if (extraPlayer == null) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf2.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (extraPlayer == null || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf2.hasAnim(tauntAnim))
	{
		bf2.playAnim(tauntAnim);
		bf2.specialAnim = true;
	}
}