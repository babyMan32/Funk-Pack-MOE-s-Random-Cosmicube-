var ext = 'characters/neneshit/abot/';

function onCreatePost()
{
	abot = new FlxSpriteGroup();
	gfGroup.insert(0, abot);

    a_bot_screen = new FlxSprite(-250, 540).loadGraphic(Paths.image('${ext}stereoBG', null, null, PathsTestMode.LOOSE));
	abot.add(a_bot_screen);

	a_bot = new FunkinSprite(-410, 500).loadAtlas('${ext}abotSystem', null, PathsTestMode.LOOSE);
	abot.add(a_bot);

	abot.x = gf.x + 270;
	abot.y = gf.y - 125;
}