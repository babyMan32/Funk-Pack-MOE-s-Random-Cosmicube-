public var kaity:Character;

var hittingNotes = false;

var legallyDistinctMissCombo = 0;

function onCreatePost()
{
	canFollow = false;
	camSpecialThing([650, 550], [650, 550], 0.7);

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

	comboX = 400;
}

function onSpawnNote(note)
{
	if (note.lane != 0)
	{
		note.visible = false;
		note.noAnimation = true;
	}

	note.setCustomColor([0xf9393f /*red channel*/, 0xffffff /*green channel*/, 0x651038 /*blue channel*/]);

	if (note.noteType != 'Opponent Two' && note.noteType != 'Dad Sing' && note.noteType != 'Dad Sing Alt' && note.noteType != 'Kaity Sing') return;

	note.noMissAnimation = true;

	switch (note.noteType)
	{
		case 'Dad Sing', 'Dad Sing Alt':
			note.setCustomColor([0xc24b99 /*red channel*/, 0xffffff /*green channel*/, 0x3c1f56 /*blue channel*/]);

		case 'Opponent Two':
			note.setCustomColor([0x00ffff /*red channel*/, 0xffffff /*green channel*/, 0x1542b7 /*blue channel*/]);

		case 'Kaity Sing':
			note.setCustomColor([0x12fa05 /*red channel*/, 0xffffff /*green channel*/, 0x0a4447 /*blue channel*/]);
	}
}

function goodNoteHitPre(note:Note):Void
{
	final susMult:Float = (note.isSustainNote ? 1 / PlayState.instance.holdSubdivisions : 1);
	final oppHealthGain:Float = (note.hitHealth * healthGain * susMult) * 2;

	legallyDistinctMissCombo = 0;

	hittingNotes = true;

	switch (note.noteType)
	{
		case 'Opponent Two':
			note.owner = mom;
			health -= oppHealthGain;
			if (!mustHitSection) camCurTarget = mom;
			yesThisIsAFunctionIMade(mom, 'opponent');

		case 'Dad Sing':
			note.owner = dad;
			camCurTarget = null;
			health -= oppHealthGain;
			yesThisIsAFunctionIMade(dad, 'opponent');

		case 'Dad Sing Alt':
			note.owner = dad;
			camCurTarget = null;
			health -= oppHealthGain;
			note.animSuffix = '-alt';
			yesThisIsAFunctionIMade(dad, 'opponent');

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
	legallyDistinctMissCombo++;

	switch (note.noteType)
	{
		case 'Opponent Two':
			health += ((note.missHealth * healthLoss) * (legallyDistinctMissCombo + 1));
			mom.playAnim(note.skin.singAnimations[note.noteData] + 'miss', true);
			yesThisIsAFunctionIMade(mom, 'opponent');
			PlayState.instance.missCombo = 0;
			mom.holdTimer = 0;

		case 'Dad Sing', 'Dad Sing Alt':
			health += ((note.missHealth * healthLoss) * (legallyDistinctMissCombo + 1));
			dad.playAnim(note.skin.singAnimations[note.noteData] + 'miss', true);
			yesThisIsAFunctionIMade(dad, 'opponent');
			PlayState.instance.missCombo = 0;
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
		playHUD.healthBar.setColors(null, character.healthColour);
	}

	if (position == 'opponent')
	{
		playHUD.iconP2.changeIcon(character.healthIcon);
		playHUD.healthBar.setColors(character.healthColour, null);
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

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 != 'camShit') return;

			canFollow = true;
			defaultCamZoom = 0.9;

			switch (value2)
			{
				case 'opp1':
					camSpecialThing([350, 500], [350, 500]);

				case 'opp2':
					camSpecialThing([550, 600], [550, 600]);

				case 'opps':
					camSpecialThing([450, 550], [450, 550]);

				case 'play1':
					camSpecialThing([950, 500], [950, 500]);

				case 'play2':
					camSpecialThing([750, 600], [750, 600]);

				case 'plays':
					camSpecialThing([850, 550], [850, 550]);

				case 'all':
					canFollow = false;
					camSpecialThing([650, 550], [650, 550], 0.7);
			}
	}
}