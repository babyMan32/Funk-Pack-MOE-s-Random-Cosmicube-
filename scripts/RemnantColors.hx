using StringTools;

var remnanytsShader;

function onCreatePost()
{
	if (!curSong.contains('Remnants')) return;

	if (boyfriend.curCharacter.contains('remnants')) return;

	wRemnants(boyfriend);
	wRemnants(gf);
}

function wRemnants(character)
{
	remnanytsShader = new funkin.game.shaders.ExtraDropShadowShader();

	bullshitR = FlxColor.getRed(character.healthColour);
	bullshitG = FlxColor.getGreen(character.healthColour);
	bullshitB = FlxColor.getBlue(character.healthColour);

	remnanytsShader.threshold = 0.03;
	remnanytsShader.setHollowColorMatrix([
		0, 0, 0, 0, bullshitR,
		0, 0, 0, 0, bullshitG,
		0, 0, 0, 0, bullshitB,
		0, 0, 0, 1, 0
	]);
	remnanytsShader.setColorMatrix([
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 1, 0
	]);
	remnanytsShader.antialiasStages = 4;

	remnanytsShader.attachedSprite = character;
	character.useRenderTexture = true;
}