function onLoad()
{
	var bg = new FlxSprite(-500, -300).makeGraphic(3000, 2000, 0xff00ff00);
	add(bg);

	camHUD.alpha = 0;

	healthLoss = 0;
}

function onCreatePost()
{
	camSpecialThing([750, 250], [750, 250]);
	canFollow = false;
}