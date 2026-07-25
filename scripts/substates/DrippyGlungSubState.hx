import funkin.objects.HealthIcon;
import flixel.system.FlxBGSprite;
import funkin.states.FreeplayState;

var curSelection:Int = 0;
var bg:FlxBGSprite;
var selectionArrow:FlxSprite;
var overlayCamera:FlxCamera;

public var canMove = false;
	
var bf:HealthIcon;
var glung:HealthIcon;
var iconArray:Array<HealthIcon> = [];
var dripRemixes = ['Drippypop', 'Double Kill']; // Double Kill is temporary until 'Drippypop (Remagets Mix)' is done

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
	add(bg);

	bf = new HealthIcon('bf', false);
	bf.screenCenter();
	bf.x -= 240;
	bf.alpha = 0;
	add(bf);
	iconArray.push(bf);

	glung = new HealthIcon('pico', false);
	glung.screenCenter();
	glung.x += 240;
	glung.alpha = 0;
	add(glung);
	iconArray.push(glung);

	selectionArrow = new FlxSprite(iconArray[curSelection].x + 25, 200).loadGraphic(Paths.image('menu/freeplay/miss/missAmountArrow'));
	selectionArrow.alpha = 0;
	add(selectionArrow);

	tweenTheShits(true);
}

function tweenTheShits(?on:Bool = false)
{
	tweenType = (on ? FlxEase.circOut : FlxEase.circIn);

	FlxTween.tween(bg, {alpha: (on ? 0.5 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(bf, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(glung, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType});
	FlxTween.tween(selectionArrow, {alpha: (on ? 1 : 0)}, 0.35, {ease: tweenType, onComplete: function() bullshitFuncMyFav(on)});
}

function bullshitFuncMyFav(?on:Bool = false)
{
	canMove = on;
	FlxG.state.lockMovement = on;
}

function onUpdate()
{
	if (canMove)
	{
		if (controls.UI_RIGHT_P) changeSelection(1);
		if (controls.UI_LEFT_P) changeSelection(-1);
		if (controls.BACK) tweenTheShits();
		if (controls.ACCEPT) songShitIGuess(curSelection);
	}
}

function songShitIGuess(song:Int)
{
	FreeplayState.loadSong(dripRemixes[song]);
}

function changeSelection(by:Int)
{
	if (by != 0) FlxG.sound.play(Paths.sound('hover'), 0.5);

	curSelection = FlxMath.wrap(curSelection + by, 0, 1);

	selectionArrow.x = iconArray[curSelection].x + 25;
}