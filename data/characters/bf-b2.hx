var womanExists:Bool = true;
var allow_gf_taunt = true;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			womanExists = false;
	}
}

function onUpdate(elapsed:Float):Void
{
	if (!womanExists) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-b2' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'whittygf')
		{
			gf.playAnim('hey');
			gf.specialAnim = true;

			allow_gf_taunt = false;
		}
	}

	if (gf.getAnimName() != 'hey')
	{
		allow_gf_taunt = true;
	}
}