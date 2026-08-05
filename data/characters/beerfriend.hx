function onUpdatePost(elapsed:Float):Void
{
	if (boyfriend.curCharacter != 'beerfriend') return;

	if (health >= 1.6)
	{
		playHUD.healthBar.setColors((dad.curCharacter == 'beerfriend-shimny' ? 0x67009b : dad.healthColour), FlxColor.WHITE);
		playHUD.iconP1.animation.curAnim.curFrame = 2;

		if (dad.curCharacter == 'beerfriend-shimny')
		{
			playHUD.iconP2.animation.curAnim.curFrame = 1;
		}
	}
	else if (health < 1.6 && health > 0.4)
	{
		playHUD.healthBar.setColors(dad.healthColour, boyfriend.healthColour);
		playHUD.iconP1.animation.curAnim.curFrame = 0;

		if (dad.curCharacter == 'beerfriend-shimny')
		{
			playHUD.iconP2.animation.curAnim.curFrame = 0;
		}
	}
	else
	{
		playHUD.healthBar.setColors((dad.curCharacter == 'beerfriend-shimny' ? FlxColor.PURPLE : dad.healthColour), 0x701e4d);
		playHUD.iconP1.animation.curAnim.curFrame = 1;

		if (dad.curCharacter == 'beerfriend-shimny')
		{
			playHUD.iconP2.animation.curAnim.curFrame = 2;
		}
	}
}

function opponentNoteHit(note)
{
	audio.pitch = 1 + (dad.curCharacter == 'beerfriend-shimny' ? FlxG.random.float(-0.5, 0.5) : 0);
}

function goodNoteHit(note)
{
	if (boyfriend.curCharacter != 'beerfriend') return;

	audio.pitch = 1 + FlxG.random.float(-0.5, 0.5);
}