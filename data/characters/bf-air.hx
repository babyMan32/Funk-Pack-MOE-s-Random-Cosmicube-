var allow_taunt = true;

function onUpdate(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-air' && allow_taunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(20))
		{
			boyfriend.playAnim('cheer');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'cheer' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}