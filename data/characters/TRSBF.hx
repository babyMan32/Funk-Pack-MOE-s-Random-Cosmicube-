import funkin.data.NoteSkin;

function onCreatePost()
{
	Paths.overrideMode = PathsTestMode.LOOSE;
	triggerEventNote('Change Noteskin', 'railway_re-fired', 0);
}

function onDestroy()
{
	Paths.overrideMode = null;
}