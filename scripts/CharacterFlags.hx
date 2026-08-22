function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "maroon":
			coldVarP = (boyfriend.getFlag('variants')?.cold ?? null);
			coldVarG = (gf.getFlag('variants')?.cold ?? null);

			if (coldVarP != null)
			{
				changeCharacter(coldVarP, 0);
			}

			if (coldVarG != null)
			{
				changeCharacter(coldVarG, 2);
			}

		case "boiling":
			coldVarP = (boyfriend.getFlag('variants')?.cold ?? null);

			if (coldVarP != null)
			{
				changeCharacter(coldVarP, 0);
			}

			boyfriend.useRenderTexture = true;

			if (ClientPrefs.shaders)
			{
				var blackRimlightBase:ExtraDropShadowShader = new funkin.game.shaders.ExtraDropShadowShader();
	
				blackRimlightBase.setColorMatrix([
					0.8,   0,   0, 0, 16,
					-.1, 0.6, -.1, 0,  0,
					  0,   0, 0.6, 0,  8,
					  0,   0,   0, 1,  0
				]);
				blackRimlightBase.addLayer([
					1.5, -.1, .2, 0, 64,
					-.3, 1.2,  0, 0, 32,
					  0,   0,  1, 0,  0,
					  0,   0,  0, 1,  0
				], 330, 25, .01);

				bfRim = blackRimlightBase;
				bfRim.attachedSprite = boyfriend;
			}
	}
}