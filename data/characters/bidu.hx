var womanExists:Bool = true;
var allow_taunt = true;

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
	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bidu' && allow_taunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(15))
		{
			boyfriend.playAnim('coolswag');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;

		if (!womanExists) return;

		if (gf.curCharacter == 'barbara-blue')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;
		}
	}

	if (boyfriend.getAnimName() != 'coolswag' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}