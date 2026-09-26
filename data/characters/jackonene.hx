var baseY;

function onCreatePost()
{
	if (!baddieExists) return;

	if (parent.curCharacter != 'jackonene') return;

	baseY = parent.y;
}

function onUpdatePost(elapsed:Float):Void
{
	if (!baddieExists) return;

	if (parent.curCharacter != 'jackonene') return;

	songPos = Conductor.songPosition;

	currentBeat = (songPos / 5000) * (Conductor.bpm / 40);

	parent.y = baseY - 60 * Math.sin((currentBeat + 12 * 12) * Math.PI);
}