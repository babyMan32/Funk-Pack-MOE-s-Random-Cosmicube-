import funkin.game.shaders.ExtraDropShadowShader;
import funkin.FunkinAssets;
import haxe.Json;

using StringTools;

var remnanytsShader;

var canItBecomeRemnantsGirlfriend;
var canItBecomeRemnantsBoyfriend;
var canItBecomeRemnantsPet;

function onCreatePost()
{
	remnantShade();

	pet.onChange.add(remnantShade);
}

function remnantShade()
{
	if (!curSong.toLowerCase().contains('remnants')) return;

	FlxG.signals.postUpdate.addOnce(function() {
		playHUD.scoreTxt.color = FlxColor.WHITE;
	});

	canItBecomeRemnantsBoyfriend = (!boyfriend.curCharacter.contains('remnants')
		&& !boyfriend.curCharacter.contains('ghost')
		&& !boyfriend.curCharacter.contains('nightmare')
		&& !boyfriend.getFlag('remnants')
		&& !boyfriend.getFlag('ghost')
		|| boyfriend.curCharacter == 'yellow-ghostPLUS');

	canItBecomeRemnantsGirlfriend = (!gf.curCharacter.contains('remnants')
		&& !gf.curCharacter.contains('ghost')
		&& !gf.curCharacter.contains('nightmare')
		&& !gf.getFlag('remnants')
		&& !gf.getFlag('ghost'));

	canItBecomeRemnantsPet = (!pet.curPet.contains('remnants')
		&& !pet.curPet.contains('ghost')
		&& !pet.curPet.contains('nightmare')
		&& !pet.getFlag('remnants')
		&& !pet.getFlag('ghost'));

	if (boyfriend != null && canItBecomeRemnantsBoyfriend) {
		wRemnants(boyfriend);
		boyfriend.ghostsEnabled = false;
	}

	if (gf != null && canItBecomeRemnantsGirlfriend) {
		wRemnants(gf);
		gf.ghostsEnabled = false;
	}

	if (hasPet && canItBecomeRemnantsPet) {
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

	if (character == boyfriend)
	{
		var hudRemShader = new funkin.game.shaders.ExtraDropShadowShader().copyFrom(remnanytsShader);
		playHUD.iconP1.shader = hudRemShader;

		FlxG.signals.postUpdate.addOnce(function() {
			playHUD.healthBar.setColors(null, 6750003);
		});
	}

	remnanytsShader.attachedSprite = character;
	character.useRenderTexture = true;

	if (character.curCharacter == 'triplespeaker')
	{
		character.useRenderTexture = false;

		pinkParts = ['Symbol 2', 'daheart', 'pinkhand1', 'pinkvisor', 'pinkleg', 'pinkleg2', 'pinkbody', 'body parts/bag', 'pinkmouth'];
		maroonParts = ['Symbol 1', 'Symbol 5', 'maroonvisor', 'maroonbod', 'maroonhand1', 'maroonhand2', 'maroonmouth'];

		if (character.library != null)
		{
			for (i in 0...pinkParts.length)
			{
				var pinkToShade = character.library.getSymbol(pinkParts[i]);

				var remnanytsShaderAlt = newRemnantsShader('pink');

				if (pinkToShade != null)
				{
					pinkToShade.timeline.layers[0].forEachFrame((frame) -> {
						for (i in frame.elements) i.shader = remnanytsShaderAlt;
					});
				}
			}

			for (i in 0...maroonParts.length)
			{
				var marronToShade = character.library.getSymbol(maroonParts[i]);

				var remnanytsShaderAlt2 = newRemnantsShader('maroon');

				if (marronToShade != null)
				{
					marronToShade.timeline.layers[0].forEachFrame((frame) -> {
						for (i in frame.elements) i.shader = remnanytsShaderAlt2;
					});
				}
			}
		}
	}
}

function newRemnantsShader(color)
{
	var newRemnt = new funkin.game.shaders.ExtraDropShadowShader();

	switch (color)
	{
		case 'pink':
			newRemnt.threshold = 0.03;
			newRemnt.setHollowColorMatrix([
				0, 0, 0, 0, FlxColor.getRed(-1153844),
				0, 0, 0, 0, FlxColor.getGreen(-1153844),
				0, 0, 0, 0, FlxColor.getBlue(-1153844),
				0, 0, 0, 1,         0
			]);
			newRemnt.setColorMatrix([
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 1, 0
			]);
			newRemnt.antialiasStages = 4;

		case 'maroon':
			newRemnt.threshold = 0.03;
			newRemnt.setHollowColorMatrix([
				0, 0, 0, 0, FlxColor.getRed(-11394257),
				0, 0, 0, 0, FlxColor.getGreen(-11394257),
				0, 0, 0, 0, FlxColor.getBlue(-11394257),
				0, 0, 0, 1,         0
			]);
			newRemnt.setColorMatrix([
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 1, 0
			]);
			newRemnt.antialiasStages = 4;

		case 'green':
			newRemnt.threshold = 0.03;
			newRemnt.setHollowColorMatrix([
				0, 0, 0, 0, 255,
				0, 0, 0, 0, 212,
				0, 0, 0, 0,  82,
				0, 0, 0, 1,   0
			]);
			newRemnt.setColorMatrix([
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 1, 0
			]);
			newRemnt.antialiasStages = 4;
	}

	return newRemnt;
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