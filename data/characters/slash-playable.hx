var taunt:FlxSound;

function onLoad()
{
	taunt = FlxG.sound.load(Paths.sound('special', null, PathsTestMode.LOOSE));

	parent.animation.onFrameChange.add((animName) -> {
		if (animName == 'goober')
		{
			if (parent.animation.curAnim.curFrame == 0)
			{
				taunt.play(true);
			}
		}
	});
}

function onUpdatePost(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P)
	{
		boyfriend.playAnim('goober', true);
		boyfriend.specialAnim = boyfriend.holding = true;
	}
}

function goodNoteHitPre(note)
{
	if (note.noteType == 'Hey!')
	{
		boyfriend.playAnim('goober', true);
		boyfriend.specialAnim = true;
		note.noAnimation = true;
	}
}