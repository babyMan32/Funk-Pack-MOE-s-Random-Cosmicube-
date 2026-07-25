var beeg = false;

var speed = 1;

function onLoad() 
{
	playbackRate = FlxG.random.float(0.8, 1.2);

	if (FlxG.random.bool(10)) 
	{
		pet.scale.set(1.2, 1.2);
		pet.y -= 450;
		pet.x -= 200;
		pet.updateHitbox();
		beeg = true;

		playbackRate *= 1.2;
	}

	speed = playbackRate;
}

function onCreatePost()
{
	if (PlayState.SONG.song != 'Identity Crisis') return;

	playbackRate *= FlxG.random.float(0.8, 1.2);

	if (beeg)
	{
		copyPet.scale.set(1.2, 1.2);
		copyPet.y = pet.y - 25;
		copyPet.x -= 200;
		copyPet.updateHitbox();

		playbackRate *= 1.2;
	}

	speed = playbackRate;
}

function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justReleased.THREE)
	{
		playbackRate = speed;
	}
}