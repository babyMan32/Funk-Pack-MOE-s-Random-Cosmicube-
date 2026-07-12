public var kadeBar:FlxSprite;
public var kadeBarOpp:FlxSprite;
public var kadeBarPlay:FlxSprite;
public var kadeIconBF:HealthIcon;
public var kadeIconDad:HealthIcon;

function onCreatePost()
{
	if (!init_kade_hud) return;

	playHUD.healthBar.visible = false;
	playHUD.iconP1.visible = false;
	playHUD.iconP2.visible = false;

	barInitiation();
	iconInitiation();
}

function barInitiation()
{
	kadeBar = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBar'));
	kadeBar.alpha = ClientPrefs.healthBarAlpha;
	kadeBar.visible = !ClientPrefs.hideHud;
	kadeBar.screenCenter();
	playHUD.add(kadeBar);

	kadeBar.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);

	kadeBarOpp = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBarEnnards', null, null, PathsTestMode.LOOSE));
	kadeBarOpp.alpha = ClientPrefs.healthBarAlpha;
	kadeBarOpp.visible = !ClientPrefs.hideHud;
	kadeBarOpp.screenCenter();
	playHUD.add(kadeBarOpp);

	kadeBarOpp.scale.x = 1.001;
	kadeBarOpp.scale.y = 1.2;
	kadeBarOpp.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);
	kadeBarOpp.color = dad.healthColour;

	kadeBarPlay = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBarEnnards', null, null, PathsTestMode.LOOSE));
	kadeBarPlay.alpha = ClientPrefs.healthBarAlpha;
	kadeBarPlay.visible = !ClientPrefs.hideHud;
	kadeBarPlay.screenCenter();
	playHUD.add(kadeBarPlay);

	kadeBarPlay.scale.y = 1.2;
	kadeBarPlay.x = kadeBar.width - 113;
	kadeBarPlay.y = FlxG.height * (!ClientPrefs.downScroll ? 0.89 : 0.11);
	kadeBarPlay.color = boyfriend.healthColour;
	kadeBarPlay.scale.x = health / 2;
}

function iconInitiation()
{
	kadeIconBF = new HealthIcon(game.boyfriend.healthIcon, true);
	kadeIconBF.alpha = ClientPrefs.healthBarAlpha;
	kadeIconBF.visible = !ClientPrefs.hideHud;
	kadeIconBF.screenCenter();
	playHUD.add(kadeIconBF);

	kadeIconDad = new HealthIcon(game.dad.healthIcon, true);
	kadeIconDad.alpha = ClientPrefs.healthBarAlpha;
	kadeIconDad.visible = !ClientPrefs.hideHud;
	kadeIconDad.screenCenter();
	playHUD.add(kadeIconDad);

	kadeIconDad.flipX = true;

	kadeIconBF.y = kadeBar.y - 75;
	kadeIconDad.y = kadeBar.y - 75;
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

	kadeIconBF.x = (1200 - (health * 300)) - 287.5;
	kadeIconDad.x = (1200 - (health * 300)) - 387.5;

	kadeIconBF.updateIconAnim((health * 50) * 0.01);
	kadeIconDad.updateIconAnim((100 - (health * 50)) * 0.01);
}