var madnessPicoRunningFriend = false;

function onCreatePost()
{
	if ((boyfriend.curCharacter == "pico_due_p1" || boyfriend.curCharacter == "pico_due_p2") && (PlayState.SONG.stage == "danger" || PlayState.SONG.stage == "danger-erect"))
	{
		changeCharacter('pico_overdue_body', 0);

		madnessPicoRunningFriend = true;
	}

	if (boyfriend.curCharacter == "pico_overdue_body")
	{
		picoLegs = new Character(0, 0, 'pico_overdue_legs', true);
		boyfriendGroup.insert(boyfriendGroup.members.indexOf(picoLegs) + 1, picoLegs);

		picoArm = new Character(0, 0, 'pico_overdue_arm', true);
		boyfriendGroup.insert(boyfriendGroup.members.indexOf(picoArm) + 1, picoArm);

		picoLegs.x = game.boyfriend.x - 55;
		picoLegs.y = game.boyfriend.y + 275;

		picoArm.x = game.boyfriend.x + 60;
		picoArm.y = game.boyfriend.y + 50;
	}

	evilness();
}

function evilness()
{
	if (!madnessPicoRunningFriend) return;

	evilDyingThing = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/vignette', null, null, PathsTestMode.LOOSE));
	evilDyingThing.scale.x = 1.01;
	evilDyingThing.camera = PlayState.instance.camOther;
	evilDyingThing.antialiasing = false;
	evilDyingThing.screenCenter();
	evilDyingThing.updateHitbox();
	add(evilDyingThing);

	evilDyingThingLayer2 = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/vignettedarker', null, null, PathsTestMode.LOOSE));
	evilDyingThingLayer2.scale.x = 1.01;
	evilDyingThingLayer2.camera = PlayState.instance.camOther;
	evilDyingThingLayer2.antialiasing = false;
	evilDyingThingLayer2.screenCenter();
	evilDyingThingLayer2.updateHitbox();
	add(evilDyingThingLayer2);

	iconP1.y = 585;
	iconP1.flipX = true;
}

function onUpdate(elapsed)
{
	if (!madnessPicoRunningFriend) return;

	// Ensures that the arms and legs r always opposite from each other and only updates If bf is in his idle anim
	if (StringTools.contains(game.boyfriend.animation.curAnim.name, 'dance'))
	{
		game.boyfriend.danced = picoLegs.danced;
		game.boyfriend.animation.curAnim.curFrame = picoLegs.animation.curAnim.curFrame;
	}

	if (boyfriend.getAnimName() != 'singLEFT' && boyfriend.getAnimName() != 'singUP' && boyfriend.getAnimName() != 'singRIGHT')
	{
		picoArm.visible = false;
	}

	mathForAlpha = 2 * (0.5 - health);

	evilDyingThing.alpha = FlxMath.lerp(evilDyingThing.alpha, mathForAlpha + 1, 0.1);
	evilDyingThingLayer2.alpha = FlxMath.lerp(evilDyingThingLayer2.alpha, mathForAlpha, 0.1);
}

function goodNoteHit()
{
	if (!madnessPicoRunningFriend) return;

	if (boyfriend.getAnimName() == 'singLEFT' || boyfriend.getAnimName() == 'singUP' || boyfriend.getAnimName() == 'singRIGHT')
	{
		picoArm.visible = true;

		if (boyfriend.getAnimName() == 'singLEFT')
		{
			picoArm.playAnim('singLEFT', true);
		}

		if (boyfriend.getAnimName() == 'singUP')
		{
			picoArm.playAnim('singUP', true);
		}

		if (boyfriend.getAnimName() == 'singRIGHT')
		{
			picoArm.playAnim('singRIGHT', true);
		}
	}
}

function onKeyRelease()
{
	if (!madnessPicoRunningFriend) return;

	game.boyfriend.danced = picoLegs.danced;
}

function onCountdownTick()
{
	if (!madnessPicoRunningFriend) return;

	picoLegs.dance();
}

function onBeatHit()
{
	if (!madnessPicoRunningFriend) return;

	if (curBeat % 1 == 0)
	{
		picoLegs.dance();
	}

	switch (curBeat)
	{
		case 416:
			FlxTween.tween(boyfriend, {x: boyfriend.x + 2500}, 4, {ease: FlxEase.quartIn, onComplete: function() boyfriend.kill()});
			FlxTween.tween(picoLegs, {x: picoLegs.x + 2500}, 4, {ease: FlxEase.quartIn, onComplete: function() picoLegs.kill()});
			FlxTween.tween(picoArm, {x: picoArm.x + 2500}, 4, {ease: FlxEase.quartIn, onComplete: function() picoArm.kill()});
	}
}