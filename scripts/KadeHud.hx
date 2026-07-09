var camMovedToPlay = false;
var camMovedToOpp = false;

public var init_kade_hud = false;

function onLoad()
{
	if (!init_kade_hud) return;

	hasColor = false;
	ClientPrefs.inDevMode = false;
	ClientPrefs.timeBarType = 'Disabled';
	ClientPrefs.fpsDisplayType = 'Disabled';
}

function onCreatePost()
{
	if (!init_kade_hud) return;

	watermark = new FlxText(0, 0, "", PlayState.SONG.song + " Normal - KE 1.4.2");
    watermark.setFormat(Paths.font("vcr.ttf"), 14, FlxColor.WHITE, 0, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	watermark.visible = !ClientPrefs.hideHud;
	watermark.x += 5;
	watermark.y = FlxG.height - 20;
	playHUD.add(watermark);

	fakeScoreText = new FlxText(0, 0, "", "Score: 0 | Combo Breaks: 0 | Accuracy: 0% | N/A");
    fakeScoreText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, 0, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	fakeScoreText.visible = !ClientPrefs.hideHud;
	fakeScoreText.x = playHUD.scoreTxt.x + 400;
	fakeScoreText.y = playHUD.scoreTxt.y + 15;
	playHUD.add(fakeScoreText);

	playHUD.scoreTxt.visible = false;

	playHUD.healthBar.setColors(0xfd0101, 0x6cf83e);
}

function onUpdatePost(elapsed:Float):Void
{
	if (!init_kade_hud) return;

	fakeScoreText.text = "Score: " + songScore + " | Combo Breaks: " + songMisses + " | Accuracy: " + Math.round(ratingPercent * 10000) / 100 + "% | " + KadeCombos() + KadeRatings();
}

function onMoveCamera(focus)
{
	if (!init_kade_hud) return;

	if (focus == 'boyfriend' && !camMovedToPlay)
	{
		dad.playAnim('idle', true);
		gf.playAnim('idle', true);

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

function onPause()
{
	if (!init_kade_hud) return;

	openSubState(new ScriptedSubstate('CustomPauseSubState'));
	return Function_Stop;
}