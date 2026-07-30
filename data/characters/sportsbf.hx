var dontlaugh = false;

var crewmateMoment = false;

function onCreatePost()
{
	if (FlxG.random.bool(10))
	{
		boyfriend.canTaunt = false;
		boyfriend.stunned = dontlaugh = true;
		boyfriend.playAnim('whyyoutryingnottolaughbruh', true);

		if (ClientPrefs.inDevMode) trace('yo thats disrespectful as fuck man');
	}
}

function onSpawnNote(note)
{
	if (note.lane != 0) return;

	if (!dontlaugh) return;

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
					boyfriend.stunned = false;
					boyfriend.playAnim('idle', true);
			}
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!dontlaugh) return;

	if (boyfriend.getAnimName() != 'whyyoutryingnottolaughbruh')
	{
		boyfriend.playAnim('whyyoutryingnottolaughbruh', true);
	}
}