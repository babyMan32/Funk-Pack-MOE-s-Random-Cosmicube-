public var camMovedToPlay = false;
public var camMovedToOpp = false;

public var init_kade_hud = false;

public var watermark:FlxText;

public var fakeScoreText:FlxText;

var deathLoop;
var deathEnd;
var displace;

function onCreatePost()
{
	//cpuControlled = true;

	watermark = new FlxText(0, 0, 0, PlayState.SONG.song + " - Normal | KE 1.6");
	watermark.setFormat(Paths.font("vcr.ttf"), 14, FlxColor.WHITE, 0, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	watermark.visible = !ClientPrefs.hideHud;
	watermark.x += 5;
	watermark.y = FlxG.height - 20;
	playHUD.add(watermark); //kade engine watermark

	fakeScoreText = new FlxText(0, 0, 1280, "Score: 0 | Combo Breaks: 0 | Accuracy: 0% | N/A");
	fakeScoreText.setFormat(Paths.font("vcr.ttf", false), 16, FlxColor.WHITE, 0, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	fakeScoreText.alignment = 'right'; //why were you so hard to figure out
	fakeScoreText.visible = !ClientPrefs.hideHud;
	fakeScoreText.visible = !cpuControlled;
	fakeScoreText.x = playHUD.scoreTxt.x - 250;
	fakeScoreText.y = playHUD.scoreTxt.y + (ClientPrefs.downScroll ? -115 : 15);
	playHUD.add(fakeScoreText);

	displace = boyfriend.camDisplacement;
	deathLoop = boyfriend.gameoverLoopDeathSound;
	deathEnd = boyfriend.gameoverConfirmDeathSound;
}

function onUpdatePost(elapsed:Float):Void
{
	fakeScoreText.text = "Score: " + songScore + " | Combo Breaks: " + songMisses + " | Accuracy: " + Math.round(ratingPercent * 10000) / 100 + "% | " + KadeCombos() + KadeRatings();

	fakeScoreText.visible = !cpuControlled;

	if (init_kade_hud)
	{
		FlxG.mouse.visible = false;
		playHUD.scoreTxt.visible = false;

		boyfriend.canTaunt = false;
		boyfriend.gameoverLoopDeathSound = 'v3/gameOver';
		dad.camDisplacement = boyfriend.camDisplacement = 0;
		boyfriend.gameoverConfirmDeathSound = 'v3/gameOverEnd'; //so retro
	}
	else if (!boyfriend.canTaunt)
	{
		FlxG.mouse.visible = true;
		fakeScoreText.visible = false;
		playHUD.scoreTxt.visible = true;

		boyfriend.canTaunt = true;
		boyfriend.gameoverLoopDeathSound = deathLoop;
		boyfriend.gameoverConfirmDeathSound = deathEnd;
		dad.camDisplacement = boyfriend.camDisplacement = displace;
	}
}

function onMoveCamera(focus) //set anim back to idle to replicate that weird bug kade had
{
	if (!init_kade_hud) return;

	if (middleCam) return;

	if (focus == 'boyfriend' && !camMovedToPlay)
	{
		dad.playAnim('idle', true);

		camMovedToPlay = true;
		camMovedToOpp = false;
	}

	if (focus == 'dad' && !camMovedToOpp)
	{
		boyfriend.playAnim('idle', true);

		camMovedToPlay = false;
		camMovedToOpp = true;
	}
}

function opponentNoteHit(note)
{
	if (!init_kade_hud) return;

	final strumOpp:StrumNote = note.strum;

	if (strumOpp != null)
	{
		strumOpp.playAnim('static', true); //more kade engine jank lovely
	}
}

function goodNoteHit(note)
{
	if (!init_kade_hud) return;

	final strumPlay:StrumNote = note.strum;

	if (strumPlay != null && cpuControlled)
	{
		strumPlay.playAnim('static', true); //more kade engine jank lovely
	}
}

function onPause()
{
	if (!init_kade_hud) return;

	openCustomPause();
	return Function_Stop;
}

function openCustomPause()
{
	game.persistentUpdate = false;
	game.persistentDraw = true;
	game.paused = true;
	game.audio?.pause();

	Paths.overrideMode = PathsTestMode.LOOSE;
	openSubState(new ScriptedSubstate('CustomPauseSubState'));
	Paths.overrideMode = null;
}