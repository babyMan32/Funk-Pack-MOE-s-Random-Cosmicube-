import funkin.data.NoteSkin;

var skins;
var skinsOpp;
var lastSkins;
var lastBfSkin;
var lastDadSkin;

function onCreatePost()
{
	Paths.overrideMode = PathsTestMode.LOOSE;

	skins = boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[0];
	skinsOpp = dad.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[1];

	triggerEventNote('Change Noteskin', skins, 0);
	triggerEventNote('Change Noteskin', skinsOpp, 1);
}

function onDestroy()
{
	Paths.overrideMode = null;
}

function onPause()
{
	Paths.overrideMode = null;
}

function onGameOverStart()
{
	Paths.overrideMode = null;
}

function onResume()
{
	Paths.overrideMode = PathsTestMode.LOOSE;
}

function noteSkinChange()
{
	Paths.overrideMode = PathsTestMode.LOOSE;

	botplayNoteCheck();
	skinsOpp = dad.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[1];

	triggerEventNote('Change Noteskin', skins, 0);
	triggerEventNote('Change Noteskin', skinsOpp, 1);
}

function onUpdatePost(elapsed:Float):Void
{
	if (boyfriend.curCharacter != lastBfSkin || dad.curCharacter != lastDadSkin)
	{
		noteSkinChange();
		lastBfSkin = boyfriend.curCharacter;
		lastDadSkin = dad.curCharacter;
	}

	botplayNoteCheck();
}

function botplayNoteCheck()
{
	if (!boyfriend.hasFlag('botplayNoteSkin')) // mainly only used for the MMV2 chars
	{
		skins = boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[0];
		return;
	}

	skins = (cpuControlled ? boyfriend.getFlag('botplayNoteSkin') : (boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[0]));

	if (skins == lastSkins) return;

	triggerEventNote('Change Noteskin', skins, 0);

	lastSkins = skins;
}