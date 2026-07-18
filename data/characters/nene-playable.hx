function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "ejected", "ejectedErected":
			changeCharacter("nene-playable-wind", 0);

			boyfriend.useRenderTexture = true;

			boyfriend.shader = gf.shader;

		case "danger":
			changeCharacter("nene-playable-wind", 0);
			boyfriend.y -= 230;

		case "maroon":
			changeCharacter("nene-playable-xmas", 0);

		case "boiling":
			changeCharacter("nene-playable-xmas", 0);

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