var beeg = false;

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
}

function onCreatePost()
{
	if (beeg && PlayState.SONG.song == 'Identity Crisis')
	{
		copyPet.scale.set(1.2, 1.2);
		copyPet.y = pet.y - 25;
		copyPet.x -= 200;
		copyPet.updateHitbox();
	}
}