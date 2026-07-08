var baddieExists:Bool = true;
var allow_taunt = true;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			baddieExists = false;
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

			case "Ejected":
				triggerEventNote('Change Character', 'boyfriend', 'bf-fall-dialogue');

				boyfriend.shader = dad.shader;

			case "Danger":
				triggerEventNote('Change Character', 'boyfriend', 'bf-running-dialogue');

			case "Finale":
				triggerEventNote('Change Character', 'boyfriend', 'bf-defeat-scared-dialogue');
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	onTauntCalled();

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

		if (!baddieExists) return;

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