var baseY;

function onCreatePost()
{
	if (!baddieExists) return;

	if (gf.curCharacter != 'jackonene') return;

	baseY = gf.y;
}

function onUpdatePost(elapsed:Float):Void
{
	if (!baddieExists) return;

	if (gf.curCharacter != 'jackonene') return;

	songPos = Conductor.songPosition;

	currentBeat = (songPos / 5000) * (Conductor.bpm / 40);

	gf.y = baseY - 60 * Math.sin((currentBeat + 12 * 12) * Math.PI);
}