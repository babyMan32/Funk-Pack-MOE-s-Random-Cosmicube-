public var bfLegs:Character;
var bfAnchorPoint:Array<Float> = [0, 0];
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];
var runningFriend = false;

var dialogueRunningFriend = false;
var madnessRunningFriend = false;

var evilDyingThing:FlxSprite;

function onLoad()
{
	if (ClientPrefs.bfSkin == "bf-dialogue" && PlayState.SONG.stage == "danger")
	{
		runningFriend = dialogueRunningFriend = true;
		bfLegs = new Character(0, 0, 'bf-legs', true);
		boyfriendGroup.insert(boyfriendGroup.members.indexOf(bfLegs) + 1, bfLegs);
	}

	if (ClientPrefs.bfSkin == "bfMADNESSnew" && PlayState.SONG.stage == "danger")
	{
		runningFriend = madnessRunningFriend = true;
		bfLegs = new Character(0, 0, 'bf_demise_legs', true);
		boyfriendGroup.insert(boyfriendGroup.members.indexOf(bfLegs) + 1, bfLegs);

		bfArm = new Character(0, 0, 'bf_demise_arm', true);
		boyfriendGroup.insert(boyfriendGroup.members.indexOf(bfArm) + 1, bfArm);
	}
}

function onCreatePost()
{
	if (!runningFriend) return;

	iconP1.y = madnessRunningFriend ? 585 : 575;
	iconP1.flipX = !madnessRunningFriend;

	bfLegs.x = game.boyfriend.x;
	bfLegs.y = game.boyfriend.y;
	bfAnchorPoint[0] = game.boyfriend.x;
	bfAnchorPoint[1] = game.boyfriend.y;

	if (madnessRunningFriend)
	{
		bfLegs.x -= 100;
		bfLegs.y += 150;

		bfArm.x = game.boyfriend.x - 30;
		bfArm.y = game.boyfriend.y + 110;
	}

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
}

function onUpdate(elapsed)
{
	if (!runningFriend) return;

	if (madnessRunningFriend)
	{
		if (boyfriend.getAnimName() == "danceLeft" || boyfriend.getAnimName() == "danceRight")
		{
			bfArm.visible = true;
		}
		else
		{
			bfArm.visible = false;
		}
	}

	if (dialogueRunningFriend)
	{
		game.boyfriend.y = bfAnchorPoint[1] + legPosY[bfLegs.animation.curAnim.curFrame];

		// This changes the legs from the miss version to the normal one and makes sure it starts on the same animation frame where it left off
		if (!StringTools.contains(game.boyfriend.animation.curAnim.name, 'miss') && StringTools.contains(bfLegs.animation.curAnim.name, 'miss'))
		{
			var lastFrame:Int = 0;
			lastFrame = bfLegs.animation.curAnim.curFrame;
			bfLegs.idleSuffix = '';
			bfLegs.recalculateDanceIdle();
			bfLegs.animation.curAnim.curFrame = lastFrame;
		}
	}
	
	// Ensures that the arms and legs r always opposite from each other and only updates If bf is in his idle anim
	if (StringTools.contains(game.boyfriend.animation.curAnim.name, 'dance'))
	{
		game.boyfriend.danced = bfLegs.danced;
		game.boyfriend.animation.curAnim.curFrame = bfLegs.animation.curAnim.curFrame;
	}

	mathForAlpha = 2 * (0.5 - health);

	evilDyingThing.alpha = FlxMath.lerp(evilDyingThing.alpha, mathForAlpha + 1, 0.1);
	evilDyingThingLayer2.alpha = FlxMath.lerp(evilDyingThingLayer2.alpha, mathForAlpha, 0.1);
}

function onKeyRelease()
{
	if (!runningFriend) return;

	game.boyfriend.danced = bfLegs.danced;
}

function onCountdownTick()
{
	if (!runningFriend) return;

	bfLegs.dance();

	if (madnessRunningFriend)
	{
		bfArm.dance();
	}
}

function onBeatHit()
{
	if (!runningFriend) return;

	if (curBeat % 1 == 0)
	{
		bfLegs.dance();

		if (madnessRunningFriend)
		{
			bfArm.dance();
		}
	}

	switch (curBeat)
	{
		case 416:
			FlxTween.tween(boyfriend, {x: boyfriend.x + 2500}, 4, {ease: FlxEase.quartIn, onComplete: function() boyfriend.kill()});
			FlxTween.tween(bfLegs, {x: bfLegs.x + 2500}, 4, {ease: FlxEase.quartIn, onComplete: function() bfLegs.kill()});

			if (madnessRunningFriend)
			{
				FlxTween.tween(bfArm, {x: bfArm.x + 2500}, 4, {ease: FlxEase.quartIn, onComplete: function() bfArm.kill()});
			}
	}
}

// This changes the legs from the normal version to the miss version and makes sure it starts on the same animation frame where it left off
function noteMiss(daNote)
{
	if (!dialogueRunningFriend) return;

	var lastFrame:Int = 0;
	
	lastFrame = bfLegs.animation.curAnim.curFrame;
	bfLegs.idleSuffix = 'miss';
	bfLegs.recalculateDanceIdle();
	bfLegs.animation.curAnim.curFrame = lastFrame;
}