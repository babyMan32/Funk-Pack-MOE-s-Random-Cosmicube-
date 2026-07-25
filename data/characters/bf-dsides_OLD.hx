var allow_gf_taunt = true;

function onUpdatePost(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (!baddieExists || gf.skipDance) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-dsides_OLD' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'gf-dsides_OLD')
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