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

			modManager.setValue("noteAlpha", 1, i.ID);
			modManager.setValue("alpha", 0.7, i.ID);
			modManager.setValue("stealth", 0.5, i.ID);
			// modManager.setValue("sustainSplashAlpha", 1, i.ID);
			// modManager.setValue("reverse", 1, i.ID);
			modManager.setValue("transformZ", -1, i.ID);
			modManager.setValue("transformY", -90 * (ClientPrefs.downScroll ? -1 : 1), i.ID);
			modManager.setValue("stealthPastReceptors", 1, i.ID);
			
			final space = 865;
			
			if (!ClientPrefs.middleScroll) modManager.setValue("transformX", i.ID == 2 ? -(space) : space, i.ID);
			else if (!ClientPrefs.opponentStrums) i.visible = false;
			// modManager.setValue("")
		}
	}

	refreshZ(playFields);

	camSpecialThing([200, 350], [700, 350], -1);
}