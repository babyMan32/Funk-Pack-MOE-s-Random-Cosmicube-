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

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "danger":
			changeCharacter('girlfriend-wind', 2);

			gf.x -= 50;
			gf.y -= 25;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!baddieExists) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'girlfriend-playable' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'boyfriend-speaker' || gf.curCharacter == 'girlfriend')
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