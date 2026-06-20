function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "danger":
			gf.x -= 65;
			gf.y += 30;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	playInDanger = (healthBar.percent <= 20) ? true : false;

	triggerEventNote('Alt Idle Animation', 'gf', playInDanger ? '-spooked' : '');
}