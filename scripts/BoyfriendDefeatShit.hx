function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Defeat Retro':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;
			
			switch (charType)
			{
				case 0:
					if (boyfriend.curCharacter == 'bf-defeat-scared-dialogue')
					{
						changeCharacter('bf-dialogue', 0);
					}

					if (boyfriend.curCharacter == 'bf-defeat-scared')
					{
						changeCharacter('bf', 0);
					}

				case 1:
					if (boyfriend.curCharacter == 'bf-dialogue')
					{
						changeCharacter('bf-defeat-scared-dialogue', 0);
					}

					if (boyfriend.curCharacter == 'bf')
					{
						changeCharacter('bf-defeat-scared', 0);
					}
			}

		case 'Defeat Fade':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;

			switch (charType)
			{
				case 0:
					if (boyfriend.curCharacter == 'bf-defeat-normal-dialogue')
					{
						triggerEventNote('Change Character', 'boyfriend', 'bf-defeat-scared-dialogue');
					}

					if (boyfriend.curCharacter == 'bf-defeat-normal')
					{
						triggerEventNote('Change Character', 'boyfriend', 'bf-defeat-scared');
					}
			}
	}
}

function onUpdate(elapsed:Float):Void
{
	if ((boyfriend.curCharacter == "bf-defeat-normal" || boyfriend.curCharacter == "bf-defeat-scared") && boyfriend.shader != null)
	{
		boyfriend.shader = null;
	}
}