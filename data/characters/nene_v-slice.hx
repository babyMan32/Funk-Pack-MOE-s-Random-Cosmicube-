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
	if (noAbotStages.contains(PlayState.SONG.stage))
	{
		platformFloat();
		return;
	}

	abot = new FlxSpriteGroup();
	gfGroup.insert(0, abot);

	abot_eyeWhites = new FlxSprite(-380, 730).makeGraphic(160, 60, 0xffffffff);
	abot.add(abot_eyeWhites);

	a_bot_eyes = new FunkinSprite(-355, 740).loadAtlas('${ext}systemEyes', null, PathsTestMode.LOOSE);
	a_bot_eyes.addAnimByPrefix('move', '', 24, false);
	abot.add(a_bot_eyes);

	a_bot_eyes.anim.onFrameChange.add(function(name:String, frameNumber:Int, frameIndex:Int) {
		if (frameNumber == 16)
			a_bot_eyes.anim.pause(); // totally didnt steal this from idks modpack what are you taaaaaaalking about-
	});

	a_bot_screen = new FlxSprite(-250, 540).loadGraphic(Paths.image('${ext}stereoBG', null, null, PathsTestMode.LOOSE));
	abot.add(a_bot_screen);

	a_bot = new FunkinSprite(-410, 500).loadAtlas('${ext}abotSystem', null, PathsTestMode.LOOSE);
	abot.add(a_bot);

	abot.x = gf.x + 300;
	abot.y = gf.y - 117;

	nene_laugh = FlxG.sound.load(Paths.sound('darnell/nene_laugh', null, PathsTestMode.LOOSE));

	switch (PlayState.SONG.stage)
	{
		case "maroon":
			changeCharacter("nene_v-slice-christmas", 2);
	}

	lookLeft();
}

function platformFloat()
{
	platformGF = new FlxSprite(75, 315);
	platformGF.frames = Paths.getSparrowAtlas('stages/common/platform');
	platformGF.animation.addByPrefix('bop', 'floating', 24, true);
	platformGF.animation.play('bop');

	platformGF.shader = gf.shader;
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

function goodNoteHit(note)
{
	if (note.isSustainNote) return;

	FlxG.signals.postUpdate.addOnce(function() {
		comboAnim = 'combo' + game.combo;

		if (gf.hasAnim(comboAnim))
		{
			gf.playAnim(comboAnim, true);
			gf.specialAnim = true;
		}
	});
}

function onEvent(ev, v1, v2)
{
	if (ev == 'Legacy')
	{
		switch (v1)
		{
			case 'bye gf':
				FlxTween.tween(platformGF, {x: platformGF.x - 3500}, 4, {ease: FlxEase.quartIn, onComplete: function() platformGF.kill()});
		}
	}
}

function onUpdatePost()
{
	if (floatingStages.contains(PlayState.SONG.stage))
		return FlxTween.cancelTweensOf(gf);

	if (noAbotStages.contains(PlayState.SONG.stage)) return;

	for (i in [abot_eyeWhites, a_bot_eyes, a_bot_screen, a_bot])
	{
		i.shader = gf.shader;
	}

	abot.color = gf.color;
	abot.alpha = gf.alpha;
	abot.visible = gf.visible;
}

function noteMiss(note)
{
	if (game.combo >= 70)
	{
		gf.playAnim('drop70', true);
		gf.specialAnim = true;
	}
}

function onBeatHit()
{
	if (!yollowExploding.contains(PlayState.SONG.song)) return;

	if (curBeat == 356)
	{
		gf.playAnimForDuration('drop70', 2, true);
		gf.specialAnim = true;
		nene_laugh.play();
	}
}