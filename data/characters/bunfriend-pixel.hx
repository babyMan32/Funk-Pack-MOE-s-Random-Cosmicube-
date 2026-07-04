function onEndSong()
{
	if (boyfriend.curCharacter != 'bunfriend-pixel') return;

	boyfriend.idleSuffix = '-win';
	boyfriend.playAnim('idle-win');
	camFollow.setPosition(bfOff[0], bfOff[1]);
}