import flixel.group.FlxGroup.FlxTypedGroup;
import funkin.states.FreeplayState;

var grpMenuShit:FlxTypedGroup<Alphabet>;

var menuItems:Array<String> = [];
var menuItemsOG:Array<String> = ['Resume', 'Restart Song', 'Exit to menu'];
var difficultyChoices = [];
var curSelected:Int = 0;

var pauseMusic:FlxSound;
var practiceText:FlxText;
var botplayText:FlxText;

var transCamera:FlxCamera;
var canInput:Bool = false;

function onLoad()
{
	// #if debug
	// menuItemsOG.push('Botplay');
	// #end

	menuItemsOG = [Lang.str('resumesong'), Lang.str('restartsong'), Lang.str('backtomenu')];
	menuItems = menuItemsOG;

	difficultyChoices.push('BACK');

	var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	bg.alpha = 0;
	bg.scrollFactor.set();
	add(bg);

	var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
	levelInfo.text += PlayState.SONG.song;
	levelInfo.scrollFactor.set();
	levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
	levelInfo.updateHitbox();
	add(levelInfo);

	// var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
	// levelDifficulty.text += CoolUtil.difficultyString();
	// levelDifficulty.scrollFactor.set();
	// levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
	// levelDifficulty.updateHitbox();
	// add(levelDifficulty);

	var blueballedTxt:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
	blueballedTxt.text = "Blueballed: " + PlayState.deathCounter;
	blueballedTxt.scrollFactor.set();
	blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
	blueballedTxt.updateHitbox();
	add(blueballedTxt);

	var difficulty:FlxText = new FlxText(20, 15 + 32, 0, "NORMAL", 32);
	difficulty.scrollFactor.set();
	difficulty.setFormat(Paths.font('vcr.ttf'), 32);
	difficulty.updateHitbox();
	add(difficulty);

	practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
	practiceText.scrollFactor.set();
	practiceText.setFormat(Paths.font('vcr.ttf'), 32);
	practiceText.x = FlxG.width - (practiceText.width + 20);
	practiceText.updateHitbox();
	practiceText.visible = PlayState.practiceMode;
	add(practiceText);

	botplayText = new FlxText(20, FlxG.height - 40, 0, "BOTPLAY", 32);
	botplayText.scrollFactor.set();
	botplayText.setFormat(Paths.font('vcr.ttf'), 32);
	botplayText.x = FlxG.width - (botplayText.width + 20);
	botplayText.updateHitbox();
	botplayText.visible = PlayState.cpuControlled;
	add(botplayText);

	blueballedTxt.alpha = 0;
	difficulty.alpha = 0;
	//levelDifficulty.alpha = 0;
	levelInfo.alpha = 0;

	blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);
	difficulty.x = FlxG.width - (difficulty.width + 20);
	//levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
	levelInfo.x = FlxG.width - (levelInfo.width + 20);

	grpMenuShit = new FlxTypedGroup();
	add(grpMenuShit);

	for (i in 0...menuItems.length)
	{
		var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		songText.screenCenter(0x01);
		songText.changeAxis = 0x10;
		grpMenuShit.add(songText);
	}

	changeSelection(0);

	cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

	FlxG.signals.postUpdate.addOnce(function () {
		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		// FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(difficulty, {alpha: 1, y: difficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		//FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});

		canInput = true;
	});
}

function onUpdate(elapsed:Float)
{
	if (!canInput) return;
	// if (pauseMusic.volume < 0.5)
	// 	pauseMusic.volume += 0.01 * elapsed;

	var upP = controls.UI_UP_P;
	var downP = controls.UI_DOWN_P;
	var accepted = controls.ACCEPT;

	if (upP)
	{
		changeSelection(-1);
	}

	if (downP)
	{
		changeSelection(1);
	}

	if (accepted)
	{
		var daSelected:String = menuItems[curSelected];

		for (i in 0...difficultyChoices.length-1)
		{
			if (difficultyChoices[i] == daSelected)
			{
				var name:String = PlayState.SONG.song.toLowerCase();
				var poop = Highscore.formatSong(name, curSelected);
				PlayState.SONG = Song.loadFromJson(poop, name);
				PlayState.storyDifficulty = curSelected;
				CustomFadeTransition.nextCamera = transCamera;
				MusicBeatState.resetState();
				FlxG.sound.music.volume = 0;
				PlayState.changedDifficulty = true;
				PlayState.cpuControlled = false;
				return;
			}
		} 

		switch (daSelected)
		{
			case Lang.str('resumesong'):
				close();
			// case 'Change Difficulty':
			// 	menuItems = difficultyChoices;
			// 	regenMenu();
			// case 'Toggle Practice Mode':
			// 	PlayState.practiceMode = !PlayState.practiceMode;
			// 	PlayState.usedPractice = true;
			// 	practiceText.visible = PlayState.practiceMode;
			case Lang.str('restartsong'):
				// CustomFadeTransition.nextCamera = transCamera;
				FlxG.resetState();
				FlxG.sound.music.volume = 0;
			// case 'Botplay':
			// 	PlayState.cpuControlled = !PlayState.cpuControlled;
			// 	PlayState.usedPractice = true;
			// 	botplayText.visible = PlayState.cpuControlled;
			case Lang.str('backtomenu'):
				PlayState.deathCounter = 0;
				PlayState.seenCutscene = false;
				PlayState.instance.removeModifiers();
				FlxG.switchState(new FreeplayState());
				CoolUtil.cancelMusicFadeTween();
				FunkinSound.playMusic(Paths.music('freakyMenu'));
				PlayState.changedDifficulty = false;

			// case 'BACK':
			// 	menuItems = menuItemsOG;
			// 	regenMenu();
		}
	}
}

// function destroy()
// {
// 	pauseMusic.destroy();
// 	super.destroy();
// }

function changeSelection(change:Int = 0):Void
{
	curSelected += change;

	FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

	if (curSelected < 0)
		curSelected = menuItems.length - 1;
	if (curSelected >= menuItems.length)
		curSelected = 0;

	var bullShit:Int = 0;

	for (item in grpMenuShit.members)
	{
		item.targetY = bullShit - curSelected;
		bullShit++;

		item.alpha = 0.6;
		// item.setGraphicSize(Std.int(item.width * 0.8));

		if (item.targetY == 0)
		{
			item.alpha = 1;
			// item.setGraphicSize(Std.int(item.width));
		}
	}
}

function regenMenu():Void
{
	for (i in 0...grpMenuShit.members.length)
	{
		grpMenuShit.remove(this.grpMenuShit.members[0], true);
	}

	for (i in 0...menuItems.length)
	{
		var item = new Alphabet(0, 70 * i + 30, menuItems[i], true, false);
		item.isMenuItem = true;
		item.targetY = i;
		grpMenuShit.add(item);
	}

	curSelected = 0;
	changeSelection();
}