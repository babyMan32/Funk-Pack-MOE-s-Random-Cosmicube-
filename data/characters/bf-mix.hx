var womanExists:Bool = true;

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
	if (hasBfSkin && FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'bf-mix' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;

		if (!womanExists) return;

		if (gf.curCharacter == 'gf-mix')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;
		}
	}
}