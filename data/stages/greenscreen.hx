function onLoad()
{
	var bg = new FlxSprite(-500, -300).makeGraphic(3000, 2000, 0xff00ff00);
	add(bg);

	camHUD.alpha = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	cpuControlled = true;
}