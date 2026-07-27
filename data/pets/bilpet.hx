var state = 'norm';

var speed = 1;

function onLoad() 
{
	if (FlxG.random.bool(10)) 
	{
		pet.scale.set(1.2, 1.2);
		pet.x -= 200;
		pet.y -= 450;
		pet.updateHitbox();
		state = 'beeg';

		playbackRate = Math.round(playbackRate * 120) / 100;
	}

	if (FlxG.random.bool(10) && state != 'beeg') 
	{
		pet.scale.set(0.1, 0.1);
		pet.x += 100;
		pet.y += 150;
		pet.updateHitbox();
		state = 'smol';

		playbackRate = Math.round(playbackRate * 80) / 100;
	}

	speed = playbackRate;
}

function onCreatePost()
{
	if (PlayState.SONG.song != 'Identity Crisis') return;

	if (state == 'beeg')
	{
		copyPet.scale.set(1.2, 1.2);
		copyPet.x -= 190;
		copyPet.y = pet.y - 42;
		copyPet.updateHitbox();

		playbackRate = Math.round(playbackRate * 120) / 100;
	}

	if (state == 'smol')
	{
		copyPet.scale.set(0.1, 0.1);
		copyPet.x += 85;
		copyPet.y = pet.y + 42;
		copyPet.updateHitbox();

		playbackRate = Math.round(playbackRate * 80) / 100;
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