import funkin.data.Chart;
using StringTools;

var dontlaugh = false;

var crewmateMoment = false;

var fakeIcon;

var chart:Song = null;
var chartPath = '/data/normal';

var extraboyfriend;

function onCreatePost()
{
	if (FlxG.random.bool(100))
	{
		iconShit();

		boyfriend.canTaunt = false;
		boyfriend.stunned = dontlaugh = true;
		boyfriend.playAnim('whyyoutryingnottolaughbruh', true);

		chart = Chart.fromPath(Paths.json(Paths.sanitize(songName) + chartPath));

		extraboyfriend = new Character(0, 0, 'sportsbf', true);
		extraboyfriend.color = boyfriend.healthColour;
		boyfriendGroup.insert(0, extraboyfriend);
		extraboyfriend.x = boyfriend.x + 350;
		extraboyfriend.y = boyfriend.y;
		extraboyfriend.alpha = 0.5;

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

function onSpawnNote(note)
{
	if (note.lane != 0) return;

	if (!dontlaugh) return;

	note.ignoreNote = true;

	new FlxTimer().start(1.075 * (170 / bpm), function(_) {
		extraboyfriend.playAnim(note.skin.singAnimations[note.noteData], true);
		extraboyfriend.holdTimer = 0;
	});
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