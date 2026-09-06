import funkin.game.shaders.ExtraDropShadowShader;
import funkin.FunkinAssets;
import haxe.Json;

using StringTools;

var remnanytsShader;

function onCreatePost()
{
	REMNA();
}

function REMNA()
{
	if (!curSong.contains('Remnants')) return;

	if (boyfriend != null && !boyfriend.curCharacter.contains('remnants')
		&& !boyfriend.curCharacter.contains('ghost')
		&& !boyfriend.curCharacter.contains('nightmare')
		|| boyfriend.curCharacter == 'yellow-ghostPLUS') {
		wRemnants(boyfriend);
		boyfriend.ghostsEnabled = false;
	}

	if (gf != null && !gf.curCharacter.contains('remnants')
		&& !gf.curCharacter.contains('ghost')
		&& !gf.curCharacter.contains('nightmare')) {
		wRemnants(gf);
		gf.ghostsEnabled = false;
	}

	if (hasPet && !pet.curPet.contains('remnants')
		&& !pet.curPet.contains('ghost')
		&& !pet.curPet.contains('nightmare')) {
		wRemnants(pet, 'pet');
	}
}

function wRemnants(character, ?type = 'notPet')
{
	remnanytsShader = new funkin.game.shaders.ExtraDropShadowShader();

	bullshitR = 255;
	bullshitG = 255;
	bullshitB = 255;

	switch (type)
	{
		case 'pet':	
			var data:Dynamic; // json data of the pet
			var modName:String = Paths.getModFolder(FlxG.bitmap.findKeyForBitmap(pet.pixels)); // fetch the image path of the pet by finding the bitmap key
			var path:String;
			
			if (modName == '') // not in any mod, assume its base game
			{
				path = 'data/cosmicube/impostor';
			}
			else 
			{
				path = fetchPetPath(modName);
			}

			data = FunkinAssets.parseJson(Paths.getTextFromFile('$path/${ClientPrefs.equipment.get('pet')}.json', null, PathsTestMode.LOOSE));

			if (data?.color != null) // has color data
			{
				bullshitR = data.color[0];
				bullshitG = data.color[1];
				bullshitB = data.color[2];
			}

		default:
			bullshitR = FlxColor.getRed(character.healthColour);
			bullshitG = FlxColor.getGreen(character.healthColour);
			bullshitB = FlxColor.getBlue(character.healthColour);
	}

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

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Defeat Retro':
			if (Std.parseInt(value1) == 1)
			{
				REMNA();
			}
	}
}

// function onSpawnNote(note)
// {
// 	if (note.lane == 1)
// 	{
// 		note.lane = 0;
// 		note.owner = dad;
// 		note.noMissAnimation = true;
// 	}
// }

// function goodNoteHit(note)
// {
// 	if (note.owner == dad && songName == 'Ow')
// 	{
// 		boyfriend.playAnim(note.skin.data.singAnimations[note.noteData] + '-alt', true);
// 		boyfriend.holdTimer = 0;

// 		health -= 0.038;
// 	}
// }

function fetchPetPath(modName:String) {
	for (i in FunkinAssets.readDirectory('content/${modName}/data/cosmicube')) // check every cosmicube of this mod
	{
		if (FunkinAssets.isDirectory('content/$modName/data/cosmicube/$i')) // loop through each one of the cosmicubes
		{
			if (FunkinAssets.readDirectory('content/$modName/data/cosmicube/$i').contains('${ClientPrefs.equipment.get('pet')}.json')) // contains the pet
			{
				return 'data/cosmicube/$i';
			}
		}
	}

	return null; // failsafe
}