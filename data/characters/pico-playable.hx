import funkin.FunkinAssets;

var songSoundData;

var playShoot = false;
var boom = false;

var killedPlay = false;
var killedOpp = false;

var firstNote = true;

var bloodPos;

var startBloodPool = false;

var blodSped = 3;

var bloooooood:FunkinSprite;

var specialFuck;

function onCreatePost()
{
	specialFuck = boyfriend.getFlag('variants').monotone;

	if (dad.curCharacter != specialFuck) return;

	playShoot = FlxG.random.bool();
	boom = FlxG.random.bool(8);

	var path = Paths.json('pico-sounds/' + Paths.sanitize(songName), null, PathsTestMode.LOOSE);

	addCharacterToList('pico-dopple-playable', 0);
	addCharacterToList('pico-dopple-opponent', 1);

	if (FunkinAssets.exists(path))
	{
		if (!boom) songSoundData = FunkinAssets.parseJson(FunkinAssets.getContent(path)).times;
		else if (boom) songSoundData = FunkinAssets.parseJson(FunkinAssets.getContent(path)).times_dead;
	}

	bloodPos = playShoot ? [dad.x - 192, dad.y + 445] : [boyfriend.x + 516, boyfriend.y + 445];

	bloooooood = new FunkinSprite(bloodPos[0], bloodPos[1]).loadAtlas('characters/dopple/bloodPool');
	bloooooood.updateHitbox();
	stage.insert(stage.members.indexOf(dadGroup) - 0, bloooooood);
	bloooooood.alpha = 0.0001;
}

function onStepHit()
{
	if (songSoundData != null && songSoundData?.length != 0)
	{
		if (curStep >= songSoundData[0].step)
		{
			var step = songSoundData.shift();
			FlxG.sound.play(Paths.sound('cutscene/' + step.sfx));
		}
	}
}

function onBeatHit()
{
	if (dad.curCharacter != specialFuck && dad.curCharacter != 'pico-dopple-opponent') return;

	switch (curBeat)
	{
		case 8:
			changeCharacter('pico-dopple-playable', 0);
			changeCharacter('pico-dopple-opponent', 1);

			killedPlay = false;
			killedOpp = false;

			if (playShoot)
			{
				boyfriend.playAnim('intro-shoot');
				dad.playAnim(boom ? 'intro-death' : 'intro');
				killedOpp = boom;

				dad.animation.onFinish.add((animName) -> {
					if (animName == 'intro-death')
					{
						dad.animation.play('death', true);
						startBloodPool = true;
						bloooooood.alpha = 1;
						dad.stunned = true;
					}
				});
			}
			else
			{
				boyfriend.playAnim(boom ? 'intro-death' : 'intro');
				dad.playAnim('intro-shoot');
				killedPlay = boom;

				boyfriend.animation.onFinish.add((animName) -> {
					if (animName == 'intro-death')
					{
						boyfriend.animation.play('death', true);
						boyfriend.stunned = true;
						startBloodPool = true;
						bloooooood.alpha = 1;
						health = 0;
					}
				});
			}

		case 46:
			if (!killedPlay) changeCharacter('pico-playable', 0);
			if (!killedOpp) changeCharacter('pico', 1);

			dad.vSliceSustains = false;
	}
}

function onSpawnNote(note)
{
	if (note.lane == 0 && killedPlay)
	{
		note.ignoreNote = true;
	}

	if (note.lane == 1 && killedOpp && !firstNote)
	{
		note.ignoreNote = true;
	}

	firstNote = false;
}

function onUpdatePost(elapsed:Float):Void
{
	if (killedOpp && dad.curCharacter != 'pico-dopple-opponent')
	{
		changeCharacter('pico-dopple-opponent', 1);
		dad.playAnim('death');
		playHUD.scoreTxt.color = dad.healthColour;
	}

	if (startBloodPool)
	{
		amt = (elapsed / blodSped);

		bloooooood.scale.x += amt;
		bloooooood.scale.y += amt;

		bloooooood.x -= amt;
		bloooooood.y += elapsed * blodSped;
	}

	if (bloooooood?.scale?.x >= 25 && startBloodPool)
	{
		startBloodPool = false;

		if (killedOpp)
		{
			if (dad.library != null)
			{
				var blood = dad.library.getSymbol('blood stream ');

				if (blood != null)
				{
					blood.timeline.layers[0].forEachFrame((frame) -> {
						for (i in frame.elements) i.visible = false;
					});
				}
			}
		}

		if (killedPlay)
		{
			if (boyfriend.library != null)
			{
				var blood = boyfriend.library.getSymbol('blood stream ');

				if (blood != null)
				{
					blood.timeline.layers[0].forEachFrame((frame) -> {
						for (i in frame.elements) i.visible = false;
					});
				}
			}
		}
	}
}