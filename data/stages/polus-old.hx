var bothSing:Bool = false;
var twoSing:Bool = false;

var ext = 'stages/polus-old/';

function onLoad()
{
	var sky:FlxSprite = new FlxSprite(-834.3, -620.5).loadGraphic(Paths.image(ext + 'polusSky'));
	sky.antialiasing = true;
	sky.scrollFactor.set(0.5, 0.5);
	sky.active = false;
	add(sky);		

	var rocks:FlxSprite = new FlxSprite(-915.8, -411.3).loadGraphic(Paths.image(ext + 'polusrocks'));
	rocks.updateHitbox();
	rocks.antialiasing = true;
	rocks.scrollFactor.set(0.6, 0.6);
	rocks.active = false;
	add(rocks);	
						
	var hills:FlxSprite = new FlxSprite(-1238.05, -180.55).loadGraphic(Paths.image(ext + 'polusHills'));
	hills.updateHitbox();
	hills.antialiasing = true;
	hills.scrollFactor.set(0.9, 0.9);
	hills.active = false;
	add(hills);

	var warehouse:FlxSprite = new FlxSprite(-458.35, -315.6).loadGraphic(Paths.image(ext + 'polusWarehouse'));
	warehouse.updateHitbox();
	warehouse.antialiasing = true;
	warehouse.scrollFactor.set(0.9, 0.9);
	warehouse.active = false;
	add(warehouse);

	var ground:FlxSprite = new FlxSprite(-580.9, 241.85).loadGraphic(Paths.image(ext + 'polusGround'));
	ground.updateHitbox();
	ground.antialiasing = true;
	ground.scrollFactor.set(1, 1);
	ground.active = false;
	add(ground);
}

function onCreatePost()
{
	gf.camDisplacement = dad.camDisplacement = boyfriend.camDisplacement = 0;
}

function opponentNoteHitPre(note)
{
	if (note.noteType == 'Opponent Two')
	{
		note.owner = game.gf;
	}

	if (note.noteType == 'Both Opponents Sing')
	{
		characterSing(dad, note);
		characterSing(gf, note);
		note.noAnimation = true;
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy': // I fucked up but i dont wanna go back and fix all the events i put down
			switch (value1) // orbyy do not pull this line of code on me ever again i will kill you
			{
				case 'green':
					camSpecialThing([250, 300], [700, 350], -1); //I'm doing this my own special way

				case 'not green':
					camSpecialThing([200, 350], [700, 350], -1);
			}

		case 'Opponent Two':
			twoSing = Std.int(value1) == 1;
			refreshDoubleTroubleIcon();
			triggerEventNote("Legacy", twoSing ? "green" : "not green", "");

		case 'Both Opponents':
			bothSing = Std.int(value1) == 1;
			refreshDoubleTroubleIcon();
	}
}

function refreshDoubleTroubleIcon()
{
	if (hasColor) scoreTxt.color = bothSing ? '-8355032' : (twoSing ? gf : dad).healthColour;
	playHUD.healthBar.setColors(bothSing ? '-8355032' : (twoSing ? gf : dad).healthColour, boyfriend.healthColour);
	playHUD.iconP2.changeIcon(bothSing ? 'redgreen-old' : (twoSing ? 'impostor3-old' : 'impostor-old'));
}