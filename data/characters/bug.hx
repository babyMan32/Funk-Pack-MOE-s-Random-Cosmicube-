var o_dear = false;

function onBeatHit()
{
	if (curSong != 'D\'low') return;

	if (curBeat == 356)
	{
		o_dear = true;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!o_dear) return;

	playHUD.iconP1.animation.curAnim.curFrame = 1;
}