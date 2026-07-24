import funkin.game.shaders.ExtraDropShadowShader;

var stageRimExtraExtras:ExtraDropShadowShader = new ExtraDropShadowShader();

public function shadersExtraCheck()
{
	if (ClientPrefs.shaders)
	{
		switch (PlayState.SONG.stage)
		{
			case "boiling":
				stageRimExtraExtras.setColorMatrix([
					0.8,   0,   0, 0, 16,
					-.1, 0.6, -.1, 0,  0,
					  0,   0, 0.6, 0,  8,
					  0,   0,   0, 1,  0
				]);
				stageRimExtraExtras.addLayer([
					1.5, -.1, .2, 0, 64,
					-.3, 1.2,  0, 0, 32,
					  0,   0,  1, 0,  0,
					  0,   0,  0, 1,  0
				], 330, 25, .01);

			case "doubletrouble":
				stageRimExtraExtras.setAdjustColor(-78, -25, -15, -58);
				stageRimExtraExtras.addLayer([
					.8, 0, 0, 0, 0,
					0, 1, 0, 0, 0,
					.3, 0, 1, 0, 0,
					0, 0, 0, 1, 0
				], 90, 35, .01, 1, .5);

				stageRimExtraExtras.layers[0].angle = 110;

			case "defeat":
				stageRimExtraExtras = new funkin.game.shaders.ExtraDropShadowShader();
	
				stageRimExtraExtras.threshold = .05;
				stageRimExtraExtras.strength = .85;
				stageRimExtraExtras.setColorMatrix([
					.4, .5, -.2, 0, -50,
					-.25, .7, -.15, 0, -20,
					.42, -.35, .85, 0, -72,
					0, 0, 0, 1, 0
				]);
				stageRimExtraExtras.addLayer([
					.7, .5, 1, 0, 192,
					.3, .4, -.5, 0, 64,
					-.1, .2, .35, 0, 74,
					0, 0, 0, 1, 0
				], 10, 14, .01);
				stageRimExtraExtras.addLayer(
					stageRimExtraExtras.addLayer([
						.9, .6, .4, 0, 4,
						-.2, .5, .1, 0, -18,
						-.2, .2, .4, 0, -28,
						0, 0, 0, 1, 0
					], 12, 40, .01, .4)
				.colorMatrix, 96, 24, .01, .4);

			case "reactor":
				stageRimExtraExtras = new funkin.game.shaders.ExtraDropShadowShader();
	
				stageRimExtraExtras.threshold = .05;
				stageRimExtraExtras.setColorMatrix([
					.8, .1, .2, 0, -40,
					0, .35, .1, 0, 2,
					.15, .12, .56, 0, -5,
					0, 0, 0, 1, 0
				]);
				stageRimExtras.addLayer([
					1, .3, 0, 0, 125,
					.1, 1, 0, 0, 114,
					-.1, -.1, 1, 0, 80,
					0, 0, 0, 1, 0
				], 120, 20, .05);
				stageRimExtraExtras.addLayer(
					stageRimExtraExtras.addLayer([
						.8, .2, .2, 0, 14,
						-.05, .6, 0, 0, 12,
						-.1, .5, .81, 0, -20,
						0, 0, 0, 1, 0
					], 95, 38, .05)
				.colorMatrix, 140, 32, .05);
		}
	}

	return stageRimExtraExtras;
}