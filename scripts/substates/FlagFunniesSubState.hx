import funkin.FunkinAssets;

var _amt_counted = 0;

var _these_shits = ['backlit', 'floating', 'ghost', 'isPixel', 'runner', 'seeThrough'];
var _these_tips = [
	Lang.str('backlit_tip'), 
	Lang.str('floating_tip'),
	Lang.str('ghost_tip'),
	Lang.str('isPixel_tip'),
	Lang.str('runner_tip'),
	Lang.str('seeThrough_tip'),
	Lang.str('generic_collected'),
	Lang.str('all_collected')
];

var canLeave = false;

var flags:Array<FunkinSprite> = [];
var flagData:Array<FlagData> = [];
var tipText:FlxText;

function onLoad()
{
	Paths.overrideMode = null;

	tjhisCamera = new FlxCamera();
	tjhisCamera.bgColor = 0x00000000;
	tjhisCamera.antialiasing = ClientPrefs.globalAntialiasing;
	FlxG.cameras.add(tjhisCamera, false);

	camera = tjhisCamera;

	bg = new flixel.system.FlxBGSprite();
	bg.color = FlxColor.BLACK;
	bg.alpha = 0;
	add(bg); // darken the screen

	for (i in 0..._these_shits.length)
	{
		var newFlag = new FlxSprite(0, 0).loadGraphic(Paths.image('flag rofl', null, null, PathsTestMode.LOOSE));
		newFlag.scale.set(0.05, 0.05);
		newFlag.updateHitbox();
		newFlag.screenCenter();
		newFlag.x = ((FlxG.width / 6) * i) + (FlxG.width / 25);
		add(newFlag);

		var data = {
			id: _these_shits[i],
			tip: _these_tips[i]
		};
		flags.push(newFlag);
		flagData.push(data);

		var textFlag = new FlxText(0, 0, 1280, _these_shits[i], 15);
		textFlag.updateHitbox();
		textFlag.screenCenter();
		textFlag.x = ((FlxG.width / 6) * i) + (FlxG.width / 25);
		textFlag.y -= 75;
		add(textFlag);

		newFlag.alpha = 0;
		textFlag.alpha = 0;

		leNewAlpha = (FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[i], null, PathsTestMode.LOOSE)) == 'true' ? 1 : 0.5);

		_amt_counted += (FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[i], null, PathsTestMode.LOOSE)) == 'true' ? 1 : 0);

		FlxTween.tween(newFlag, {alpha: leNewAlpha}, 0.55, {ease: FlxEase.circOut});
		FlxTween.tween(textFlag, {alpha: leNewAlpha}, 0.55, {ease: FlxEase.circOut});
	}

	tipText = new FlxText(0, 0, 1280, '', 24);
	tipText.alignment = 'center';
	tipText.screenCenter();
	tipText.y = 670;
	add(tipText);
	FlxTween.tween(bg, {alpha: 0.75}, 0.55, {ease: FlxEase.circOut, onComplete: () -> { canLeave = true; }});
}

var hasHovered:Bool = false;

function onUpdate()
{
	hasHovered = false;

	for (i in 0...flags.length)
	{
		if (FlxG.mouse.overlaps(flags[i]))
		{
			// hover
			hasHovered = true;
			tipText.text = (_amt_counted == 6 ? _these_tips[7] : (FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[i], null, PathsTestMode.LOOSE)) == 'true' ? _these_tips[6] : flagData[i].tip));
			break;
		}
	}

	if (!hasHovered) tipText.text = '';

	if (controls.BACK && canLeave)
	{
		canLeave = false;

		for (i in 0..._these_shits.length)
		{
			FlxTween.tween(flags[i], {alpha: 0.0}, 0.3, {ease: FlxEase.circIn});
		}

		FlxTween.tween(bg, {alpha: 0.0}, 0.3, {ease: FlxEase.circIn, onComplete: () -> {
			close();
		}});
	}
}

function onDestroy() {
	FlxG.state.lockMovement = false;
}