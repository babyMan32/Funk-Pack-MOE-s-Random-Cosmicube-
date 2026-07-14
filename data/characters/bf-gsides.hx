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

		if (!baddieExists || gf.skipDance) return;

		if (gf.curCharacter == 'gf-gsides')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;
		}
	}
	if (boyfriend.getAnimName() != 'cheer' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}