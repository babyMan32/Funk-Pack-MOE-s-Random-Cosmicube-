function onCreatePost()
{
	if (PlayState.SONG.song == 'Double Trouble')
	{
		bfOff[1] -= 100;
	}
	else
	{
		bfOff[1] -= 25;
	}
}

function onEvent(eventName, value1, value2)
{
	if (value1 == 'bf')
	{
		snapCamToPos(2250, 1000);
	}

	switch (eventName)
	{
		case 'Legacy':
			switch (value1)
			{
				case 'base':
					FlxG.signals.postUpdate.addOnce(function() {
						bfOff[1] -= 50;
					});
			}

				case 'black', 'not black':
					FlxG.signals.postUpdate.addOnce(function() {
						bfOff[1] -= 25;
					});
	}
}