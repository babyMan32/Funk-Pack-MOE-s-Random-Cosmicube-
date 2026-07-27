var beeg = false;

var speed = 1;

function onLoad() 
{
	val = Math.round(FlxG.random.int(80, 120)) / 100;

	playbackRate = val;

	if (FlxG.random.bool(10)) 
	{
		pet.scale.set(1.2, 1.2);
		pet.y -= 450;
		pet.x -= 200;
		pet.updateHitbox();
		beeg = true;

		playbackRate = Math.round(playbackRate * 120) / 100;
	}

	speed = playbackRate;
}

function onCreatePost()
{
	if (PlayState.SONG.song != 'Identity Crisis') return;

	val = Math.round(FlxG.random.int(80, 120)) / 100;

	playbackRate *= val;

	if (beeg)
	{
		copyPet.scale.set(1.2, 1.2);
		copyPet.y = pet.y - 25;
		copyPet.x -= 200;
		copyPet.updateHitbox();

		playbackRate = Math.round(playbackRate * 120) / 100;
	}

	speed = playbackRate;
}

function onUpdate(elapsed:Float):Void
{
	if (ClientPrefs.inDevMode || PlayState.chartingMode)
	{
		if (FlxG.keys.pressed.THREE)
		{
			playbackRate *= speed;
		}
		else if (FlxG.keys.justReleased.THREE)
		{
			playbackRate = speed;
		}
	}
}