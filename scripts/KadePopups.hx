var bleh:FlxSpriteGroup;

var variable_epics = 0;
var variable_sicks = 0;
var variable_goods = 0;
var variable_bads = 0;
var variable_shits = 0;

var currentNumberOnes = 0;
var currentNumberTens = 0;
var currentNumberHundrecs = 0;

public var kade_combo_counter = 0;

var kadeCrochetMaybe = ((60 / bpm) * 1000);

var baseX:Float = 0;
var baseY:Float = 0;

var scaleComboX = 0.7;
var scaleComboY = 0.7;
var scaleNumbsX = 0.5;
var scaleNumbsY = 0.5;

function onCreatePost()
{
	bleh = new FlxSpriteGroup();
	playHUD.add(bleh);
}

function onUpdatePost(elapsed:Float):Void
{
	if (init_kade_hud)
	{
		playHUD.showRating = false;
		playHUD.showRatingNum = false;
	}
}

function goodNoteHit(note)
{
	if (!init_kade_hud) return;

	if (note.isSustainNote) return;

	FlxG.signals.postUpdate.addOnce(function() {
		kadeComboPopup();
		kadeNumbersPopup();
	});
}

function noteMiss(note)
{
	if (!init_kade_hud) return;

	missBullshit();
}

function missBullshit()
{
	kade_combo_counter = -1; //you lost your combo

	currentNumberOnes = kade_combo_counter;
	currentNumberTens = 0;
	currentNumberHundrecs = 0;
}

function kadeComboPopup()
{
	if (cpuControlled) return;

	rating_to_spawn = bullshitFunc(); //rating image

	var holySmackerel = new FlxSprite(baseX + 550, baseY + 150).loadGraphic(Paths.image('ui/v3/$rating_to_spawn', null, null, PathsTestMode.LOOSE));
	holySmackerel.scale.set(scaleComboX, scaleComboY);
	bleh.add(holySmackerel);
	holySmackerel.y += 50;

	holySmackerel.acceleration.y = 550;

	holySmackerel.velocity.y -= FlxG.random.int(140, 175); //movement shit i fucking guess
	holySmackerel.velocity.x -= FlxG.random.int(0, 10);

	FlxTween.tween(holySmackerel, {alpha: 0}, 0.2, {
		onComplete: function(tween:FlxTween)
		{
			holySmackerel.destroy();
		},
		startDelay: kadeCrochetMaybe * 0.001
	});
}

function kadeNumbersPopup()
{
	currentNumberOnes++;

	kade_combo_counter++;

	if (currentNumberOnes >= 10)
	{
		currentNumberOnes -= 10;
		currentNumberTens++;
	}

	if (currentNumberTens >= 10)
	{
		currentNumberTens -= 10;
		currentNumberHundrecs++;
	}

	var ratingNums = new FlxSpriteGroup();
	bleh.add(ratingNums);
	ratingNums.y += 50;

	offfsetr = 42;

	leCordY = baseY + 250;
	x1 = baseX + 625;
	x2 = x1 - offfsetr;
	x3 = x2 - offfsetr;

	var unos = new FlxSprite(x1, leCordY).loadGraphic(Paths.image('ui/v3/num$currentNumberOnes', null, null, PathsTestMode.LOOSE));
	unos.scale.set(scaleNumbsX, scaleNumbsY);
	ratingNums.add(unos);

	var tens = new FlxSprite(x2, leCordY).loadGraphic(Paths.image('ui/v3/num$currentNumberTens', null, null, PathsTestMode.LOOSE));
	tens.scale.set(scaleNumbsX, scaleNumbsY);
	ratingNums.add(tens);

	var beegNumb = new FlxSprite(x3, leCordY).loadGraphic(Paths.image('ui/v3/num$currentNumberHundrecs', null, null, PathsTestMode.LOOSE));
	beegNumb.scale.set(scaleNumbsX, scaleNumbsY);
	ratingNums.add(beegNumb);

	ratingNums.acceleration.y = FlxG.random.int(200, 300);

	ratingNums.velocity.y -= FlxG.random.int(140, 160);
	ratingNums.velocity.x = FlxG.random.float(-5, 5);

	FlxTween.tween(ratingNums, {alpha: 0}, 0.2, {
		onComplete: function(tween:FlxTween)
		{
			ratingNums.destroy();
		},
		startDelay: kadeCrochetMaybe * 0.002
	});
}

function bullshitFunc()
{
	if (epics > variable_epics)
	{
		variable_epics = epics;
		return 'epic';
	}

	if (sicks > variable_sicks)
	{
		variable_sicks = sicks;
		return 'sick';
	}

	if (goods > variable_goods)
	{
		variable_goods = goods;
		return 'good';
	}

	if (bads > variable_bads)
	{
		variable_bads = bads;
		return 'bad';
	}

	if (shits > variable_shits)
	{
		variable_shits = shits;
		missBullshit(); // you missed
		game.combo = 0;
		return 'shit';
	}

	return 'empty';
}