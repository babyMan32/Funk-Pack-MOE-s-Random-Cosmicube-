import funkin.FunkinAssets;

var songSoundData;

var playShoot = false;
var boom = false;

var killedPlay = false;
var killedOpp = false;

var bleedPlay = false;
var bleedOpp = false;

var firstNote = true;

var bloodPos;

var startBloodPool = false;

var blodSped = 3;

function onCreatePost()
{
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
	stage.insert(stage.members.indexOf(dadGroup) - 1, bloooooood);
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
	if (curSong != 'Identity Crisis') return;

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

					if (animName == 'death')
					{
						bleedOpp = true;
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
					}

					if (animName == 'death')
					{
						bleedPlay = true;
					}
				});
			}

		case 46:
			if (!killedPlay) changeCharacter('pico-playable', 0);
			if (!killedOpp) changeCharacter('pico', 1);
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
	}

	if (startBloodPool)
	{
		amt = (elapsed / blodSped);

		bloooooood.scale.x += amt;
		bloooooood.scale.y += amt;

		bloooooood.x -= amt;
		bloooooood.y += elapsed * blodSped;
	}
}