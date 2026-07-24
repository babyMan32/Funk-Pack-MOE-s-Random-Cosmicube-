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
	switch (PlayState.SONG.song)
	{
		case "Reactor":
			changeCharacter('bfr-dialogue', 0);

		case "Danger":
			changeCharacter('bf-running-dialogue', 0);
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

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-dialogue' && allow_taunt && boyfriend.canTaunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(10))
		{
			boyfriend.playAnim('HEY! Cool');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;

		if (!baddieExists || gf.skipDance) return;

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