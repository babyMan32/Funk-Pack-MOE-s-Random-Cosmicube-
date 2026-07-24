using StringTools;

var darkVariant;

public var bf3Dark:Null<String>;

var direction = 'Left';

function onCreatePost()
{
	if (bf3 == null) return;

	darkVariant = bf3.getFlag('variants')?.dark;

	if (darkVariant == null) return;

	bf3Dark = new Character(0, 0, darkVariant, true);
	boyfriendGroup.insert(0, bf3Dark);
	bf3Dark.x = bf3.x;
	bf3Dark.y = bf3.y;
	bf3Dark.alpha = 0.0000000001;
}

function onBeatHit()
{
	if (bf3Dark == null) return;

	if (curBeat % bf3Dark.danceEveryNumBeats == 0)
	{
		if (bf3Dark.getAnimName().contains('idle'))
		{
			bf3Dark.playAnim('idle' + extraIdleSuffix);
		}

		if (bf3Dark.getAnimName().contains('dance'))
		{
			bf3Dark.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf3Dark.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function onCountdownTick(tick)
{
	if (bf3Dark == null) return;

	if (tick % bf3Dark.danceEveryNumBeats == 0)
	{
		if (bf3Dark.getAnimName().contains('idle'))
		{
			bf3Dark.playAnim('idle' + extraIdleSuffix);
		}

		if (bf3Dark.getAnimName().contains('dance'))
		{
			bf3Dark.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf3Dark.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function goodNoteHit(note)
{
	if (bf3Dark == null) return;

	bf3Dark.holdTimer = 0;

	if (note.isSustainNote && bf3Dark.vSliceSustains) return;

	bf3Dark.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
}

function noteMiss(note)
{
	if (bf3Dark == null) return;

	bf3Dark.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf3Dark.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (bf3Dark == null) return;

	curAnim = bf3Dark.getAnimName();

	curAnimFinished = bf3Dark.isAnimFinished();

	if (curAnimFinished)
	{
		switch (curAnim)
		{
			case "idle", "idle-loop":
				if (bf3Dark.hasAnim("idle-loop"))
				{
					bf3Dark.playAnim('idle-loop');
				}

			case "singLEFT", "singLEFT-loop":
				if (bf3Dark.hasAnim("singLEFT-loop"))
				{
					bf3Dark.playAnim('singLEFT-loop');
				}

			case "singDOWN", "singDOWN-loop":
				if (bf3Dark.hasAnim("singDOWN-loop"))
				{
					bf3Dark.playAnim('singDOWN-loop');
				}

			case "singUP", "singUP-loop":
				if (bf3Dark.hasAnim("singUP-loop"))
				{
					bf3Dark.playAnim('singUP-loop');
				}

			case "singRIGHT", "singRIGHT-loop":
				if (bf3Dark.hasAnim("singRIGHT-loop"))
				{
					bf3Dark.playAnim('singRIGHT-loop');
				}
		}
	}

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf3Dark.hasAnim(tauntAnim))
	{
		bf3Dark.playAnim(tauntAnim);
		bf3Dark.specialAnim = true;
	}
}

function onEvent(ev, v1, v2)
{
	switch (ev)
	{
		case 'Legacy':
			switch (v1)
			{
				case 'Vignette On', 'Vignette Off', 'ending':
					if (bf3 == null) return;

					FlxG.signals.postUpdate.addOnce(function() {
						bf3.shader = boyfriend.shader;
					});
			}

		case 'Lights out':
			if (v1 == '2' /* ????? */ || (v1 == '1' && !ClientPrefs.flashing)) return;

			if (bf3 == null) return;

			if (bf3Dark != null)
			{
				bf3Dark.alpha = 1;
				bf3.alpha = 0.0000000001;
			}
			else
			{
				bf3.shader = darkShader;
			}

		case 'Lights on':
			if (v1 == '1' && !ClientPrefs.flashing) return;

			if (bf3 == null) return;

			if (bf3Dark != null)
			{
				bf3Dark.alpha = 0.0000000001;
				bf3.alpha = 1;
			}
			else
			{
				FlxG.signals.postUpdate.addOnce(function() {
					bf3.shader = boyfriend.shader;
				});
			}
	}
}