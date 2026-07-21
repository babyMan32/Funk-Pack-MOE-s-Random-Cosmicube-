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

function onCreatePost()
{
	if (!init_kade_hud) return;

	ratingGraphic.visible = false;
	ratingNumGroup.visible = false;

	alpha_delay = 60 / Conductor.bpm;
}

function goodNoteHit(note)
{
	if (!init_kade_hud) return;

	if (note.isSustainNote) return;

	kadeComboPopup();
	kadeNumbersPopup();
}

function noteMiss(note)
{
	if (!init_kade_hud) return;

	currentNumberOnes = 0;
	currentNumberTens = 0;
	currentNumberHundrecs = 0;

	kade_combo_counter = 0; //you lost your combo
}

function kadeComboPopup()
{
	if (cpuControlled) return;

	FlxG.signals.postUpdate.addOnce(function() {
		rating_to_spawn = bullshitFunc();

		var holySmackerel = new FlxSprite(550, 150).loadGraphic(Paths.image('ui/v3/$rating_to_spawn', null, null, PathsTestMode.LOOSE));
		holySmackerel.scale.set(0.7, 0.7);
		add(holySmackerel);

		holySmackerel.acceleration.y = 550;

		holySmackerel.velocity.y -= FlxG.random.int(140, 175);
		holySmackerel.velocity.x -= FlxG.random.int(0, 10);

		FlxTween.tween(holySmackerel, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				holySmackerel.destroy();
			},
			startDelay: kadeCrochetMaybe * 0.001
		});
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
	add(ratingNums);

	var unos = new FlxSprite(660, 250).loadGraphic(Paths.image('ui/v3/num$currentNumberOnes', null, null, PathsTestMode.LOOSE));
	unos.scale.set(0.7, 0.7);
	ratingNums.add(unos);

	var tens = new FlxSprite(600, 250).loadGraphic(Paths.image('ui/v3/num$currentNumberTens', null, null, PathsTestMode.LOOSE));
	tens.scale.set(0.7, 0.7);
	ratingNums.add(tens);

	var beegNumb = new FlxSprite(540, 250).loadGraphic(Paths.image('ui/v3/num$currentNumberHundrecs', null, null, PathsTestMode.LOOSE));
	beegNumb.scale.set(0.7, 0.7);
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
		return 'shit';
	}

	return 'empty';
}