using StringTools;

var camX:Float = 900;
var camY:Float = 475;
var stageBannedFromChance:Bool = false;
var allow_taunt = true;

var animSuffixVariable:Array = ["", "-beatbox"];
var animSuffixInt:Int = 0;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		//availible stages first

		case "polus":
			camX = 820;
			camY = 250;

		case "reactor":
			camX = 1725;
			camY = 1100;

		case "airship":
			camX = 700;
			camY = 500;

		case "defeat":
			camX = 750;
			camY = 500;

		case "maroon":
			camX = 1800;
			camY = 1300;

		case "boiling":
			camX = 1760;
			camY = 380;

		case "grey":
			camX = 1800;
			camY = 700;

		case "greenhouse":
			camX = 380;
			camY = 300;

		case "chef":
			camX = 1400;
			camY = 800;

		case "lounge":
			camX = 1000;
			camY = 700;

		case "roomcode": //only here cause roomcode has skins off and "Roomcode (BF Mix)"
			camX = 1000;
			camY = 580;

		case "tomtus":
			camX = 1200;
			camY = 650;

		case "jads":
			camX = 1150;
			camY = 440;

		case "henry":
			camX = 1000;
			camY = 550;

		case "jerma":
			camX = 1000;
			camY = 625;

		case "drippypop":
			camX = 1350;
			camY = 600;

		case "dave":
			camX = 980;
			camY = 730;

		case "medbay":
			camX = 810;
			camY = 450;

		case "horse":
			camY = 380;

		case "hall":
			camX = 650;
			camY = 600;

		//now the bullshit

		case "ejected":
			stageBannedFromChance = true; //me when video intro

		case "danger", "beach", "beach-old":
			stageBannedFromChance = true; //custom intro zoom

		case "cargo", "monotone", "finalem", "victory":
			stageBannedFromChance = true; //too dark to see

		case "pretender":
			stageBannedFromChance = true; //that stupid fucking achievement

		case "voting":
			stageBannedFromChance = true; //four people

		case "turbulence":
			stageBannedFromChance = true; //c  l  a  w

		case "skeldpixel":
			stageBannedFromChance = true; //its pixel

		case "security2":
			stageBannedFromChance = true; //thats pico

		case "kills", "who", "idk":
			stageBannedFromChance = true; //bf skins off

		case "nuzzus", "esculent":
			stageBannedFromChance = true; //cant see bf

		case "attack":
			stageBannedFromChance = true; //bf is not a dev

		case "doubletrouble":
			stageBannedFromChance = true; //it kept running both intros and freaking out

		case "piptowers":
			stageBannedFromChance = true; //chip

		case "warehouse":
			stageBannedFromChance = true; //torture
	}

	checkStupid();
}

function onCreatePost()
{
	if (boyfriend.curCharacter == 'bf-hoodie')
	{
		if (FlxG.random.bool(5))
		{
			boyfriend.idleSuffix = '-stupid';
			boyfriend.recalculateDanceIdle();
			boyfriend.playAnim('idle-stupid', true); //autism chance
		}
	}
}

function checkStupid():Void
{
	if (FlxG.random.bool(15) && !stageBannedFromChance)
	{
		songStartCallback = durh;
	}
}

function durh():Void
{
	PlayState.seenCutscene = true;
	inCutscene = true;

	camHUD.alpha = 0.0001;

	var speenSound:FlxSound = FlxG.sound.load(Paths.sound('rareChance/woosh', null, PathsTestMode.LOOSE));

	FlxG.signals.postUpdate.addOnce(function() {
		snapCamToPos(camX, camY);

		boyfriend.playAnim('intro', true);

		boyfriend.specialAnim = boyfriend.holding = true;
	});

	new FlxTimer().start(1.05, function(_) speenSound.play());

	new FlxTimer().start(2.3, function(_) {
		FlxTween.tween(camHUD, {alpha: 1}, 1.5, {ease: FlxEase.quartInOut});

		inCutscene = false;
		startCountdown();
	});
}

function onUpdate(elapsed:Float):Void
{
	animSwap();

	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bf-hoodie' && allow_taunt)
	{
		boyfriend.playAnim('yo');

		boyfriend.specialAnim = boyfriend.holding = true;

		if (FlxG.random.bool(20))
		{
			boyfriend.playAnim('miau');

			boyfriend.specialAnim = boyfriend.holding = true;
		}

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'miau' && boyfriend.getAnimName() != 'yo')
	{
		allow_taunt = true;
	}
}

function animSwap()
{
	if (FlxG.keys.justPressed.SHIFT && boyfriend.curCharacter == 'bf-hoodie')
	{
		animSuffixInt = (animSuffixInt + 1) % 2;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
	}
}

function onStepHit()
{
	if (curStep == 1847 && songName == "Triple Threat")
	{
		boyfriend.animSuffix = "-alt";
	}
}