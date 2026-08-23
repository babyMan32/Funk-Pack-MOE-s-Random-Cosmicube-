using StringTools;

var colors = [0xc24b99, 0x00ffff, 0x12fa05, 0xf9393f];

var leColour;

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case 'maroon':
			changeCharacter('rgbf-krima', 0);

		case 'boiling':
			changeCharacter('rgbf-krima', 0);

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

function goodNoteHit(note)
{
	if (!boyfriend.curCharacter.contains('rgbf') || note.noteType == 'Ghost Note') return;

	leColour = colors[note.noteData];

	playHUD.iconP1.color = leColour;
	playHUD.healthBar.setColors(null, playHUD.iconP1.color);

	if (curSong == 'Oversight 2025')
	{
		playHUD.scoreTxt.color = playHUD.iconP1.color;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (playHUD.iconP1.color == FlxColor.WHITE) return;

	if (!boyfriend.curCharacter.contains('rgbf') || boyfriend.curCharacter.contains('rgbf') && boyfriend.getAnimName().contains('idle'))
	{
		playHUD.iconP1.color = FlxColor.WHITE;
		playHUD.healthBar.setColors(null, playHUD.iconP1.color);

		if (curSong == 'Oversight 2025')
		{
			playHUD.scoreTxt.color = playHUD.iconP1.color;
		}
	}
}

function noteMiss(note)
{
	playHUD.iconP1.color = 0x333333;
	playHUD.healthBar.setColors(null, playHUD.iconP1.color);

	if (curSong == 'Oversight 2025')
	{
		playHUD.scoreTxt.color = playHUD.iconP1.color;
	}
}