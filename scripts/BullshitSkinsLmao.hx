import funkin.data.NoteSkin;

var skins;
var skinsOpp;
var lastSkins;

function onCreatePost()
{
	if (!hasBfSkin) return;

	Paths.overrideMode = PathsTestMode.LOOSE;

	skins = boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[0];
	skinsOpp = dad.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[1];

	triggerEventNote('Change Noteskin', skins, 0);
	triggerEventNote('Change Noteskin', skinsOpp, 1);
}

function onDestroy()
{
	if (!hasBfSkin) return;

	Paths.overrideMode = null;
}

function onPause()
{
	if (!hasBfSkin) return;

	Paths.overrideMode = null;
}

function onResume()
{
	if (!hasBfSkin) return;

	Paths.overrideMode = PathsTestMode.LOOSE;
}

function onEvent(eventName, value1, value2)
{
	if (!hasBfSkin) return;

	switch (eventName)
	{
		case 'Change Character':
			Paths.overrideMode = PathsTestMode.LOOSE;

			skins = boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[0];
			skinsOpp = dad.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[1];

			triggerEventNote('Change Noteskin', skins, 0);
			triggerEventNote('Change Noteskin', skinsOpp, 1);
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!boyfriend.hasFlag('botplayNoteSkin')) return; // mainly only used for the MMV2 chars

	skins = (cpuControlled ? boyfriend.getFlag('botplayNoteSkin') : (boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[0]));

	if (skins == lastSkins) return;

	triggerEventNote('Change Noteskin', skins, 0);

	lastSkins = skins;
}