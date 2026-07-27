import cpp.Windows;
import lime.graphics.Image;
import funkin.FunkinAssets;

var dev_store;
var fps_store;

var camMovedToPlayExtra = false; //more bullshit var

function onLoad()
{
	init_kade_hud = true;

	hasColor = false;

	dev_store = ClientPrefs.inDevMode; //kinda fucky but we roll with this shit
	fps_store = ClientPrefs.fpsDisplayType;

	ClientPrefs.inDevMode = false;
	ClientPrefs.fpsDisplayType = 'Disabled';

	playHUD.timeBar.visible = playHUD.timeTxt.visible = false;

	FlxG.stage.window.title = 'FNF: VS Impostor'; //haha the window title changed lmfao
	Windows.setDarkMode(false); //become blind bitch

	var img:Bytes = FunkinAssets.getBytes(Paths.getPath('images/icon16-v3.png', null, PathsTestMode.LOOSE));
	var icon:Image = Image.fromBytes(img);
	FlxG.stage.window.setIcon(icon);
}

function onStartCountdown()
{
	if (!init_kade_hud) return;

	FlxG.signals.postUpdate.addOnce(function() {
		kadeIconDad.changeIcon(oppIconDuo);
	});
}

function onCreatePost()
{
	allowIconSwitching = false;
	pauseOverride = pauseDuo;

	gf.camDisplacement = 0;

	if (init_kade_hud) return;

	playHUD.healthBar.setColors(hpColorDuo); //doubel trouble specific code
	if (hasColor) playHUD.scoreTxt.color = hpColorDuo;
}

function onDestroy()
{
	init_kade_hud = false;

	ClientPrefs.inDevMode = dev_store;
	ClientPrefs.fpsDisplayType = fps_store;

	FlxG.stage.window.title = 'VS IMPOSTOR LEGACY v' + Main.LEGACY_VERSION;
	Windows.setDarkMode();

	var img:Bytes = FunkinAssets.getBytes(Paths.getPath('images/icon16-legacy.png', null, PathsTestMode.LOOSE));
	var icon:Image = Image.fromBytes(img);
	FlxG.stage.window.setIcon(icon);
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