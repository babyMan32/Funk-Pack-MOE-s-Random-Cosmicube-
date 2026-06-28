var ext = 'stages/airship-old/';

function onLoad()
{
	var sky:FlxSprite = new FlxSprite(-1858.33333333333, -2161.66666666667).loadGraphic(Paths.image(ext + 'Sky_Yellow'));
	sky.scrollFactor.set(0.2, 0.2);
	sky.antialiasing = true;
	sky.active = false;
	sky.updateHitbox();
	add(sky);		

	var clouds:FlxSprite = new FlxSprite(-2175, -163.666666666667).loadGraphic(Paths.image(ext + 'Clouds_Yellow'));
	clouds.scrollFactor.set(0.6, 0.6);
	clouds.antialiasing = true;
	clouds.active = false;
	clouds.updateHitbox();
	add(clouds);	

	var floor_low:FlxSprite = new FlxSprite(-2287.5, -1873).loadGraphic(Paths.image(ext + 'Bottom_Floor_Yellow'));
	floor_low.antialiasing = true;
	floor_low.active = false;
	floor_low.updateHitbox();
	add(floor_low);

	var floor_high:FlxSprite = new FlxSprite(-2050, 20).loadGraphic(Paths.image(ext + 'Top_Floor_Yellow'));
	floor_high.antialiasing = true;
	floor_high.active = false;
	floor_high.updateHitbox();
	add(floor_high);

	var thingy:FlxSprite = new FlxSprite(-300, -33.5).loadGraphic(Paths.image(ext + 'cop'));
	thingy.antialiasing = true;
	thingy.active = false;
	thingy.updateHitbox();
	add(thingy);

	var chair:FlxSprite = new FlxSprite(-175, -155).loadGraphic(Paths.image(ext + 'Blu_Chair_Yellow'));
	chair.antialiasing = true;
	chair.active = false;
	chair.updateHitbox();
	add(chair);

	var map:FlxSprite = new FlxSprite(0, -500);
	map.frames = Paths.getSparrowAtlas(ext + 'Map_Bounce');
	map.animation.addByPrefix('idle', 'Map  instance 1', 24, true);
	map.animation.play('idle', true);
	add(map);
}

function onCreatePost()
{
	camSpecialThing([-500, 50], [-100, 50], -1);

	soRetroBF = (boyfriend.getFlag('variants')?.retro ?? boyfriend.getFlag('defeatRetro'));

	if (soRetroBF != null && soRetroBF != '')
	{
		changeCharacter(soRetroBF, 0);

		if (soRetroBF == 'noob49retro')
		{
			iconP1.changeIcon('noob49alone');

			FlxG.signals.postUpdate.addOnce(function() {
				pet.kill();
			});
		}
	}

	soRetroGF = gf.getFlag('airshipRetro'); //Yes I made my own variable for this, shut u-

	if (soRetroGF != null && soRetroGF != '')
	{
		changeCharacter(soRetroGF, 2);
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case "Legacy":
			if (value1 == "midpoint")
			{
				if (value2 == "yes" || value2 == "1" || value2 == "on")
				{
					camSpecialThing([-300, 0], [-300, 0], 0.55);
					camCurTarget = game.gf;
				}

				if (value2 == "no" || value2 == "0" || value2 == "off")
				{
					camSpecialThing([-500, 50], [-100, 50], 0.65);
					camCurTarget = null;
				}
			}
	}
}