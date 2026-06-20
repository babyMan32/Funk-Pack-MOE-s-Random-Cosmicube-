function onLoad()
{
	addCharacterToList('Vaporeon-dark', 0);
}

function onUpdate(elapsed:Float):Void
{
	if (boyfriend.curCharacter == 'Vaporeon-dark' && boyfriend.shader != null)
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
			triggerEventNote('Change Character', 'boyfriend', 'Vaporeon-dark');

		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			triggerEventNote('Change Character', 'boyfriend', 'Vaporeon');
	}
}

function onKeyPress(k:Int):Void
{
	if (k == 2 && parent.getAnimName() == 'idle' && (tauntCharacter == null || tauntCharacter == parent))
	{
		parent.playAnim('singUP');
		parent.specialAnim = parent.holding = true;
	}
}