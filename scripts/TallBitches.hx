var tall = false;

function onCreatePost()
{
	tall = boyfriend.getFlag('tall') ?? false;

	if (!tall) return; // rip my short kings

	if (PlayState.SONG.stage == 'doubletrouble' || PlayState.SONG.stage == 'polus')
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
	if (!tall) return; // rip my short kings

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

				case 'black', 'not black':
					FlxG.signals.postUpdate.addOnce(function() {
						bfOff[1] -= 25;
					});
			}
	}
}