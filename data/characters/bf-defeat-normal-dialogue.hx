function onCreatePost()
{
	switch (PlayState.SONG.song)
	{
		case "Finale":
			changeCharacter('bf-defeat-scared-dialogue', 0);
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Defeat Fade':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;

			switch (charType)
			{
				case 0:
					if (boyfriend.curCharacter == 'bf-defeat-normal-dialogue')
					{
						changeCharacter('bf-defeat-scared-dialogue', 0);
					}
			}
	}
}