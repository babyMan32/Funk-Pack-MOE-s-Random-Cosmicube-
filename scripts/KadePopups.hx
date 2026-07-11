var variable_epics = 0;
var variable_sicks = 0;
var variable_goods = 0;
var variable_bads = 0;
var variable_shits = 0;

function goodNoteHit(note)
{
	if (!init_kade_hud) return;

	if (note.isSustainNote) return;

	FlxG.signals.postUpdate.addOnce(function() {
		rating_to_spawn = bullshitFunc();

		var holySmackerel = new FlxSprite(550, 150).loadGraphic(Paths.image('ui/v3/$rating_to_spawn', null, null, PathsTestMode.LOOSE));
		holySmackerel.scale.set(0.7, 0.7);
		add(holySmackerel);

		FlxTween.tween(holySmackerel, {y: holySmackerel.y - 100}, 1, {ease: FlxEase.quadOut});

		FlxTween.tween(holySmackerel, {x: holySmackerel.x + FlxG.random.int(-170, 170)}, 3, {ease: FlxEase.quadIn});

		FlxTween.tween(holySmackerel, {y: 2500}, 2, {ease: FlxEase.quadIn, startDelay: 1});
		FlxTween.tween(holySmackerel, {alpha: 0}, 1, {ease: FlxEase.quadIn, startDelay: 1, onComplete: function() holySmackerel.destroy()});
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

	return 'epic';
}