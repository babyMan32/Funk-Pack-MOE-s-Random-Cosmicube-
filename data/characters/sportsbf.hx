using StringTools;

public var dontlaugh = false;
public var fuuuuuuuuuuuck = false;

var crewmateMoment = false;

var fakeIcon;

public var extraboyfriend;

// pretty much the same thing that vslice does lol
var timeData:Array<Float> = [];
var noteData:Array<Int> = [];

function onCreatePost()
{
	if (FlxG.random.bool(10))
	{
		iconShit();

		boyfriend.canTaunt = false;
		boyfriend.stunned = dontlaugh = fuuuuuuuuuuuck = true;
		boyfriend.playAnim('whyyoutryingnottolaughbruh', true);

		extraboyfriend = new Character(0, 0, 'sportsbf', true);
		extraboyfriend.color = boyfriend.healthColour;
		boyfriendGroup.insert(0, extraboyfriend);
		extraboyfriend.x = boyfriend.x + 350;
		extraboyfriend.y = boyfriend.y;
		extraboyfriend.alpha = 0.5;

		for (sec in PlayState.SONG.notes)
		{
			for (i in sec.sectionNotes)
			{
				// 0 - 3 = bf
				if (i[1] < 4)
				{
					timeData.push(i[0]); // Kludge to the rescue yet again
					noteData.push(i[1]);
				}
			}
		}

		if (ClientPrefs.inDevMode) trace('yo thats disrespectful as fuck man');
	}
}

function iconShit()
{
	iconP1.visible = false;
	fakeIcon = new HealthIcon('bf', true);
	fakeIcon.cameras = [camHUD];
	fakeIcon.setPosition(playHUD.iconP1.x, playHUD.iconP1.y);
	playHUD.insert(playHUD.members.indexOf(playHUD.iconP1), fakeIcon);
}

var singAnimations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

function onUpdate(note)
{
	if (!dontlaugh) return;

	if (timeData.length == 0) return;

	if (timeData[0] <= Conductor.songPosition)
	{
		// hit note
		timeData.shift();
		var dir = noteData.shift();
		extraboyfriend.playAnim(singAnimations[dir], true);
		extraboyfriend.holdTimer = 0;
		health += 0.023;
	}
}

function onSpawnNote(note)
{
	if (!dontlaugh) return;

	if (note.lane != 0) return;

	note.ignoreNote = true;
}

function onEvent(eventName, value1, value2)
{
	if (boyfriend.canTaunt) return;

	switch (eventName)
	{
		case 'Legacy':
			switch (value1)
			{
				case 'Crewmates Come In':
					crewmateMoment = true;

					if (cpuControlled)
					{
						new FlxTimer().start(0.2, function(_) {
							dontlaugh = false;
						});
					}

				case 'Vignette Off':
					if (!crewmateMoment) return;

					boyfriend.stunned = false;
					boyfriend.playAnim('idle', true);

					if (cpuControlled)
					{
						new FlxTimer().start(10.1, function(_) {
							dontlaugh = true;
						});
					}

				case 'Crewmates Walk Away':
					crewmateMoment = false;
					boyfriend.stunned = true;
					boyfriend.playAnim('whyyoutryingnottolaughbruh', true);

				case 'dlow death':
					fakeIcon.alpha = 0;
					iconP1.visible = true;
					extraboyfriend.alpha = 0;
					boyfriend.stunned = false;
					boyfriend.playAnim('idle', true);
			}
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (fakeIcon != null)
	{
		fakeIcon.x = playHUD.healthBar.barCenter - (150 / 2) + 26 * 2;
		fakeIcon.visible = healthBar.visible;
		fakeIcon.alpha = healthBar.alpha;
	}

	if (extraboyfriend != null)
	{
		extraboyfriend.alpha = boyfriend.alpha * 0.5;
		extraboyfriend.visible = boyfriend.visible;
	}

	if (!boyfriend.stunned) return;

	if (boyfriend.getAnimName() != 'whyyoutryingnottolaughbruh')
	{
		boyfriend.playAnim('whyyoutryingnottolaughbruh', true);
	}
}

function onBeatHit()
{
	if (!dontlaugh) return;

	if (curBeat % extraboyfriend.danceEveryNumBeats == 0)
	{
		if (extraboyfriend.getAnimName().contains('idle'))
		{
			extraboyfriend.playAnim('idle');
		}
	}
}

function onCountdownTick(tick)
{
	if (!dontlaugh) return;

	if (tick % extraboyfriend.danceEveryNumBeats == 0)
	{
		extraboyfriend.playAnim('idle');
	}
}