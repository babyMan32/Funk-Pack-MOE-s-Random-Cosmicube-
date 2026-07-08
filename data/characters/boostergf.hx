function noteMiss(note)
{
	if (gf.curCharacter != 'boostergf') return;

	if (game.combo >= 100)
	{
		FlxG.signals.postUpdate.addOnce(function() {
			gf.playAnim('cringe', true);

			gf.specialAnim = true;
		});
	}
}