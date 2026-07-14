var baddieExists:Bool = true;
var allow_gf_taunt = true;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			baddieExists = false;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (!baddieExists || gf.skipDance) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'boosterbf' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'boostergf')
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