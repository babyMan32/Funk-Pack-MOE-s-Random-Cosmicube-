var dev_store;
var fps_store;

var camMovedToPlayExtra = false;

function onLoad()
{
	init_kade_hud = true;

	hasColor = false;

	dev_store = ClientPrefs.inDevMode;
	fps_store = ClientPrefs.fpsDisplayType;

	ClientPrefs.inDevMode = false;
	ClientPrefs.fpsDisplayType = 'Disabled';

	playHUD.timeBar.visible = playHUD.timeTxt.visible = false;

	FlxG.stage.window.title = 'FNF: VS Impostor';
}

function onCreatePost()
{
	allowIconSwitching = false;
	playHUD.iconP2.changeIcon(oppIconDuo);
	pauseOverride = pauseDuo;

	if (init_kade_hud) return;

	playHUD.healthBar.setColors(hpColorDuo);
	if (hasColor) playHUD.scoreTxt.color = hpColorDuo;

	gf.camDisplacement = 0;
}

function onDestroy()
{
	init_kade_hud = false;

	ClientPrefs.inDevMode = dev_store;
	ClientPrefs.fpsDisplayType = fps_store;

	FlxG.stage.window.title = 'VS IMPOSTOR LEGACY v1.1.1b';
}

function onGameOver()
{
	init_kade_hud = false;

	ClientPrefs.inDevMode = dev_store;
	ClientPrefs.fpsDisplayType = fps_store;

	FlxG.stage.window.title = 'VS IMPOSTOR LEGACY v1.1.1b';
}

function onMoveCamera(focus)
{
	if (!init_kade_hud) return;

	if (middleCam) return;

	if (focus == 'boyfriend' && !camMovedToPlayExtra)
	{
		gf.playAnim('idle', true);

		camMovedToPlayExtra = true;
	}

	if (focus == 'dad' && camMovedToPlayExtra)
	{
		camMovedToPlayExtra = false;
	}
}