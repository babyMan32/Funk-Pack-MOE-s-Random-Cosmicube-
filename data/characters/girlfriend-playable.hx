var allow_gf_taunt = true;

function onUpdatePost(elapsed:Float):Void
{
	if (!baddieExists) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'girlfriend-playable' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'girlfriend')
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