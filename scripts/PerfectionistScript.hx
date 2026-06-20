var enable_drain = false;
var doing_good = true;

//customizability, you can change these
var miss_limit = 10; //how many misses before you can die to health drain | Default: 10
var rating_limit = 50; //0-100 scale, how low your accuracy can go before you can die to health drain | Default: 50
var division_amount = 100; // the smaller the number, the greater the drain | Default: 100

function onLoad()
{
	if (ClientPrefs.pet == "job_application")
	{
		enable_drain = true;
	}
}

function rating_check():Bool
{
	if ((ratingPercent * 100) > rating_limit)
	{
		if (game.songMisses < miss_limit)
		{
			return true;
		}

		if (game.songMisses >= miss_limit)
		{
			return false;
		}
	}

	if ((ratingPercent * 100) <= rating_limit)
	{
		return false;
	}
}

function onUpdate()
{
	if (!enable_drain) return;

	doing_good = rating_check();

	totalNoteCount = game.totalNotesHit + game.songMisses;

	if (totalNoteCount > 0)
	{
		drain = (1 - ((ratingPercent * 100) / 100)) / division_amount;

		if (health - drain <= 0 && doing_good)
		{
			health = 0.00000000000000000000001;
			return;
		}

		health -= drain;
	}
}