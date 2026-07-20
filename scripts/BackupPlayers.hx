using StringTools;

public var extraPlayer;
public var extraIdleSuffix = '';
public var extraAnimSuffix = '';

function onCreatePost()
{
	extraPlayer = ClientPrefs.equipment.get('extraPlayerSkin');

	if (extraPlayer == null) return;

	bf2 = new Character(0, 0, extraPlayer, true);
	boyfriendGroup.insert(boyfriendGroup.members.indexOf(bf2) + 1, bf2);
	bf2.x = boyfriend.x + 250;
	bf2.y = boyfriend.y - 75;
}

function onBeatHit()
{
	if (extraPlayer == null) return;

	if (curBeat % 2 == 0 && bf2.getAnimName().contains('idle'))
	{
		bf2.playAnim('idle' + extraIdleSuffix);
	}
}

function onCountdownTick(tick)
{
	if (extraPlayer == null) return;

	if (tick % 2 == 0 && bf2.getAnimName().contains('idle'))
	{
		bf2.playAnim('idle' + extraIdleSuffix);
	}
}

function goodNoteHit(note)
{
	if (extraPlayer == null) return;

	if (note.isSustainNote && bf2.vSliceSustains) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
	bf2.holdTimer = 0;
}

function noteMiss(note)
{
	if (extraPlayer == null) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf2.holdTimer = 0;
}