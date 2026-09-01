using StringTools;
import String;

function onCreatePost()
{
	if (!curSong.contains('Remnants')) return;

	wRemnants(boyfriend);
	wRemnants(gf);
}

function wRemnants(character)
{
	remnanytsShader = new funkin.game.shaders.ExtraDropShadowShader();

	bullshit1 = FlxColor.getRed(character.healthColour);
	bullshit2 = FlxColor.getGreen(character.healthColour);
	bullshit3 = FlxColor.getBlue(character.healthColour);

	remnanytsShader.threshold = .03;
	remnanytsShader.setHollowColorMatrix([
		0, 0, 0, 0, bullshit1,
		0, 0, 0, 0, bullshit2,
		0, 0, 0, 0, bullshit3,
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