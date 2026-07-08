var camMovedToPlay = false;
var camMovedToOpp = false;

function onLoad()
{
	hasColor = false;
}

function onCreatePost()
{
	allowIconSwitching = false;
	playHUD.iconP2.changeIcon(oppIconDuo);
	playHUD.healthBar.setColors(0xFFfd0101, 0xFF6cf83e);
	pauseOverride = pauseDuo;
}

function onMoveCamera(focus)
{
	if (focus == 'boyfriend' && !camMovedToPlay)
	{
		dad.playAnim('idle', true);
		gf.playAnim('idle', true);

		camMovedToPlay = true;
		camMovedToOpp = false;
	}

	if (focus == 'dad' && !camMovedToOpp)
	{
		boyfriend.playAnim('idle', true);

		camMovedToPlay = false;
		camMovedToOpp = true;
	}
}