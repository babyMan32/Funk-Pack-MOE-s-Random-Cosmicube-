public var kaity:Character;

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
}

function goodNoteHitPre(note:Note):Void
{
	switch (note.noteType)
	{
		case 'Opponent Two':
			note.owner = mom;
			if (!mustHitSection) camCurTarget = mom;
			playHUD.iconP2.changeIcon(mom.healthIcon);
			playHUD.healthBar.setColors(mom.healthColour, null);

		case 'Dad Sing':
			note.owner = dad;
			camCurTarget = null;
			playHUD.iconP2.changeIcon(dad.healthIcon);
			playHUD.healthBar.setColors(dad.healthColour, null);

		case 'Dad Sing Alt':
			note.owner = dad;
			camCurTarget = null;
			dad.animSuffix = '-alt';
			playHUD.iconP2.changeIcon(dad.healthIcon);
			playHUD.healthBar.setColors(dad.healthColour, null);

		case 'Kaity Sing':
			note.owner = kaity;
			if (mustHitSection) camCurTarget = kaity;
			playHUD.iconP1.changeIcon(kaity.healthIcon);
			playHUD.healthBar.setColors(null, kaity.healthColour);

		default:
			camCurTarget = null;
			playHUD.iconP1.changeIcon(boyfriend.healthIcon);
			playHUD.healthBar.setColors(null, boyfriend.healthColour);
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