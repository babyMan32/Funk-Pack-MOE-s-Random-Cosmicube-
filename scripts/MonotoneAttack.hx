function onCreatePost() //I'm gonna have to recode it again fuck this shit-
{
	if (ClientPrefs.bfSkin == "clowfoe-old")
	{
		switch (PlayState.SONG.song)
		{
			case "Monotone Attack":
				triggerEventNote('Change Character', 'boyfriend', 'clowfoe-old');
				triggerEventNote('Change Character', 'dad', 'attack-old');
				triggerEventNote('Change Character', 'gf', 'fabs-old');
		}
	}

	oMahFukenGodBruh();
}

function oMahFukenGodBruh()
{
	if (ClientPrefs.bfSkin == "clowfoe-old")
	{
		switch (PlayState.SONG.song)
		{
			case "Monotone Attack":
				if (PlayState.attackCharacter > 1)
				{
					iconP2.changeIcon('fabs');
					iconP1.changeIcon('biddle');

					healthBar.setColors(gf.healthColour, '-3217');
				}

				if (PlayState.attackCharacter == 1 || PlayState.attackCharacter == 2)
				{
					healthBar.leftToRight = true;

					switch (PlayState.attackCharacter)
					{
						case 1:
							iconP1.changeIcon('attack_OLD');
							iconP2.changeIcon('bfclow_OLD');

						case 2:
							iconP1.changeIcon('fabs');
							iconP2.changeIcon('biddle');
					}
				}
		}
	}
}