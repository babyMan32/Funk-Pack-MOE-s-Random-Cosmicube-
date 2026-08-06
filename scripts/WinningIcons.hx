var winconP = false;
var winconO = false;

function onUpdatePost(elapsed:Float):Void
{
	winconP = boyfriend.getFlag('winningIcon') ?? false;
	winconO = dad.getFlag('winningIcon') ?? false;

	if (health >= 1.6)
	{
		if (winconP)
		{
			playHUD.iconP1.animation.curAnim.curFrame = 2;
		}

		if (winconO)
		{
			playHUD.iconP2.animation.curAnim.curFrame = 1;
		}
	}
	else if (health < 1.6 && health > 0.4)
	{
		if (winconP)
		{
			playHUD.iconP1.animation.curAnim.curFrame = 0;
		}

		if (winconO)
		{
			playHUD.iconP2.animation.curAnim.curFrame = 0;
		}
	}
	else
	{
		if (winconP)
		{
			playHUD.iconP1.animation.curAnim.curFrame = 1;
		}

		if (winconO)
		{
			playHUD.iconP2.animation.curAnim.curFrame = 2;
		}
	}

	colorP = boyfriend.getFlag('healthBarColor' + playHUD.iconP1.animation.curAnim.curFrame) ?? boyfriend.healthColour;
	colorO = dad.getFlag('healthBarColor' + playHUD.iconP2.animation.curAnim.curFrame) ?? dad.healthColour;

	playHUD.healthBar.setColors(Std.parseInt(colorO), Std.parseInt(colorP));
}