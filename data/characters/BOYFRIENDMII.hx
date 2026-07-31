function onEvent(eventName, value1, value2)
{
	if (!fuuuuuuuuuuuck) return;

	switch (eventName)
	{
		case 'Defeat Retro':
			var charType:Int = Std.parseInt(value1);

			if (Math.isNaN(charType)) charType = 0;

			if (cpuControlled)
			{
				dontlaugh = (charType == 0 ? false : true);
			}

			boyfriend.stunned = (charType == 0 ? false : true);
			extraboyfriend.visible = (charType == 0 ? false : true);
	}
}