var camMovedToPlay = false;
var camMovedToOpp = false;

public var init_kade_hud = false;

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

	playHUD.ratingPrefix = 'ui/v3/';

	FlxG.mouse.visible = false;

	gf.camDisplacement = dad.camDisplacement = boyfriend.camDisplacement = 0;
}

function onUpdate(elapsed:Float):Void
{
	iconP1.scale.x = iconP1.scale.y = iconP2.scale.x = iconP2.scale.y = 1;
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