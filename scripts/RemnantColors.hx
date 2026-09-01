import funkin.game.shaders.ExtraDropShadowShader;

using StringTools;

var remnanytsShader;
var bfReal:Bool = false;

function onCreatePost() {
	if (!curSong.contains('Remnants'))
		return;

	if (boyfriend != null && !boyfriend.curCharacter.contains('remnants')
		&& !boyfriend.curCharacter.contains('ghost')
		&& !boyfriend.curCharacter.contains('nightmare')
		|| boyfriend.curCharacter == 'yellow-ghostPLUS') {
		wRemnants(boyfriend);
		boyfriend.ghostsEnabled = false;
		bfReal = true;
	}

	if (gf != null && !gf.curCharacter.contains('remnants')
		&& !gf.curCharacter.contains('ghost')
		&& !gf.curCharacter.contains('nightmare')) {
		wRemnants(gf);
		gf.ghostsEnabled = false;
	}

	if (hasPet && bfReal && !pet.curPet.contains('remnants')
		&& !pet.curPet.contains('ghost')
		&& !pet.curPet.contains('nightmare')) {
		wRemnants(pet);

		// TODO: Find a variable for the pet's cosmicube colors instad of just copying BF's health color
		petShader = new ExtraDropShadowShader();
		petShader.copyFrom(boyfriend.shader);
		petShader.attachedSprite = pet;
		pet.useRenderTexture = true;
	}
}

function wRemnants(character) {
	remnanytsShader = new funkin.game.shaders.ExtraDropShadowShader();

	bullshitR = FlxColor.getRed(character.healthColour);
	bullshitG = FlxColor.getGreen(character.healthColour);
	bullshitB = FlxColor.getBlue(character.healthColour);

	remnanytsShader.threshold = 0.03;
	remnanytsShader.setHollowColorMatrix([
		0, 0, 0, 0, bullshitR,
		0, 0, 0, 0, bullshitG,
		0, 0, 0, 0, bullshitB,
		0, 0, 0, 1,         0
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
