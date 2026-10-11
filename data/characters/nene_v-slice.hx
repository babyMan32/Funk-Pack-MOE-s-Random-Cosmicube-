import funkin.audio.visualize.PolygonSpectogram;
import funkin.audio.visualize.SpectogramSprite.SPECDIRECTION;

var ext = 'characters/neneshit/abot/';
var lookingLeft = false;

var abot;
var a_bot_eyes;

var noAbotStages = ['ejected', 'ejectedErected', 'danger'];
var floatingStages = ['ejected', 'ejectedErected'];

var nene_laugh;

var yollowExploding = ['D\'low', 'D\'low (Pico Mix)'];

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

	instVis = new PolygonSpectogram(audio.inst, null, 480, null, SPECDIRECTION.HORIZONTAL);
	abot.add(instVis);
	instVis.x = gf.x - 300;
	instVis.y = gf.y + 725;

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