using StringTools;

var darkVariant;

public var bf2Dark:Null<String>;

var direction = 'Left';

function onCreatePost()
{
	if (bf2 == null) return;

	darkVariant = bf2.getFlag('variants')?.dark;

	if (darkVariant == null) return;

	bf2Dark = new Character(0, 0, darkVariant, true);
	boyfriendGroup.insert(0, bf2Dark);
	bf2Dark.x = bf2.x;
	bf2Dark.y = bf2.y;
	bf2Dark.alpha = 0.0000000001;
}

function onBeatHit()
{
	if (bf2Dark == null) return;

	if (curBeat % bf2Dark.danceEveryNumBeats == 0)
	{
		if (bf2Dark.getAnimName().contains('idle'))
		{
			bf2Dark.playAnim('idle' + extraIdleSuffix);
		}

		if (bf2Dark.getAnimName().contains('dance'))
		{
			bf2Dark.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf2Dark.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function onCountdownTick(tick)
{
	if (bf2Dark == null) return;

	if (tick % bf2Dark.danceEveryNumBeats == 0)
	{
		if (bf2Dark.getAnimName().contains('idle'))
		{
			bf2Dark.playAnim('idle' + extraIdleSuffix);
		}

		if (bf2Dark.getAnimName().contains('dance'))
		{
			bf2Dark.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf2Dark.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function goodNoteHit(note)
{
	if (bf2Dark == null) return;

	bf2Dark.holdTimer = 0;

	if (note.isSustainNote && bf2Dark.vSliceSustains) return;

	bf2Dark.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
}

function noteMiss(note)
{
	if (bf2Dark == null) return;

	bf2Dark.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf2Dark.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (bf2Dark == null) return;

	curAnim = bf2Dark.getAnimName();

	curAnimFinished = bf2Dark.isAnimFinished();

	if (curAnimFinished)
	{
		switch (curAnim)
		{
			case "idle", "idle-loop":
				if (bf2Dark.hasAnim("idle-loop"))
				{
					bf2Dark.playAnim('idle-loop');
				}

			case "singLEFT", "singLEFT-loop":
				if (bf2Dark.hasAnim("singLEFT-loop"))
				{
					bf2Dark.playAnim('singLEFT-loop');
				}

			case "singDOWN", "singDOWN-loop":
				if (bf2Dark.hasAnim("singDOWN-loop"))
				{
					bf2Dark.playAnim('singDOWN-loop');
				}

			case "singUP", "singUP-loop":
				if (bf2Dark.hasAnim("singUP-loop"))
				{
					bf2Dark.playAnim('singUP-loop');
				}

			case "singRIGHT", "singRIGHT-loop":
				if (bf2Dark.hasAnim("singRIGHT-loop"))
				{
					bf2Dark.playAnim('singRIGHT-loop');
				}
		}
	}

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf2Dark.hasAnim(tauntAnim))
	{
		bf2Dark.playAnim(tauntAnim);
		bf2Dark.specialAnim = true;
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
					if (bf2 == null) return;

					FlxG.signals.postUpdate.addOnce(function() {
						bf2.shader = boyfriend.shader;
					});
			}

		case 'Lights out':
			if (v1 == '2' /* ????? */ || (v1 == '1' && !ClientPrefs.flashing)) return;

			if (bf2 == null) return;

			if (bf2Dark != null)
			{
				bf2Dark.alpha = 1;
				bf2.alpha = 0.0000000001;
			}
			else
			{
				bf2.shader = darkShader;
			}

		case 'Lights on':
			if (v1 == '1' && !ClientPrefs.flashing) return;

			if (bf2 == null) return;

			if (bf2Dark != null)
			{
				bf2Dark.alpha = 0.0000000001;
				bf2.alpha = 1;
			}
			else
			{
				FlxG.signals.postUpdate.addOnce(function() {
					bf2.shader = boyfriend.shader;
				});
			}
	}
}