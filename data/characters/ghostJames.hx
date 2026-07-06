var baseY;

function onCreatePost()
{
	if (boyfriend.curCharacter != 'ghostJames') return;

	baseY = boyfriend.y;
	camGame.alpha = 0;
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