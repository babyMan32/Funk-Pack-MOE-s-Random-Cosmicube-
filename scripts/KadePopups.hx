var variable_epics = 0;
var variable_sicks = 0;
var variable_goods = 0;
var variable_bads = 0;
var variable_shits = 0;

var currentNumberOnes = 0;
var currentNumberTens = 0;
var currentNumberHundrecs = 0;

public var kade_combo_counter = 0;

function onCreatePost()
{
	ratingGraphic.visible = false;
	ratingNumGroup.visible = false;
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
	currentNumberOnes = 0;
	currentNumberTens = 0;
	currentNumberHundrecs = 0;

	kade_combo_counter = 0; //you lost your combo
}

function kadeComboPopup()
{
	FlxG.signals.postUpdate.addOnce(function() {
		var rating_to_spawn = bullshitFunc();

		var holySmackerel = new FlxSprite(550, 150).loadGraphic(Paths.image('ui/v3/$rating_to_spawn', null, null, PathsTestMode.LOOSE));
		holySmackerel.scale.set(0.7, 0.7);
		add(holySmackerel);

		FlxTween.tween(holySmackerel, {y: holySmackerel.y - 100}, 1, {ease: FlxEase.quadOut});

		FlxTween.tween(holySmackerel, {x: holySmackerel.x + FlxG.random.int(-170, 170)}, 3, {ease: FlxEase.quadIn});

		FlxTween.tween(holySmackerel, {y: 2500}, 2, {ease: FlxEase.quadIn, startDelay: 1});
		FlxTween.tween(holySmackerel, {alpha: 0}, 1, {ease: FlxEase.quadIn, startDelay: 1, onComplete: function() holySmackerel.destroy()});
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

	var unos = new FlxSprite(760, 250).loadGraphic(Paths.image('ui/v3/num$currentNumberOnes', null, null, PathsTestMode.LOOSE));
	unos.scale.set(0.7, 0.7);
	add(unos);

	var tens = new FlxSprite(700, 250).loadGraphic(Paths.image('ui/v3/num$currentNumberTens', null, null, PathsTestMode.LOOSE));
	tens.scale.set(0.7, 0.7);
	add(tens);

	var beegNumb = new FlxSprite(640, 250).loadGraphic(Paths.image('ui/v3/num$currentNumberHundrecs', null, null, PathsTestMode.LOOSE));
	beegNumb.scale.set(0.7, 0.7);
	add(beegNumb);

	FlxTween.tween(unos, {y: unos.y - 100}, 1, {ease: FlxEase.quadOut});
	FlxTween.tween(tens, {y: tens.y - 100}, 1, {ease: FlxEase.quadOut});
	FlxTween.tween(beegNumb, {y: tens.y - 100}, 1, {ease: FlxEase.quadOut});

	FlxTween.tween(unos, {x: unos.x + FlxG.random.int(-170, 170)}, 3, {ease: FlxEase.quadIn});
	FlxTween.tween(tens, {x: tens.x + FlxG.random.int(-170, 170)}, 3, {ease: FlxEase.quadIn});
	FlxTween.tween(beegNumb, {x: tens.x + FlxG.random.int(-170, 170)}, 3, {ease: FlxEase.quadIn});

	FlxTween.tween(unos, {y: 2600}, 2, {ease: FlxEase.quadIn, startDelay: 1});
	FlxTween.tween(unos, {alpha: 0}, 1, {ease: FlxEase.quadIn, startDelay: 1, onComplete: function() unos.destroy()});
	FlxTween.tween(tens, {y: 2600}, 2, {ease: FlxEase.quadIn, startDelay: 1});
	FlxTween.tween(tens, {alpha: 0}, 1, {ease: FlxEase.quadIn, startDelay: 1, onComplete: function() tens.destroy()});
	FlxTween.tween(beegNumb, {y: 2600}, 2, {ease: FlxEase.quadIn, startDelay: 1});
	FlxTween.tween(beegNumb, {alpha: 0}, 1, {ease: FlxEase.quadIn, startDelay: 1, onComplete: function() beegNumb.destroy()});
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

	return 'epic';
}