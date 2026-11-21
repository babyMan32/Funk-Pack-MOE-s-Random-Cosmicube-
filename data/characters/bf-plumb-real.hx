var counter = 0;
var _step_shit = [
	[287, 291],
	[319, 351],
	[367, 383]
];

function onLoad()
{
	pauseOverride = 'ghosthouse';
}

function opponentNoteHitPre(note)
{
	if (curSong != 'Identity Crisis') return;

	if (dad.curCharacter == boyfriend.getFlag('variants')?.monotone) pauseOverride = 'ghosthouse' + dad.idleSuffix;

	if (dad.curCharacter == 'monotone') pauseOverride = 'monotone';

	if (_step_shit[counter] == null) return;

	if (curStep >= _step_shit[counter][0] && curStep < _step_shit[counter][1])
	{
		note.animSuffix = '-alt';
	}

	if (curStep >= _step_shit[counter][1]) counter++;

	parent.idleSuffix = note.animSuffix;
}

function onPause()
{
	if (dad.curCharacter != boyfriend.getFlag('variants')?.monotone) return;

	Paths.overrideMode = PathsTestMode.LOOSE;
}

function onResume()
{
	if (dad.curCharacter != boyfriend.getFlag('variants')?.monotone) return;

	Paths.overrideMode = null;
}