function onLoad()
{
	init_kade_hud = true;
}

function onCreatePost()
{
	allowIconSwitching = false;
	playHUD.iconP2.changeIcon(oppIconDuo);
	pauseOverride = pauseDuo;

	if (init_kade_hud) return;

	playHUD.healthBar.setColors(hpColorDuo);
	if (hasColor) playHUD.scoreTxt.color = hpColorDuo;
}