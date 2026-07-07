var baseY;
var hahaRareChance = false;

function onLoad()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	healthLoss = 0;
}

function onCreatePost()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	baseY = boyfriend.y;
	camGame.alpha = 0;

	hahaRareChance = FlxG.random.bool(10);

	if (hahaRareChance)
	{
		boyfriend.stunned = true;
		boyfriend.canTaunt = false;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (curStep > 0)
	{
		if (boyfriend.curCharacter != 'ghostJames') return;

		songPos = Conductor.songPosition;

		currentBeat = (songPos / 5000) * (Conductor.bpm / 60);

		boyfriend.y = baseY - 50 * Math.sin((currentBeat + 12 * 12) * Math.PI);
	}

	if (boyfriend.alpha > 1)
	{
		boyfriend.alpha = 1;
	}

	if (boyfriend.alpha <= 0 && !game.endingSong)
	{
		KillNotes();
		PlayState.instance.audio?.stop();
		FlxG.resetState();
	}

	if (hahaRareChance)
	{
		cpuControlled = false;
	}
}

function onSongStart()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	FlxTween.tween(camGame, {alpha: 1}, 1.5, {ease: FlxEase.sineOut});
}

function onEndSong()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	FlxTween.tween(boyfriend, {alpha: 0}, 1.5, {ease: FlxEase.sineIn});
}

function onStepHit()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	if (curStep % 2 == 0)
	{
		if (game.endingSong)
		{
			boyfriend.playAnim('hey', true);
		}
	}
}

function onBeatHit()
{
	if (!hahaRareChance) return;

	if (curBeat % 2 == 0)
	{
		boyfriend.playAnim('idle', true);

		if (FlxG.random.bool(30))
		{
			boyfriend.playAnim('hey', true);
		}
	}
}

function goodNoteHit(note)
{
	if (boyfriend.alpha < 1)
	{
		boyfriend.alpha += 0.01;
	}
}

function noteMiss(note)
{
	FlxG.signals.postUpdate.addOnce(function() {
		audio.playerVolume = 1;
	});

	if (hahaRareChance) return;

	boyfriend.playAnim('hey', true);
	boyfriend.specialAnim = boyfriend.holding = true;
	boyfriend.alpha -= 0.01;
}