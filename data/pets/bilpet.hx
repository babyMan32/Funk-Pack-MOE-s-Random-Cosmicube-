var state = 'norm';

var speed = 1;

var copyDead = true;

function onLoad() 
{
	if (FlxG.random.bool(10)) 
	{
		parent.scale.set(1.2, 1.2);
		parent.x -= 200;
		parent.y -= 450;
		parent.updateHitbox();
		state = 'beeg';

		playbackRate = Math.round(playbackRate * 120) / 100;
	}

	if (FlxG.random.bool(10) && state != 'beeg') 
	{
		parent.scale.set(0.1, 0.1);
		parent.x += 100;
		parent.y += 150;
		parent.updateHitbox();
		state = 'smol';

		playbackRate = Math.round(playbackRate * 80) / 100;
	}

	speed = playbackRate;

	if (PlayState.SONG.stage == 'toogus')
	{
		parent.scale.x *= 0.8;
		parent.scale.y *= 0.8;
		parent.updateHitbox();
		parent.x -= 385;
		parent.y -= 282;

		parent.zIndex = (ClientPrefs.gfSkin == 'slash-speaker' ? 15 : 10);
	}
}

function onCreatePost()
{
	if (PlayState.SONG.song != 'Identity Crisis') return;

	copyDead = false;

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

function onEvent(n, v1, v2)
{
	if (dad.curCharacter == 'monotone' && !copyDead)
	{
		speed /= (state == 'smol' ? 0.8 : (state == 'beeg' ? 1.2 : 1));
		playbackRate = speed;
		copyDead = true;
	}
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