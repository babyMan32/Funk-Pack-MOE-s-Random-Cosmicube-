var allow_taunt = true;

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "maroon":
			changeCharacter("galfriend-christmas", 0);

		case "boiling":
			changeCharacter("galfriend-christmas", 0);

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

function onUpdate(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'galfriend' && allow_taunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(20))
		{
			boyfriend.playAnim('cheer');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'cheer' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}