function onLoad()
{
	addCharacterToList('chester-dark', 0);
}

function onUpdate(elapsed:Float):Void
{
	if (boyfriend.curCharacter == 'chester-dark' && boyfriend.shader != null)
	{
		boyfriend.shader = null;
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Lights out':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			triggerEventNote('Change Character', 'boyfriend', 'chester-dark');

		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			triggerEventNote('Change Character', 'boyfriend', 'chester');
	}
}