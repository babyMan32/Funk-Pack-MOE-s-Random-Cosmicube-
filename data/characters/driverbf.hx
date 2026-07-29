import funkin.data.NoteSkin;

function onCreatePost()
{
	Paths.overrideMode = PathsTestMode.LOOSE;
	triggerEventNote('Change Noteskin', 'railway', 0);
}

function onDestroy()
{
	Paths.overrideMode = null;
}