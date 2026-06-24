function onLoad()
{
	hasColor = false;
}

function onCreatePost()
{
	allowIconSwitching = false;
	playHUD.iconP2.changeIcon(oppIconDuo);
	playHUD.healthBar.setColors(hpColorDuo);
	pauseOverride = pauseDuo;
}