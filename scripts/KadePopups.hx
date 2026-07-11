function goodNoteHit(note)
{
	if (!init_kade_hud) return;

	holySmackerel = new FlxSprite(550, 150).loadGraphic(Paths.image('ui/v3/epic', null, null, PathsTestMode.LOOSE));
	holySmackerel.scale.set(0.6, 0.6);
	add(holySmackerel);

	FlxTween.tween(holySmackerel, {y: holySmackerel.y - 100}, 2, {ease: FlxEase.quartOut, onComplete: function() ratsGone()});
}

function ratsGone()
{
	FlxTween.tween(holySmackerel, {y: 2500}, 2, {ease: FlxEase.quartIn});
	FlxTween.tween(holySmackerel, {alpha: 0}, 1, {ease: FlxEase.quartIn});
}