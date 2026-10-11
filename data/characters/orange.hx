var funny_noise:FlxSound;

var funny_moment;

function onLoad()
{
	funny_noise = FlxG.sound.load(Paths.sound('FISH', null, PathsTestMode.LOOSE));

	funny_moment = FlxG.random.bool(4.157);

	parent.animation.onFrameChange.add((animName) -> {
		if (animName == 'hey')
		{
			if (parent.animation.curAnim.curFrame == 0)
			{
				funny_noise.play(true);
			}
		}
	});

	if (funny_moment)
	{
		parent.vSliceSustains = true;
	}
}

function goodNoteHit(note)
{
	if (!funny_moment) return;

	if (note.isSustainNote)
	{
		parent.animTimer = 10;
		return;
	}

	parent.playAnim('hey', true);
	parent.specialAnim = true;
}