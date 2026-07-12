function onCreatePost()
{
	if (!init_kade_hud) return;

	playHUD.healthBar.visible = false;

	kadeBar = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBar'));
	kadeBar.screenCenter();
	kadeBar.visible = !ClientPrefs.hideHud;
	kadeBar.alpha = ClientPrefs.healthBarAlpha;
	playHUD.add(kadeBar);

	kadeBar.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);

	kadeBarOpp = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBarEnnards', null, null, PathsTestMode.LOOSE));
	kadeBarOpp.screenCenter();
	kadeBarOpp.visible = !ClientPrefs.hideHud;
	kadeBarOpp.alpha = ClientPrefs.healthBarAlpha;
	playHUD.add(kadeBarOpp);

	kadeBarOpp.scale.x = 1.001;
	kadeBarOpp.scale.y = 1.2;
	kadeBarOpp.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);
	kadeBarOpp.color = dad.healthColour;

	kadeBarPlay = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBarEnnards', null, null, PathsTestMode.LOOSE));
	kadeBarPlay.screenCenter();
	kadeBarPlay.visible = !ClientPrefs.hideHud;
	kadeBarPlay.alpha = ClientPrefs.healthBarAlpha;
	playHUD.add(kadeBarPlay);

	kadeBarPlay.scale.y = 1.2;
	kadeBarPlay.x = kadeBar.width - 113;
	kadeBarPlay.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);
	kadeBarPlay.color = boyfriend.healthColour;
	kadeBarPlay.scale.x = health / 2;
}

function onUpdatePost(elapsed:Float):Void
{
	if (health < 2)
	{
		kadeBarPlay.x = kadeBar.width - ((113 * health) - (35 * (1 - health)));
		kadeBarPlay.scale.x = health / 2;
	}

	if (health >= 2)
	{
		kadeBarPlay.scale.x = 1.001;
		kadeBarPlay.screenCenter();
		kadeBarPlay.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);
	}
}