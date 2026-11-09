var error:FlxSprite;

function onLoad()
{
	error = new FlxSprite(0, 0).loadGraphic(Paths.image('error'));
	error.camera = PlayState.instance.camHUD;
	error.screenCenter();
	add(error);

	healthGain = healthLoss = 0;
}

function onCreatePost()
{
	boyfriend.alpha = error.alpha = dad.alpha = 0;

	comboX = 440;

	modManager.setValue("noteAlpha", 1);
	modManager.setValue("alpha", 1);

	modManager.queueEase(36, 56, 'noteAlpha', 0.6, 'linear', 1);
	modManager.queueEase(36, 56, 'alpha', 0.6, 'linear', 1);

	modManager.queueEase(120, 128, 'noteAlpha', 0, 'linear', 0);
	modManager.queueEase(120, 128, 'alpha', 0, 'linear', 0);

	if (!ClientPrefs.middleScroll) modManager.setValue("opponentSwap", 0.5);
	if (!ClientPrefs.downScroll) modManager.setValue("reverse", 1, 0);
	if (ClientPrefs.downScroll) modManager.setValue("reverse", 1, 1);

	for (hi in [playHUD.healthBar, playHUD.scoreTxt, playHUD.iconP1, playHUD.iconP2]) hi.alpha = 0;

	playHUD.healthBar.y += 40;
	playHUD.scoreTxt.y = 20;
	playHUD.iconP1.y += 20;

	playHUD.timeBar.visible = playHUD.timeTxt.visible = false;

	FlxG.signals.postUpdate.addOnce(function() {
		taskGroup.visible = false;
	});

	camSpecialThing([600, 420], [600, 920]);
}

function onSongStart()
{
	error.alpha = 1;
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 == 'intro-fade')
			{
				FlxTween.tween(error, {'scale.x': 0}, 1.3, {ease: FlxEase.circInOut});
				FlxTween.tween(error, {'scale.y': 0}, 1.2);
				FlxTween.tween(dad, {alpha: 1}, 2.2);
				taskGroup.visible = true;
			}

			if (value1 == 'hud-on')
			{
				for (hehe in [playHUD.healthBar, playHUD.scoreTxt, playHUD.iconP1, playHUD.iconP2]) FlxTween.tween(hehe, {alpha: 1}, 0.7);
				healthGain = healthLoss = 1;
			}
	}
}

function onSectionHit()
{
	if (mustHitSection)
	{
		defaultCamZoom = 0.35;
		if (pet?.alpha == 0) FlxTween.tween(pet, {alpha: 1}, 0.7);
		if (boyfriend.alpha == 0) FlxTween.tween(boyfriend, {alpha: 1}, 0.7);
	}
	else if (!mustHitSection)
	{
		defaultCamZoom = 0.6;
		if (pet?.alpha == 1) FlxTween.tween(pet, {alpha: 0}, 0.7);
		if (boyfriend.alpha == 1) FlxTween.tween(boyfriend, {alpha: 0}, 0.7);
	}
}

function onUpdatePost(elapsed:Float):Void
{
	playHUD.iconP1.x = 1000;
	playHUD.iconP2.x = 125;
}

function opponentNoteHit(note)
{
	if (health > 0.2) health -= (0.015 * healthLoss);
}

function onGameOver()
{
	KillNotes();
	audio.inst.stop();
	audio.playerVolume = 0;
	audio.opponentVolume = 0;

	FlxG.resetState();
	return Function_Stop;
}