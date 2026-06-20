import flixel.group.FlxTypedSpriteGroup;
import funkin.FunkinAssets;

var micCanTurnOn = false;

var ext:String = "characters/vs_cord/";
var mic:FlxSprite;
var frames = Paths.getSparrowAtlas(ext + 'note');
var previousNote:Int = -1;
var container = new FlxTypedSpriteGroup();

var micPlatform:Bool = false;
var killMic:Bool = false;
var stepToNormal:Int = 128;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		case "danger":
			micPlatform = true;
			boyfriend.x += 80;
			boyfriend.y += 10;

		case "voting":
			killMic = true;
			boyfriend.x += 120;
			boyfriend.y += 50;

		case "pretender", "security2":
			killMic = true;
	}
}

var stepData;
var defaultStep = 127;
var useDefaultStep = false;

function onCreatePost()
{
	var path = Paths.json('catSuffixes-' + Paths.sanitize(songName));

	if (FunkinAssets.exists(path))
	{
		stepData = FunkinAssets.parseJson(FunkinAssets.getContent(path)).changes;		
	}
	else
	{
		useDefaultStep = true;
	}

	mic = new FlxSprite().loadGraphic(Paths.image(ext + 'mic'));
	mic.scale.set(0.8, 0.8);
	mic.updateHitbox();
	mic.x -= 200;
	mic.y += 580;
	boyfriendGroup.insert(10, container);
	boyfriendGroup.insert(0, mic);
	container.x = boyfriend.x - 40;
	container.y = boyfriend.y + 300;

	if (micPlatform)
	{
		platformCatMic = new FlxSprite(1190, 350);
		platformCatMic.frames = Paths.getSparrowAtlas('stages/common/platform');
		platformCatMic.animation.addByPrefix('bop', 'danger', 24, true);
		platformCatMic.scale.set(0.5, 0.5);
		platformCatMic.animation.play('bop');

		stage.insert(stage.members.indexOf(boyfriendGroup) - 1, platformCatMic);

		createBfPlatform();

		FlxG.signals.postUpdate.addOnce(function() {
			mic.y -= 200;
			container.x -= 150;
			platformCatMic.zIndex = boyfriend.zIndex - 10;
		});
	}

	if (killMic)
	{
		mic.kill();
		container.kill();
	}

	boyfriend.animSuffix = '-png';
}

function createBfPlatform()
{
	FlxG.signals.postUpdate.addOnce(function() {
		platform2 = new FlxSprite(1600, 350);
		platform2.frames = Paths.getSparrowAtlas('stages/common/platform');
		platform2.animation.addByPrefix('bop', 'danger', 24, true);
		platform2.animation.play('bop');

		stage.insert(stage.members.indexOf(boyfriendGroup) - 1, platform2);

		platform2.zIndex = boyfriend.zIndex - 5;
	});
}

var noteTimer = 0;
var noteCap = 2;

function onUpdatePost(e)
{
	noteTimer += e;

	if (micCanTurnOn)
	{
		if (noteTimer > noteCap)
		{
			noteCap = FlxG.random.float(0.7, 1.5);
			noteTimer = 0;
			
			spawnMusicNote();
		}
	}

	if (boyfriend.getAnimName() == 'idle')
	{
		micCanTurnOn = false;
	}

	mic.shader = container.shader = boyfriend.shader;
}

function goodNoteHit()
{
	micCanTurnOn = true;
}

function spawnMusicNote()
{
	var musicNote = container.recycle(FlxSprite, () -> new FlxSprite());
	musicNote.x = -10; musicNote.y = -90;

	musicNote.frames = frames;

	musicNote.scale.set(0.825, 0.825);
	musicNote.updateHitbox();
	musicNote.alpha = 1;

	musicNote.x += FlxG.random.int(-30, 30);
	musicNote.y += FlxG.random.int(-10, 30);

	musicNote.animation.frameIndex = 0;
	musicNote.animation.frameIndex = FlxG.random.int(0, musicNote.animation.numFrames - 1, [previousNote]);
	previousNote = musicNote.animation.frameIndex;

	container.add(musicNote);

	var spinLeft = FlxG.random.bool();

	musicNote.scale.x = 0;
	musicNote.scale.y = 0;
	musicNote.angle = FlxG.random.int(5, 10);
	musicNote.angularVelocity = 20;
	musicNote.velocity.set(FlxG.random.bool() ? 50 : -50, -50);

	if (spinLeft)
	{
		musicNote.angle *= -1;
		musicNote.angularVelocity *= -1;
	}

	FlxTween.tween(musicNote, {x: musicNote.x + (FlxG.random.bool() ? -20 : 20)}, 2, {ease: FlxEase.sineInOut, type: 4});

	FlxTween.tween(musicNote, {'scale.x': 0.825, 'scale.y': 0.825}, 1.5 + 0.4, {ease: FlxEase.cubeInOut});

	FlxTween.tween(musicNote, {alpha: 0}, 1.5,
	{
		startDelay: 0.4,
		onComplete: Void -> {
			FlxTween.cancelTweensOf(musicNote, ['x', 'scale.x', 'scale.y']);
			musicNote.kill();
		}
	});
}

var prevAfterimages:Bool;

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			switch (value1)
			{
				case 'kill':
					mic.kill();
					container.kill();

				case 'bye gf':
					FlxTween.tween(mic, {x: -2000, y: 550}, 6, {ease: FlxEase.quartIn});
					FlxTween.tween(container, {x: -2000, y: 550}, 6, {ease: FlxEase.quartIn});
					FlxTween.tween(platformCatMic, {x: -2280, y: 650}, 6, {ease: FlxEase.quartIn});
			}

		case 'Defeat Retro':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;
			
			switch (charType)
			{
				case 0:
					prevAfterimages = boyfriend.ghostsEnabled;

					boyfriend.animSuffix = '-png';

					boyfriend.ghostsEnabled = false;

				case 1:
					boyfriend.animSuffix = '';

					boyfriend.ghostsEnabled = prevAfterimages;
			}
	}
}

function onBeatHit()
{
	if (micPlatform)
	{
		if (curBeat == 416)
		{
			FlxTween.tween(boyfriend, {x: 3000}, 2, {ease: FlxEase.quartIn});
			FlxTween.tween(platform2, {x: 3000}, 2, {ease: FlxEase.quartIn});
		}
	}
}

function onStepHit()
{
	if (stepData == null || stepData?.length == 0)
	{
		if (useDefaultStep && curStep >= defaultStep)
		{
			boyfriend.animSuffix = "";
		}

		return;
	}

	if (curStep >= stepData[0].step)
	{
		var step = stepData.shift();
		boyfriend.animSuffix = step.prefix;
	}
}