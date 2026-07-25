var allow_gf_taunt = true;

function onUpdatePost(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (!baddieExists || gf.skipDance) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-b-deluxe' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'gf-b-deluxe')
		{
			gf.playAnim('hey');

			if (FlxG.random.bool(10))
			{
				gf.playAnim('cheer');
			}

			allow_gf_taunt = false;

			gf.specialAnim = true;
		}
	}

	if (gf.getAnimName() != 'hey' && gf.getAnimName() != 'cheer')
	{
		allow_gf_taunt = true;
	}
}