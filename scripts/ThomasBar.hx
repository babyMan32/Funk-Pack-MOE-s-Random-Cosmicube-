var thomasHealthBar:FlxSprite;

var railwayCheck = false;

function onCreatePost()
{
	thomasHealthBar = new FlxSprite(0, 0).loadGraphic(Paths.image('bar', null, null, PathsTestMode.LOOSE));
	thomasHealthBar.antialiasing = false;
	thomasHealthBar.cameras = [camHUD];
	playHUD.insert(playHUD.members.indexOf(playHUD.healthBar) + 1, thomasHealthBar);
	thomasHealthBar.scale.set(0.492, 0.59);
}

function onUpdatePost(elapsed:Float):Void
{
	thomasHealthBar.x = healthBar.x - 387;
	thomasHealthBar.y = healthBar.y - 127;
	thomasHealthBar.shader = iconP1.shader;
	thomasHealthBar.alpha = healthBar.alpha;

	railwayCheck = boyfriend.getFlag('showdownSkin') ?? false;

	if (!railwayCheck)
	{
		thomasHealthBar.visible = false;
	}
	else
	{
		thomasHealthBar.visible = healthBar.visible;
	}
}