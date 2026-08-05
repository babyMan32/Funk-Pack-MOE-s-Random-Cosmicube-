function onUpdatePost(elapsed:Float):Void
{
	if (health >= 1.6)
	{
		playHUD.healthBar.setColors(dad.healthColour, FlxColor.WHITE);
		playHUD.iconP1.animation.curAnim.curFrame = 2;
		playHUD.iconP1.flipX = true;
	}
	else if (health < 1.6 && health > 0.4)
	{
		playHUD.healthBar.setColors(dad.healthColour, boyfriend.healthColour);
		playHUD.iconP1.animation.curAnim.curFrame = 0;
		playHUD.iconP1.flipX = false;
	}
	else
	{
		playHUD.healthBar.setColors(dad.healthColour, 0x701e4d);
		playHUD.iconP1.animation.curAnim.curFrame = 1;
	}
}