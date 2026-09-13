var damn_it;

function onLoad()
{
	damn_it = new FlxSprite(0, 0).makeGraphic(3000, 2000, 0xffffffff);
	damn_it.camera = PlayState.instance.camOther;
	damn_it.screenCenter();
	damn_it.alpha = 0.0001;
	add(damn_it);

	FlxG.signals.postUpdate.addOnce(crash);
}

function crash()
{
	new FlxTimer().start(1.5, () -> {
		FlxTween.tween(damn_it, {alpha: 0.5}, 0.5);

		new FlxTimer().start(3, function(_) {
			FlxG.stage.window.close();
		});
	});
}