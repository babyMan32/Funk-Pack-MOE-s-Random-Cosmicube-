var allow_attack = true;
var killed_yellow = false;
var killed_jor = false;
var threatening;

function onCreatePost()
{
	if (boyfriend.curCharacter == 'pico_due_p2')
	{
		threatening = FlxG.sound.load(Paths.sound('hankshoot', null, PathsTestMode.LOOSE));
	}
}

function onUpdate(elapsed:Float):Void
{
	if (game.endingSong)
	{
		allow_attack = false;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (controls.NOTE_TAUNT_P)
	{
		picoAttack();
	}

	if (boyfriend.getAnimName() != 'spam' && !game.endingSong)
	{
		allow_attack = true;
	}
}

function picoAttack()
{
	if (boyfriend.curCharacter == 'pico_due_p2' && allow_attack && !game.startingSong)
	{
		threatening.play(true);
		boyfriend.playAnim('gunblast', true);
		boyfriend.specialAnim = true;

		if (!cpuControlled)
		{
			boyfriend.holding = true;
		}

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

			setSongTime(125.64 * 1000);
			clearNotesBefore(Conductor.songPosition);
		}

		if (dad.curCharacter == 'jorsawsee' && PlayState.SONG.song == 'O2' && !killed_jor)
		{
			killed_jor = true;

			setSongTime(45.37 * 1000);
			clearNotesBefore(Conductor.songPosition);

			camGame.alpha = 0;

			new FlxTimer().start(0.85, function(_) camGame.alpha = 1);
		}

		allow_attack = false;
	}
}