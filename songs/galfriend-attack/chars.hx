public var kaity:Character;

var hittingNotes = false;

function onCreatePost()
{
	camSpecialThing([350, 550], [750, 550]);

	mom = new Character(0, 0, 'galfriend-opponent');
	add(mom);
	mom.x = dad.x;
	mom.y = dad.y;

	kaity = new Character(750, 450, 'kaity', true);
	add(kaity);

	dad.x -= 200;
	dad.y -= 100;

	boyfriend.x += 200;
	boyfriend.y -= 100;

	gf.y -= 100;

	modManager.setValue("opponentSwap", 0.5, 0);

	for (i in opponentStrums) i.visible = false;

	comboX = 440;

	Paths.overrideMode = null;

	vSliceScore = new FlxText(0, 0, 1280, (!cpuControlled ? "Score: 0" : "Botplay Enabled"));
	vSliceScore.setFormat(Paths.font("vcr.ttf", false), 16, FlxColor.WHITE, 0, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	vSliceScore.alignment = 'right'; //why were you so hard to figure out
	vSliceScore.visible = false;
	vSliceScore.x = playHUD.scoreTxt.x - 350;
	vSliceScore.y = playHUD.scoreTxt.y + (ClientPrefs.downScroll ? -125 : 5);
	playHUD.add(vSliceScore);
}

function onSpawnNote(note)
{
	if (note.lane != 0)
	{
		note.ignoreNote = true;
		note.noAnimation = true;
	}

	if (note.noteType != 'Opponent Two' && note.noteType != 'Dad Sing' && note.noteType != 'Dad Sing Alt' && note.noteType != 'Kaity Sing') return;

	note.noMissAnimation = true;
}

function onUpdatePost(elapsed:Float):Void
{
	if (cpuControlled)
	{
		vSliceScore.text = "Botplay Enabled";
		return;
	}

	vSliceScore.text = "Score: " + songScore;
}

function goodNoteHitPre(note:Note):Void
{
	final susMult:Float = (note.isSustainNote ? 1 / PlayState.instance.holdSubdivisions : 1);
	final oppHealthGain:Float = (note.hitHealth * healthGain * susMult) * 2;

	hittingNotes = true;

	switch (note.noteType)
	{
		case 'Opponent Two':
			note.owner = mom;
			if (!mustHitSection) camCurTarget = mom;
			yesThisIsAFunctionIMade(mom, 'opponent', 'slice');
			health -= oppHealthGain;

		case 'Dad Sing':
			note.owner = dad;
			camCurTarget = null;
			yesThisIsAFunctionIMade(dad, 'opponent', 'slice');
			health -= oppHealthGain;

		case 'Dad Sing Alt':
			note.owner = dad;
			camCurTarget = null;
			dad.animSuffix = '-alt';
			yesThisIsAFunctionIMade(dad, 'opponent', 'slice');
			health -= oppHealthGain;

		case 'Kaity Sing':
			note.owner = kaity;
			if (mustHitSection) camCurTarget = kaity;
			yesThisIsAFunctionIMade(kaity, 'player');

		default:
			camCurTarget = null;
			yesThisIsAFunctionIMade(boyfriend, 'player');
	}
}

function noteMiss(note:Note):Void
{
	switch (note.noteType)
	{
		case 'Opponent Two':
			health += ((note.missHealth * healthLoss) * (PlayState.instance.missCombo + 1));
			mom.playAnim(note.skin.singAnimations[note.noteData] + 'miss', true);
			yesThisIsAFunctionIMade(mom, 'opponent', 'slice');
			mom.holdTimer = 0;

		case 'Dad Sing', 'Dad Sing Alt':
			health += ((note.missHealth * healthLoss) * (PlayState.instance.missCombo + 1));
			dad.playAnim(note.skin.singAnimations[note.noteData] + 'miss', true);
			yesThisIsAFunctionIMade(dad, 'opponent', 'slice');
			dad.holdTimer = 0;

		case 'Kaity Sing':
			kaity.playAnim(note.skin.singAnimations[note.noteData] + 'miss', true);
			yesThisIsAFunctionIMade(kaity, 'player');
			kaity.holdTimer = 0;

		default:
			yesThisIsAFunctionIMade(boyfriend, 'player');
	}

	hittingNotes = false;
}

function yesThisIsAFunctionIMade(character, position, ?engine = 'psych')
{
	playHUD.scoreTxt.color = character.healthColour;

	if (position == 'player')
	{
		playHUD.iconP1.changeIcon(character.healthIcon);
		playHUD.healthBar.setColors(null, (engine != 'slice' ? character.healthColour : 0x66ff33));
	}

	if (position == 'opponent')
	{
		playHUD.iconP2.changeIcon(character.healthIcon);
		playHUD.healthBar.setColors((engine != 'slice' ? character.healthColour : 0xff0000), null);
	}

	if (engine == 'slice')
	{
		playHUD.scoreTxt.visible = false;
		vSliceScore.visible = true;
	}
	else
	{
		playHUD.scoreTxt.visible = true;
		vSliceScore.visible = false;
	}
}

function onCountdownTick(tick:Int):Void
{
	if (kaity == null || tick == 4) return;
	
	kaity.onBeatHit(tick);
}

function onBeatHit():Void
{
	if (kaity != null) kaity.onBeatHit(curBeat);
}

function onGameOver()
{
	if (hittingNotes)
	{
		health = 0;
		return Function_Stop;
	}
}