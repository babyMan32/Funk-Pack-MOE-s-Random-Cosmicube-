import funkin.data.NoteSkin;

var skins;

function onCreatePost()
{
	if (!hasBfSkin) return;

	Paths.overrideMode = PathsTestMode.LOOSE;

	skins = boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkin;

	triggerEventNote('Change Noteskin', skins, 0);
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

			skins = boyfriend.getFlag('noteSkin') ?? PlayState.SONG.arrowSkins[1];

			triggerEventNote('Change Noteskin', skins, 0);
	}
}