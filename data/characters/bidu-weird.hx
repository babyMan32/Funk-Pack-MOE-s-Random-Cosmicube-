var allow_taunt = true;

function onUpdate(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bidu-weird' && allow_taunt && boyfriend.canTaunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(15))
		{
			boyfriend.playAnim('coolswag');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'coolswag' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}