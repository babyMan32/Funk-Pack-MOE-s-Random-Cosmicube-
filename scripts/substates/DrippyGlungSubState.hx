import funkin.objects.HealthIcon;
import flixel.system.FlxBGSprite;
import funkin.states.FreeplayState;
import funkin.objects.menu.AmongControls;

var songType:FlxText = 'Drippypop';

var curSelection:Int = 0;
var bg:FlxBGSprite;
var selectionArrow:FlxSprite;
var overlayCamera:FlxCamera;
var bottomControls;

var canMove = false;
	
var bf:HealthIcon;
var glung:HealthIcon;
var iconArray:Array<HealthIcon> = [];

var dripRemixes = ['Drippypop', 'Drippypop (Remagets Mix)'];

var rare_chance = 'Drippypop (Glungus Mix)';

var ultra_rare_chance = 'Drippypop (Remadicks Mix)';

function onLoad()
{
	canMove = false;

	overlayCamera = new FlxCamera();
	overlayCamera.bgColor = 0x00000000;
	overlayCamera.antialiasing = ClientPrefs.globalAntialiasing;
	FlxG.cameras.add(overlayCamera, false);
		
	camera = overlayCamera;
		
	bg = new flixel.system.FlxBGSprite();
	bg.color = FlxColor.BLACK;
	bg.alpha = 0;
	add(bg); // darken the screen

	bf = new HealthIcon('bf', false);
	bf.screenCenter();
	bf.x -= 240;
	bf.alpha = 0;
	add(bf);
	iconArray.push(bf); // base variation

	glung = new HealthIcon('pico', false);
	glung.screenCenter();
	glung.x += 240;
	glung.alpha = 0;
	add(glung);
	iconArray.push(glung); // rema variation (icon to be done)

	songType = new FlxText(0, 0, 1280, "Drippypop");
	songType.setFormat(Paths.font("vcr.ttf"), 35, FlxColor.WHITE, 0, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	songType.alignment = 'center';
	songType.screenCenter();
	songType.y += 200;
	songType.alpha = 0;
	add(songType); // song name

	selectionArrow = new FlxSprite(iconArray[curSelection].x + 25, 200).loadGraphic(Paths.image('menu/freeplay/miss/missAmountArrow'));
	selectionArrow.alpha = 0;
	add(selectionArrow); // arrow that shows you which variation is currently selected

	if (bottomControls == null)
	{
		bottomControls = new AmongControls([
			['arrow', 'select'], // select
			['enter', 'conf'], // conf
			['esc', 'back'] // back
		], false);
		bottomControls.zIndex = 10;
		add(bottomControls);
	}

	tweenTheShits(true);
}

function tweenTheShits(?on:Bool = false) // fade the shit in/out
{
	tweenType = (on ? FlxEase.circOut : FlxEase.circIn); // tween shit

	FlxTween.tween(bg, {alpha: (on ? 0.5 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(bf, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(glung, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(songType, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(selectionArrow, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType, onComplete: function() bullshitFuncMyFav(on)});

	if (on == false) return;

	bottomControls.revive();
}

function bullshitFuncMyFav(?on:Bool = false)
{
	canMove = on;
	FlxG.state.lockMovement = on;

	if (on == true) return;

	bottomControls.kill();
}

function onUpdate()
{
	if (canMove) // selection code
	{
		if (controls.UI_RIGHT_P) changeSelection(1);
		if (controls.UI_LEFT_P) changeSelection(-1);
		if (controls.BACK) tweenTheShits();
		if (controls.ACCEPT) songShitIGuess(curSelection);

		if ((FlxG.mouse.justPressed))
		{
			if (FlxG.mouse.overlaps(bf))
			{
				if (curSelection == 0) songShitIGuess(curSelection);

				if (curSelection != 0) setSelection(0);
			}

			if (FlxG.mouse.overlaps(glung))
			{
				if (curSelection == 1) songShitIGuess(curSelection);

				if (curSelection != 1) setSelection(1);
			}
		}
	}
}

function songShitIGuess(song:Int)
{
	Paths.overrideMode = PathsTestMode.LOOSE;
	FreeplayState.loadSong(dripRemixes[song]); // load variation
	Paths.overrideMode = null;
}

function changeSelection(by:Int)
{
	if (by != 0) FlxG.sound.play(Paths.sound('hover'), 0.5);

	curSelection = FlxMath.wrap(curSelection + by, 0, 1);

	selectionArrow.x = iconArray[curSelection].x + 25;

	songType.text = dripRemixes[curSelection];

	chanceTime();
}

function setSelection(by:Int)
{
	FlxG.sound.play(Paths.sound('hover'), 0.5);

	curSelection = by;

	selectionArrow.x = iconArray[curSelection].x + 25;

	songType.text = dripRemixes[curSelection];

	chanceTime();
}

function chanceTime()
{
	if (curSelection == 1 && FlxG.random.bool(10))
	{
		songType.text = rare_chance; // lmao glungus mix
	}

	if (curSelection == 1 && FlxG.random.bool(1))
	{
		songType.text = ultra_rare_chance; // what the twink calls him
	}
}