var baddieExists = true;
var allow_gf_taunt = true;

function onLoad()
{
	addCharacterToList('bf-costume-dark', 0);

	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			baddieExists = false;
	}
}

function onUpdate(elapsed:Float):Void
{
	if (boyfriend.curCharacter == 'bf-costume-dark' && boyfriend.shader != null)
	{
		boyfriend.shader = null;
	}

	if (!baddieExists) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-costume' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'gf-costume')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;

			allow_gf_taunt = false;
		}
	}

	if (gf.getAnimName() != 'cheer')
	{
		allow_gf_taunt = true;
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