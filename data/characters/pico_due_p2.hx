var allow_attack = true;
var killed_yellow = false;
var killed_jor = false;
var killed_dave = false;

var threatening;
var beeping;

var mechanic = false;
var attack = false;
var counter = 0;

var missed_dodges = 0;

using StringTools;

function onCreatePost()
{
	if (boyfriend.curCharacter == 'pico_due_p2')
	{
		threatening = FlxG.sound.load(Paths.sound('hankshoot', null, PathsTestMode.LOOSE));
		beeping = FlxG.sound.load(Paths.sound('ConfirmMenu'));
	}
}

function goodNoteHitPre(note)
{
	if (note.noteType == 'Hey!' || note.noteType == 'Cheer Note')
	{
		picoAttackSpecial();
		note.noAnimation = true;
	}
}

function onSectionHit()
{
	if (boyfriend.curCharacter != 'pico_due_p2') return;

	if (!attack)
	{
		attack = FlxG.random.bool(10);
	}

	if (attack && !mechanic && !boyfriend.getAnimName().startsWith('sing') && !game.endingSong)
	{
		attack = false;
		mechanic = true;
		beeping.play(true);
		counter++;
	}
}

function onBeatHit()
{
	if (boyfriend.curCharacter != 'pico_due_p2') return;

	if (mechanic && !game.endingSong)
	{
		beeping.play(true);
		counter++;

		if (counter == 3)
		{
			if (cpuControlled) picoAttackSpecial();

			if (boyfriend.getAnimName() != 'gunblast' || boyfriend.getAnimName() == 'gunblast' && game.boyfriend.animation.curAnim.curFrame > 6)
			{
				missed_dodges++;

				health -= missed_dodges / 20;
			}

			counter = 0;
			mechanic = false;
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	if (game.endingSong || PlayState.instance.isDead)
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

	if (boyfriend.getAnimName() != 'gunblast' && !game.endingSong && !PlayState.instance.isDead)
	{
		allow_attack = true;
	}
}

function picoAttackSpecial() //Used for Botplay and certain triggers if the opponent can be killed by the "taunt"
{
	if (boyfriend.curCharacter == 'pico_due_p2' && allow_attack && !game.startingSong)
	{
		threatening.play(true);
		boyfriend.playAnim('gunblast', true);
		boyfriend.specialAnim = true;

		dad.playAnim('singLEFT', true);
		dad.specialAnim = true;

		health += 0.15;

		allow_attack = false;
	}
}

function picoAttack()
{
	if (inCutscene || cpuControlled) return;

	if (boyfriend.curCharacter == 'pico_due_p2' && allow_attack && !game.startingSong)
	{
		threatening.play(true);
		boyfriend.playAnim('gunblast', true);
		boyfriend.specialAnim = boyfriend.holding = true;

		if (!killed_yellow && !killed_dave)
		{
			dad.playAnim('singLEFT', true);
			dad.specialAnim = true;

			health += 0.15;
		}

		if (dad.curCharacter == 'yellow' && (PlayState.SONG.song == 'D\'low' || PlayState.SONG.song == 'D\'low (Pico Mix)') && !killed_yellow)
		{
			dad.playAnim('death', true);
			dad.specialAnim = killed_yellow = true;

			setSongTime(125.64 * 1000);
			clearNotesBefore(Conductor.songPosition);
		}

		if (dad.curCharacter == 'dave' && PlayState.SONG.song == 'Crewicide' && !killed_dave)
		{
			dad.alpha = 0;
			killed_dave = true;

			setSongTime(154.80 * 1000);
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