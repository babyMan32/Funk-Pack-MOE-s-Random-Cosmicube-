var bothSing:Bool = false;
var twoSing:Bool = false;

var ext = 'stages/cargo-old/';

function onLoad()
{
	var floor:FlxSprite = new FlxSprite(-400, 1070).loadGraphic(Paths.image(ext + 'cargofloor'));
	floor.scrollFactor.set(1, 1);
	floor.updateHitbox();
	add(floor);

	var wall:FlxSprite = new FlxSprite(380, 200).loadGraphic(Paths.image(ext + 'cargowall'));
	wall.scrollFactor.set(1, 1);
	wall.updateHitbox();
	add(wall);

	var rareBox:FlxSprite = new FlxSprite(2600, 750).loadGraphic(Paths.image(ext + 'rarebox'));
	rareBox.scrollFactor.set(1, 1);
	rareBox.updateHitbox();
	add(rareBox);

	var boringCrate:FlxSprite = new FlxSprite(2050, 800).loadGraphic(Paths.image(ext + 'Crate_Boring'));
	boringCrate.scrollFactor.set(1, 1);
	boringCrate.updateHitbox();
	add(boringCrate);

	var doodlerBox:FlxSprite = new FlxSprite(1250, 650).loadGraphic(Paths.image(ext + 'doodlerbox'));
	doodlerBox.scrollFactor.set(1, 1);
	doodlerBox.updateHitbox();
	add(doodlerBox);

	var zeSpy:FlxSprite = new FlxSprite(3100, 1450).loadGraphic(Paths.image(ext + 'spybox'));
	zeSpy.scrollFactor.set(1, 1);
	zeSpy.updateHitbox();
	add(zeSpy);
}

function onCreatePost()
{
	var adamBox:FlxSprite = new FlxSprite(365, 1200).loadGraphic(Paths.image(ext + 'adambox'));
	adamBox.scrollFactor.set(1, 1);
	adamBox.updateHitbox();
	add(adamBox);

	var tomatoBox:FlxSprite = new FlxSprite(2200, 1400).loadGraphic(Paths.image(ext + 'tomongusbox'));
	tomatoBox.scrollFactor.set(1, 1);
	tomatoBox.updateHitbox();
	add(tomatoBox);

	stage.insert(stage.members.indexOf(dadGroup) + 1, adamBox);
	stage.insert(stage.members.indexOf(dadGroup) + 1, tomatoBox);

	camSpecialThing([2000, 1050], [2300, 1050], -1);

	defeatRetro = (boyfriend.getFlag('variants')?.retro ?? boyfriend.getFlag('defeatRetro'));

	if (defeatRetro != null && defeatRetro != '')
	{
		changeCharacter(defeatRetro, 0);
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy': // I fucked up but i dont wanna go back and fix all the events i put down
			switch (value1) // orbyy do not pull this line of code on me ever again i will kill you
			{
				case 'black':
					camCurTarget = game.gf;
					camSpecialThing([2050, 1000], [2300, 1050], -1); //I'm doing this my own special way

				case 'not black':
					camCurTarget = null;
					camSpecialThing([2000, 1050], [2300, 1050], -1);
			} // 62636f

		case 'Opponent Two':
			twoSing = Std.int(value1) == 1;
			refreshDoubleKillIcon();

		case 'Both Opponents':
			bothSing = Std.int(value1) == 1;
			refreshDoubleKillIcon();
	}
}

function refreshDoubleKillIcon()
{
	if (hasColor) scoreTxt.color = bothSing ? '-10329233' : (twoSing ? gf : dad).healthColour;
	playHUD.healthBar.setColors(bothSing ? '-10329233' : (twoSing ? gf : dad).healthColour, boyfriend.healthColour);
	playHUD.iconP2.changeIcon(bothSing ? 'whiteblack-old' : (twoSing ? 'black-old' : 'white-old'));
}