var dev_store;
var timebar_store;
var fps_store;

function onLoad()
{
	init_kade_hud = true;

	hasColor = false;
	dev_store = ClientPrefs.inDevMode;
	timebar_store = ClientPrefs.timeBarType;
	fps_store = ClientPrefs.fpsDisplayType;

	ClientPrefs.inDevMode = false;
	ClientPrefs.timeBarType = 'Disabled';
	ClientPrefs.fpsDisplayType = 'Disabled';

	playHUD.timeBar.visible = false;
	playHUD.timeTxt.visible = false;
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

function onDestroy()
{
	ClientPrefs.inDevMode = dev_store;
	ClientPrefs.timeBarType = timebar_store;
	ClientPrefs.fpsDisplayType = fps_store;
}