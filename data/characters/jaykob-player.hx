var fix_opp_offset = false;

function onCreatePost()
{
	if (hasBfSkin)
	{
		switch (PlayState.SONG.stage)
		{
			case "monotone":
				fix_opp_offset = true;
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	if (dad.curCharacter == "jaykob-opponent" && fix_opp_offset)
	{
		dad.x = 0;
	}
}