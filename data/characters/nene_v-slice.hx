import funkin.vis.dsp.SpectralAnalyzer;
import funkin.vis.audioclip.frontends.LimeAudioClip;
using Lambda;

var ext = 'characters/neneshit/abot/';
var lookingLeft = false;

var abot;
var a_bot_eyes;

var noAbotStages = ['ejected', 'ejectedErected', 'danger'];
var floatingStages = ['ejected', 'ejectedErected'];

var nene_laugh;

var yollowExploding = ['D\'low', 'D\'low (Pico Mix)'];

var analyzer:SpectralAnalyzer;
var analyzerLevelsCache:Array<Bar> = [];
var vizGroup:FlxSpriteGroup = new FlxSpriteGroup();
var BAR_COUNT = 7;

function initAnalyzer() {
	analyzer = new SpectralAnalyzer(inst._channel.__audioSource, BAR_COUNT, 0.1, 40);
	analyzer.minDb = -65;
	analyzer.maxDb = -25;
	analyzer.maxFreq = 22000;
	analyzer.minFreq = 10;
}

function drawFFT():Void
{
	analyzerLevelsCache = (analyzer != null) ? analyzer.getLevels() : getDefaultLevels();

	for (i in 0...Math.min(vizGroup.members.length, analyzerLevelsCache.length))
	{
		var animFrame:Int = Math.round(analyzerLevelsCache[i].value * 6);

		// don't display if we're at 0 volume from the level
		vizGroup.members[i].visible = animFrame > 0;

		// decrement our animFrame, so we can get a value from 0-5 for animation frames
		animFrame -= 1;

		animFrame = Math.floor(Math.min(5, animFrame));
		animFrame = Math.floor(Math.max(0, animFrame));

		animFrame = Std.int(Math.abs(animFrame - 5)); // shitty dumbass flip, cuz dave got da shit backwards lol!

		vizGroup.members[i].animation.curAnim.curFrame = animFrame;
	}
}

function getDefaultLevels():Array<Bar>
{
	var result:Array<Bar> = [];

	for (i in 0...BAR_COUNT)
	{
		result.push({value: 0, peak: 0.0});
	}

	return result;
}

function onSongStart() {
	initAnalyzer();
}

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "maroon":
			changeCharacter("nene_v-slice-christmas", 2);
	}

	if (noAbotStages.contains(PlayState.SONG.stage))
	{
		platformFloat();
		return;
	}

	abot = new FlxSpriteGroup();
	gfGroup.insert(0, abot);

	abot_eyeWhites = new FlxSprite(-380, 730).makeGraphic(160, 60, 0xffffffff);
	abot.add(abot_eyeWhites);

	abot_eyeWhitesDark = new FlxSprite(-380, 730).makeGraphic(160, 60, 0xff6f96ce);
	abot.add(abot_eyeWhitesDark);
	abot_eyeWhitesDark.alpha = 0;

	a_bot_eyes = new FunkinSprite(-355, 740).loadAtlas('${ext}systemEyes', null, PathsTestMode.LOOSE);
	a_bot_eyes.addAnimByPrefix('move', '', 24, false);
	abot.add(a_bot_eyes);

	a_bot_eyes.anim.onFrameChange.add(function(name:String, frameNumber:Int, frameIndex:Int) {
		if (frameNumber == 16) a_bot_eyes.anim.pause(); // totally didnt steal this from idks modpack what are you taaaaaaalking about-
	});

	a_bot_screen = new FlxSprite(-250, 540).loadGraphic(Paths.image('${ext}stereoBG', null, null, PathsTestMode.LOOSE));
	abot.add(a_bot_screen);

	a_bot_screenDark = new FlxSprite(-250, 540).loadGraphic(Paths.image('${ext}stereoBG', null, null, PathsTestMode.LOOSE));
	a_bot_screenDark.color = 0xFF616785;
	abot.add(a_bot_screenDark);
	a_bot_screenDark.alpha = 0;

	abot.add(vizGroup);

	a_bot = new FunkinSprite(-410, 500).loadAtlas('${ext}abotSystem', null, PathsTestMode.LOOSE);
	a_bot.addAnimByPrefix('idle', '', 24, false);
	abot.add(a_bot);

	a_botDark = new FunkinSprite(-410, 500).loadAtlas('${ext}dark/abotSystem', null, PathsTestMode.LOOSE);
	a_botDark.addAnimByPrefix('idle', '', 24, false);
	abot.add(a_botDark);
	a_botDark.alpha = 0;

	abot.x = parent.x + 300;
	abot.y = parent.y - 117;

	nene_laugh = FlxG.sound.load(Paths.sound('darnell/nene_laugh', null, PathsTestMode.LOOSE));

	var vizFrames = Paths.getSparrowAtlas('${ext}/aBotViz', null, PathsTestMode.LOOSE);
	var positionX = [0, 59, 56, 66, 54, 52, 51];
	var positionY = [0, -8, -3.5, -0.4, 0.5, 4.7, 7];
	for (i in 1...BAR_COUNT + 1)
	{
		var viz = new FunkinSprite();
		viz.frames = vizFrames;
		vizGroup.add(viz);
		var sum = function(num:Float, total:Float) return total += num;
    var posX:Float = positionX.slice(0, i).fold(sum, 0);
		var posY:Float = positionY.slice(0, i).fold(sum, 0);
		viz.x = posX;
		viz.y = posY;

		var visStr = 'viz';
		viz.animation.addByPrefix('VIZ', '$visStr${i}0', 0);
		viz.animation.play('VIZ', false, false, 1);
	}

	lookLeft();
}

function platformFloat()
{
	platformGF = new FlxSprite(75, 315);
	platformGF.frames = Paths.getSparrowAtlas('stages/common/platform');
	platformGF.animation.addByPrefix('bop', 'floating', 24, true);
	platformGF.animation.play('bop');

	platformGF.shader = parent.shader;
	gfGroup.insert(0, platformGF);

	if (PlayState.SONG.stage == 'danger') return;

	FlxG.signals.postUpdate.addOnce(function() {
		platformGF.scrollFactor.set(0.7, 0.7);
	});
}

function onSectionHit()
{
	if (noAbotStages.contains(PlayState.SONG.stage)) return;

	if (mustHitSection)
	{
		if (lookingLeft)
		{
			lookRight();
		}
	}
	else
	{
		if (!lookingLeft)
		{
			lookLeft();
		}
	}
}

function lookLeft()
{
	lookingLeft = true;
	a_bot_eyes.playAnim('move', true, false, 0);
}

function lookRight()
{
	lookingLeft = false;
	a_bot_eyes.playAnim('move', true, false, 17);
}

function onEvent(ev, v1, v2)
{
	switch (ev)
	{
		case 'Legacy':
		{
			switch (v1)
			{
				case 'bye gf':
				FlxTween.tween(platformGF, {x: platformGF.x - 3500}, 4, {ease: FlxEase.quartIn, onComplete: function() platformGF.kill()});
			}
		}

		case 'Lights out':
			if (v1 == '2' /* ????? */ || (v1 == '1' && !ClientPrefs.flashing)) return;

			a_botDark.alpha = 1;
			a_bot_screenDark.alpha = 1;
			abot_eyeWhitesDark.alpha = 1;

		case 'Lights on':
			if (v1 == '1' && !ClientPrefs.flashing) return;

			a_botDark.alpha = 0;
			a_bot_screenDark.alpha = 0;
			abot_eyeWhitesDark.alpha = 0;
	}
}

function onUpdate(elapsed) {
	drawFFT();
}

function onUpdatePost()
{
	if (floatingStages.contains(PlayState.SONG.stage)) return FlxTween.cancelTweensOf(gf);

	if (noAbotStages.contains(PlayState.SONG.stage)) return;

	for (i in [abot_eyeWhites, a_bot_eyes, a_bot_screen, a_bot])
	{
		i.shader = gf.shader;
		i.color = gf.color;
	}

	// abot.alpha = gf.alpha;
	// abot.visible = gf.visible;
}

function onCountdownTick(counter)
{
	if (counter % parent.danceEveryNumBeats == 0 && counter != 4)
	{
		a_bot.animation.play('idle', true);
		a_botDark.animation.play('idle', true);
	}
}

function onBeatHit()
{
	if (curBeat % parent.danceEveryNumBeats == 0)
	{
		a_bot.animation.play('idle', true);
		a_botDark.animation.play('idle', true);
	}

	if (!yollowExploding.contains(PlayState.SONG.song)) return;

	if (curBeat == 356)
	{
		parent.playAnimForDuration('drop70', 2, true);
		parent.specialAnim = true;
		nene_laugh.play();
	}
}