using StringTools;

public var miraStages = ['toogus', 'reactor'];

var miraChar;

function onCreatePost()
{
	miraChar = boyfriend.getFlag('variants')?.mira ?? null;

	if (miraStages.contains(PlayState.SONG.stage))
	{
		if (miraChar != null)
		{
			changeCharacter(miraChar, 0);

			if (PlayState.SONG.stage != 'reactor') return;

			if (!ClientPrefs.shaders)
			{
				boyfriend.color = 0xffe080a6;
				return;
			}

			var rimlightBase:ExtraDropShadowShader = new funkin.game.shaders.ExtraDropShadowShader();

			rimlightBase.threshold = .05;
			rimlightBase.setColorMatrix([
				.8, .1, .2, 0, -40,
				0, .35, .1, 0, 2,
				.15, .12, .56, 0, -5,
				0, 0, 0, 1, 0
			]);
			rimlightBase.addLayer([
				1, .3, 0, 0, 125,
				.1, 1, 0, 0, 114,
				-.1, -.1, 1, 0, 80,
				0, 0, 0, 1, 0
			], 120, 20, .05);
			rimlightBase.addLayer(
				rimlightBase.addLayer([
					.8, .2, .2, 0, 14,
					-.05, .6, 0, 0, 12,
					-.1, .5, .81, 0, -20,
					0, 0, 0, 1, 0
				], 95, 38, .05)
			.colorMatrix, 140, 32, .05);

			bfRim = rimlightBase;
			bfRim.attachedSprite = boyfriend;
			boyfriend.useRenderTexture = true;
		}
	}
}