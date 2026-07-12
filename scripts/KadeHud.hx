public var camMovedToPlay = false;
public var camMovedToOpp = false;

public var init_kade_hud = false;

var watermark:FlxText;
var fakeScoreText:FlxText;

function onCreatePost()
{
	if (!init_kade_hud) return;

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

	playHUD.scoreTxt.visible = false;

	//playHUD.ratingPrefix = 'ui/v3/'; //pulled straight from Impostor V3's assets

	FlxG.mouse.visible = false;

	dad.camDisplacement = boyfriend.camDisplacement = 0;
	
	boyfriend.gameoverLoopDeathSound = 'v3/gameOver';
	boyfriend.gameoverConfirmDeathSound = 'v3/gameOverEnd'; //so retro

	healthBar.y += 5;
	iconP1.y += 5;
	iconP2.y += 5; //lower the healthbar ever so sligjhtly
}

function onUpdate(elapsed:Float):Void
{
	if (!init_kade_hud) return;

	iconP1.scale.x = iconP1.scale.y = iconP2.scale.x = iconP2.scale.y = 1; //that signature kade engine icon bop
}

function onUpdatePost(elapsed:Float):Void
{
	if (!init_kade_hud) return;

	fakeScoreText.text = "Score: " + songScore + " | Combo Breaks: " + songMisses + " | Accuracy: " + Math.round(ratingPercent * 10000) / 100 + "% | " + KadeCombos() + KadeRatings();
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