var allow_attack = true;
var killed_yellow = false;

function onUpdatePost(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'pico_due_p2' && allow_attack && !game.startingSong)
	{
		boyfriend.playAnim('gunblast', true);
		boyfriend.specialAnim = boyfriend.holding = true;

		if (!killed_yellow)
		{
			dad.playAnim('singLEFT', true);
			dad.specialAnim = true;

			health += 0.15;
		}

		if (dad.curCharacter == 'yellow' && PlayState.SONG.song == 'D\'low' && !killed_yellow)
		{
			dad.playAnim('death', true);
			dad.specialAnim = killed_yellow = true;

			setSongTime(125 * 1005);
			clearNotesBefore(Conductor.songPosition);
		}

		allow_attack = false;
	}

	if (boyfriend.getAnimName() != 'gunblast' && !game.endingSong)
	{
		allow_attack = true;
	}
}