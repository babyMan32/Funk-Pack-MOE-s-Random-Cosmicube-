var bothSing:Bool = false;
var twoSing:Bool = false;

var ext = 'stages/polus-old/';

public var oppIconBase = 'impostor-old';
public var oppIconExtra = 'impostor3-old';
public var oppIconDuo = 'redgreen-old';

public var pauseBase = 'red';
public var pauseExtra = 'green';
public var pauseDuo = 'doubletrouble';

public var hpColorDuo = '-8355032';

public var allowIconSwitching = true;

function onLoad()
{
	var sky:FlxSprite = new FlxSprite(-834.3, -620.5).loadGraphic(Paths.image(ext + 'polusSky'));
	sky.antialiasing = true;
	sky.scrollFactor.set(0.5, 0.5);
	sky.active = false;
	sky.updateHitbox();
	add(sky);

	var rocks:FlxSprite = new FlxSprite(-915.8, -411.3).loadGraphic(Paths.image(ext + 'polusrocks'));
	rocks.scrollFactor.set(0.6, 0.6);
	rocks.antialiasing = true;
	rocks.active = false;
	rocks.updateHitbox();
	add(rocks);

	var hills:FlxSprite = new FlxSprite(-1238.05, -180.55).loadGraphic(Paths.image(ext + 'polusHills'));
	hills.scrollFactor.set(0.9, 0.9);
	hills.antialiasing = true;
	hills.active = false;
	hills.updateHitbox();
	add(hills);

	var warehouse:FlxSprite = new FlxSprite(-458.35, -315.6).loadGraphic(Paths.image(ext + 'polusWarehouse'));
	warehouse.scrollFactor.set(0.9, 0.9);
	warehouse.antialiasing = true;
	warehouse.active = false;
	warehouse.updateHitbox();
	add(warehouse);

	var ground:FlxSprite = new FlxSprite(-580.9, 241.85).loadGraphic(Paths.image(ext + 'polusGround'));
	ground.antialiasing = true;
	ground.active = false;
	ground.updateHitbox();
	add(ground);
}

function onCreatePost()
{
	camSpecialThing([150, 350], [700, 350], -1);
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
		case 'Legacy':
			switch (value1)
			{
				case 'green':
					camSpecialThing([300, 300], [700, 350], -1); //I'm doing this my own special way

				case 'not green':
					camSpecialThing([150, 350], [700, 350], -1);
			}

		case 'Opponent Two':
			twoSing = Std.int(value1) == 1;
			triggerEventNote("Legacy", twoSing ? "green" : "not green", "");

			if (allowIconSwitching) refreshDoubleTroubleIcon();

		case 'Both Opponents':
			bothSing = Std.int(value1) == 1;

			if (allowIconSwitching) refreshDoubleTroubleIcon();
	}
}

function refreshDoubleTroubleIcon()
{
	if (hasColor) scoreTxt.color = bothSing ? hpColorDuo : (twoSing ? gf : dad).healthColour;
	playHUD.healthBar.setColors(bothSing ? hpColorDuo : (twoSing ? gf : dad).healthColour, boyfriend.healthColour);
	playHUD.iconP2.changeIcon(bothSing ? oppIconDuo : (twoSing ? oppIconExtra : oppIconBase));
	pauseOverride = bothSing ? pauseDuo : (twoSing ? pauseExtra : pauseBase);
}