import funkin.FunkinAssets;
import funkin.objects.HealthIcon;
import flixel.system.FlxBGSprite;
import funkin.states.FreeplayState;
import funkin.objects.menu.AmongControls;

var songType:FlxText = '';

var curSelection:Int = 0;
var bg:FlxBGSprite;
var selectionArrow:FlxSprite;
var overlayCamera:FlxCamera;
var bottomControls:AmongControls;

var canMove = false;
	
var norm:HealthIcon;
var extra:HealthIcon;
var iconArray:Array<HealthIcon> = [];

var song = FlxG.state.week_songs[FreeplayState.curSelect];

var songVars = Paths.json("variations/" + Paths.sanitize(song[0]), null, PathsTestMode.LOOSE);
var songVarsRNG = Paths.json("variations/funnyChances/" + Paths.sanitize(song[0]), null, PathsTestMode.LOOSE);

var normMix = FunkinAssets.parseJson(FunkinAssets.getContent(songVars)).base;
var extraMix = FunkinAssets.parseJson(FunkinAssets.getContent(songVars)).extra;

var normIcon = FunkinAssets.parseJson(FunkinAssets.getContent(songVars)).baseIcon ?? 'placeholder';
var extraIcon = FunkinAssets.parseJson(FunkinAssets.getContent(songVars)).extraIcon ?? 'placeholder';

var remixes = [normMix, extraMix];

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

	norm = new HealthIcon(normIcon, false);
	norm.screenCenter();
	norm.x -= 240;
	norm.alpha = 0;
	add(norm);
	iconArray.push(norm); // base variation

	extra = new HealthIcon(extraIcon, false);
	extra.screenCenter();
	extra.x += 240;
	extra.alpha = 0;
	add(extra);
	iconArray.push(extra); // extra variation

	Paths.overrideMode = null;

	songType = new FlxText(0, 0, 1280, normMix);
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

	setUpChances();
}

function setUpChances()
{
	if (FunkinAssets.exists(songVarsRNG))
	{
		normChances = FunkinAssets.parseJson(FunkinAssets.getContent(songVarsRNG)).norm;
		extraChances = FunkinAssets.parseJson(FunkinAssets.getContent(songVarsRNG)).extra;
	}
}

function tweenTheShits(?on:Bool = false) // fade the shit in/out
{
	tweenType = (on ? FlxEase.circOut : FlxEase.circIn); // tween shit

	FlxTween.tween(bg, {alpha: (on ? 0.5 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(norm, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(extra, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
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
			if (FlxG.mouse.overlaps(norm))
			{
				if (curSelection == 0) songShitIGuess(curSelection);

				if (curSelection != 0) setSelection(0);
			}

			if (FlxG.mouse.overlaps(extra))
			{
				if (curSelection == 1) songShitIGuess(curSelection);

				if (curSelection != 1) setSelection(1);
			}
		}
	}
}

function songShitIGuess(song:Int)
{
	FlxG.sound.play(Paths.sound('confirmMenu'), 0.5);
	Paths.overrideMode = PathsTestMode.LOOSE;
	FreeplayState.loadSong(remixes[song]); // load variation
	Paths.overrideMode = null;
}

function changeSelection(by:Int)
{
	if (by != 0) FlxG.sound.play(Paths.sound('hover'), 0.5);

	curSelection = FlxMath.wrap(curSelection + by, 0, 1);

	selectionArrow.x = iconArray[curSelection].x + 25;

	songType.text = remixes[curSelection];

	chanceTime();
}

function setSelection(by:Int)
{
	FlxG.sound.play(Paths.sound('hover'), 0.5);

	curSelection = by;

	selectionArrow.x = iconArray[curSelection].x + 25;

	songType.text = remixes[curSelection];

	chanceTime();
}

function chanceTime()
{
	commonChance = FlxG.random.bool(25);
	uncommonChance = FlxG.random.bool(10);
	rareChance = FlxG.random.bool(1);

	if (curSelection == 0)
	{
		if (normChances == null) return;

		if (commonChance)
		{
			songType.text = normChances.common;
		}

		if (uncommonChance)
		{
			songType.text = normChances.uncommon;
		}

		if (rareChance)
		{
			songType.text = normChances.rare;
		}
	}

	if (curSelection == 1)
	{
		if (extraChances == null) return;

		if (commonChance)
		{
			songType.text = extraChances.common;
		}

		if (uncommonChance)
		{
			songType.text = extraChances.uncommon;
		}

		if (rareChance)
		{
			songType.text = extraChances.rare;
		}
	}
}