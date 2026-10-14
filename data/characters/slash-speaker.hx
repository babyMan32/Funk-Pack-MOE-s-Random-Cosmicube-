function onLoad()
{
	if (PlayState.SONG.stage == 'toogus')
	{
		parent.scale.x *= 0.8;
		parent.scale.y *= 0.8;
		parent.updateHitbox();
		parent.x += 300;
		parent.y -= 192;
	}
}