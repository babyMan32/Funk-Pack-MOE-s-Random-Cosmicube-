final space = 865;

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

function extraNoteHit()
{
	for (i in playFields.members)
	{
		final orgID = (3 - i.ID);
		final wrap = Math.floor(orgID / 2) == 1;
		final wrap2 = orgID == 2;

		if (!wrap)
		{
			modManager.setValue("alpha", 0, i.ID);
			modManager.setValue("transformZ", 0, i.ID);
			modManager.setValue("transformY", 0, i.ID);
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", -(space) + 549, i.ID);
		}

		if (wrap2)
		{
			modManager.setValue("alpha", 0.7, i.ID);
			modManager.setValue("transformZ", -1, i.ID);
			modManager.setValue("transformY", -90 * (ClientPrefs.downScroll ? -1 : 1), i.ID);
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", -(space) + 315, i.ID);
		}
	}
}

function opponentNoteHit()
{
	for (i in playFields.members)
	{
		final orgID = (3 - i.ID);
		final wrap = Math.floor(orgID / 2) == 1;
		final wrap2 = orgID == 2;

		if (!wrap)
		{
			modManager.setValue("alpha", 0.7, i.ID);
			modManager.setValue("transformZ", -1, i.ID);
			modManager.setValue("transformY", -90 * (ClientPrefs.downScroll ? -1 : 1), i.ID);
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", -(space), i.ID);
		}

		if (wrap2)
		{
			modManager.setValue("alpha", 0, i.ID);
			modManager.setValue("transformZ", 0, i.ID);
			modManager.setValue("transformY", 0, i.ID);
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", 0, i.ID);
		}
	}
}