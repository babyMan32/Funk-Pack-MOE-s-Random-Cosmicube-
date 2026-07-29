function onPause()
{
	var pause = '';

	switch (dad.curCharacter)
	{
		case 'noob49':
			pause = 'old-noob49';

		case 'purple':
			pause = 'old-purple';

		case 'detective':
			pause = 'old-detective';

		case 'horsemate':
			pause = 'old-horsemate';
	}

	switch (PlayState.SONG.song)
	{
		case 'Triple Threat':
			pause = 'tripletrouble';
	}

	pauseOverwrite = pause;
}