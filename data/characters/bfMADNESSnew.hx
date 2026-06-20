function onCreatePost()
{
	if (hasBfSkin)
	{
		switch (PlayState.SONG.song)
		{
			case "Danger":
				triggerEventNote('Change Character', 'boyfriend', 'bf_demise_body');

			case "Defeat":
				triggerEventNote('Change Character', 'boyfriend', 'bfMADNESSexenew');

			case "Finale":
				triggerEventNote('Change Character', 'boyfriend', 'bfMADNESSexenewnervous');
		}

		switch (PlayState.SONG.stage)
		{
			case "voting":
				boyfriend.y += 35;

			case "turbulence":
				triggerEventNote('Change Character', 'boyfriend', 'bfMADNESSnew-turb'); //bullshit go
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

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Defeat Retro':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;
			
			switch (charType)
			{
				case 1:
					if (boyfriend.curCharacter == 'bfMADNESSnew')
					{
						triggerEventNote('Change Character', 'boyfriend', 'bfMADNESSexenewnervous');
					}
			}

		case 'Defeat Fade':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;

			switch (charType)
			{
				case 0:
					if (boyfriend.curCharacter == 'bfMADNESSexenew')
					{
						triggerEventNote('Change Character', 'boyfriend', 'bfMADNESSexenewnervous');
					}
			}

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