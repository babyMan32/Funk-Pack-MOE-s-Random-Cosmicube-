var womanExists:Bool = true;
var gf_falling_var = false;
var allow_taunt = true;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			womanExists = false;
	}
}

function onCreatePost()
{
	if (hasBfSkin)
	{
		switch (PlayState.SONG.song)
		{
			case "Reactor":
				triggerEventNote('Change Character', 'boyfriend', 'bfr-dialogue');

				if (ClientPrefs.gfSkin == 'gf-dialogue')
				{
					triggerEventNote('Change Character', 'gf', 'gfr-dialogue');
				}

			case "Ejected":
				triggerEventNote('Change Character', 'boyfriend', 'bf-fall-dialogue');

				if (ClientPrefs.gfSkin == 'gf-dialogue')
				{
					triggerEventNote('Change Character', 'gf', 'gf-fall-dialogue');
				}

				gf_falling_var = true;

				gf.shader = boyfriend.shader = dad.shader;

			case "Danger":
				triggerEventNote('Change Character', 'boyfriend', 'bf-running-dialogue');

				if (ClientPrefs.gfSkin == 'gf-dialogue')
				{
					triggerEventNote('Change Character', 'gf', 'gfdanger-dialogue');
				}

			case "Finale":
				triggerEventNote('Change Character', 'boyfriend', 'bf-defeat-scared-dialogue');
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	onTauntCalled();

	if (gf_falling_var)
	{
		gf.x = 500;
	}

	if (boyfriend.getAnimName() != 'HEY! Cool' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}

function onTauntCalled()
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-dialogue' && allow_taunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(10))
		{
			boyfriend.playAnim('HEY! Cool');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;

		if (!womanExists) return;

		if (gf.curCharacter == 'gf-dialogue')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;
		}
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Lights out':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			triggerEventNote('Change Character', 'boyfriend', 'whitebf-dialogue');

		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			triggerEventNote('Change Character', 'boyfriend', 'bf-dialogue');

		case 'Legacy':
			switch (value1)
			{
				case 'readykill':
					if (boyfriend.curCharacter == 'bf-dialogue')
					{
						FlxG.signals.postUpdate.addOnce(function() {
							triggerEventNote('Change Character', '0', 'bf-defeat-normal-dialogue');
						});
					}
			}
	}
}