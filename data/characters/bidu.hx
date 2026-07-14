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

function onUpdate(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bidu' && allow_taunt && boyfriend.canTaunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(15))
		{
			boyfriend.playAnim('coolswag');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;

		if (!baddieExists || gf.skipDance) return;

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