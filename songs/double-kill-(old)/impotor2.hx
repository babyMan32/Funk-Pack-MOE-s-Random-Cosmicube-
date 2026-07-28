final space = 865;

var duet = false;

function onCreatePost()
{
	for (playField in playFields)
		if (playField.ID != 0) playField.playerControls = false;

	playFields.members[2].owner = game.gf;
	playFields.members[2].isPlayer = false;

	for (i in playFields.members)
	{
		final orgID = (3 - i.ID);
		final wrap = Math.floor(orgID / 2) == 1;

		i.visible = (i.ID == 0 || ClientPrefs.opponentStrums);

		if (wrap)
		{
			i.zIndex = 999;
		}
		else
		{
			i.underlay.kill();

			// modManager.setValue("noteAlpha", 1, i.ID);
			modManager.setValue("alpha", 0.7, i.ID);
			// modManager.setValue("stealth", 0.5, i.ID);
			// modManager.setValue("sustainSplashAlpha", 1, i.ID);
			// modManager.setValue("reverse", 1, i.ID);
			modManager.setValue("transformZ", -1, i.ID);
			modManager.setValue("transformY", -90 * (ClientPrefs.downScroll ? -1 : 1), i.ID);
			// modManager.setValue("stealthPastReceptors", 1, i.ID);

			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", i.ID == 2 ? -(space) : space, i.ID);
			else if (!ClientPrefs.opponentStrums) i.visible = false;
			// modManager.setValue("")
		}
	}

	refreshZ(playFields);
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Both Opponents':
			if (Std.int(value1) == 1)
			{
				duet = true;

				forceStrumsUp('both');
			}

			if (Std.int(value1) == 0)
			{
				duet = false;

				forceStrumsUp('opp');
			}

		case 'Opponent Two':
			if (duet) return;

			forceStrumsUp(Std.int(value1) == 1 ? 'extra' : 'opp');
	}
}

function forceStrumsUp(char)
{
	for (i in playFields.members)
	{
		final orgID = (3 - i.ID);
		final wrap = Math.floor(orgID / 2) == 1;
		final wrap2 = orgID == 2;

		if (!wrap)
		{
			modManager.setValue("alpha", (char != 'opp' ? 0 : 0.7), i.ID);
			modManager.setValue("transformZ", (char != 'opp' ? 0 : -1), i.ID);
			modManager.setValue("transformY", (char == 'both' ? 110 : (char == 'opp' ? -90 : 0)) * (ClientPrefs.downScroll ? -1 : 1), i.ID);
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", -(space) + (char != 'opp' ? 549 : 0), i.ID);
		}

		if (wrap2)
		{
			modManager.setValue("alpha", (char != 'extra' ? 0 : 0.7), i.ID);
			modManager.setValue("transformZ", (char != 'extra' ? 0 : -1), i.ID);
			modManager.setValue("transformY", (char != 'extra' ? 0 : -90) * (ClientPrefs.downScroll ? -1 : 1), i.ID);
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", (char != 'extra' ? 0 : -(space) + 315), i.ID);
		}
	}
}

function onSpawnNote(note)
{
	if (note.lane == 1)
	{
		note.setCustomColor([0xd0e3ff /*red channel*/, 0x49a6ce /*green channel*/, 0x93a2e4 /*blue channel*/]);
	}

	if (note.lane == 2)
	{
		note.setCustomColor([0x2b2c3c /*red channel*/, 0x000000 /*green channel*/, 0x1a182e /*blue channel*/]);
	}
}