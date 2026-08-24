var allow_taunt = true;

function onUpdatePost(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-gsides' && allow_taunt && boyfriend.canTaunt)
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