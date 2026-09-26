var storedBF = 2;
var storedDad = 2;

function onCreatePost()
{
	if (curSong != 'D\'low') return;

	storedBF = boyfriend.danceEveryNumBeats;
	storedDad = dad.danceEveryNumBeats;
}

function onStepHit()
{
	if (curSong != 'D\'low') return;

	switch (curStep)
	{
		case 272, 278, 284, 304, 310:
			boyfriend.dance(true);
			boyfriend.danceEveryNumBeats = 999;

		case 288, 316:
			boyfriend.dance(true);
			boyfriend.danceEveryNumBeats = storedBF;

		case 336, 342, 348, 368, 374:
			dad.dance(true);
			dad.danceEveryNumBeats = 999;

		case 352, 380:
			dad.dance(true);
			dad.danceEveryNumBeats = storedBF;
	}
}