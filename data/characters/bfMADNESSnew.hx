function onCreatePost()
{
	if (hasBfSkin)
	{
		switch (PlayState.SONG.song)
		{
			case "Danger":
				triggerEventNote('Change Character', 'boyfriend', 'bf_demise_body');

			case "Finale":
				triggerEventNote('Change Character', 'boyfriend', 'bfMADNESSexenewnervous');
		}

		switch (PlayState.SONG.stage)
		{
			case "voting":
				boyfriend.y += 35;
		}
	}
}

function onStepHit()
{
	if (curStep == 1847 && songName == "Triple Threat")
	{
		boyfriend.animSuffix = "-alt";
	}
}

function onUpdate(elapsed:Float):Void
{
	if (boyfriend.curCharacter == "bfMADNESSexenewnervous" && boyfriend.shader != null)
	{
		boyfriend.shader = null;
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			switch (value1)
			{
				case 'readykill':
					if (boyfriend.curCharacter == 'bfMADNESSnew')
					{
						FlxG.signals.postUpdate.addOnce(function() {
							triggerEventNote('Change Character', '0', 'bfMADNESSexenew');
						});
					}
			}
	}
}