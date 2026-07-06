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
}

function onSongStart()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	FlxTween.tween(camGame, {alpha: 1}, 1.5, {ease: FlxEase.sineOut});
}

function onBeatHit()
{
	if (hahaRareChance && curBeat % 2 == 0)
	{
		boyfriend.playAnim('idle', true);
	}
}