var womanExists = true;

function onLoad()
{
	addCharacterToList('bf-costume-dark', 0);

	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			womanExists = false;
	}
}

function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'bf-costume' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;

		if (!womanExists) return;

		if (gf.curCharacter == 'gf-costume')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;
		}
	}

	if (boyfriend.curCharacter == 'bf-costume-dark' && boyfriend.shader != null)
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
			triggerEventNote('Change Character', 'boyfriend', 'bf-costume-dark');

		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			triggerEventNote('Change Character', 'boyfriend', 'bf-costume');
	}
}