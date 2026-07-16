import funkin.audio.visualize.PolygonSpectogram;
import funkin.audio.visualize.PolygonSpectogram.VISTYPE;
import funkin.audio.visualize.SpectogramSprite.SPECDIRECTION;

var thisIsBullshit:Bool = true;
var womenIsFucked:Bool = false;

function onLoad()
{
    abot_dsides = new FlxSpriteGroup();
    abot_dsides.x += 80;
	abot_dsides.y -= 80;
    gfGroup.insert(0, abot_dsides);

    a_bot_screen_dsides = new FlxSprite(40, 300).loadGraphic(Paths.image('characters/PicoSchool/Nene/ABotScreenFill', null, null, PathsTestMode.LOOSE));
    abot_dsides.add(a_bot_screen);


    a_bot_dsides = new FlxSprite();
    a_bot_dsides.frames = Paths.getSparrowAtlas('characters/PicoSchool/Nene/ABotIdle', null, null, PathsTestMode.LOOSE);
    a_bot_dsides.animation.addByPrefix('idle', 'ABot', 24, false);
    a_bot_dsides.animation.play('idle');
    abot_dsides.add(a_bot_dsides);

    abot_dsides.x -= 180;
    abot_dsides.y += a_bot_dsides.height / 2;

    if (FlxG.random.bool(10))
    {
        gf.idleSuffix = '-fucked';
        gf.recalculateDanceIdle();
        gf.playAnim('idle-fucked', true);
		womenIsFucked = true;
    }
}

function onCreatePost(){
    // dadGroup.zIndex += 1;
    // gfGroup.zIndex -= 1;
    // boyfriendGroup.zIndex += 1;
    
    refreshZ(stage);

    if(ClientPrefs.lowQuality || ClientPrefs.streamedMusic) return;

    viz = new PolygonSpectogram(PlayState.instance.audio.inst, 0xFF00FF00, a_bot_screen_dsides.width - 35, 1, SPECDIRECTION.HORIZONTAL);
    viz.thickness = 2;
    viz.alpha = 0.4;
    viz.waveAmplitude *= 0.75;
    viz.setPosition(55, 380);

    green = new FlxSprite(55, 380).makeGraphic(a_bot_screen_dsides.width - 35, 1, 0xFF00FF00);

    abot.insert(1, viz);
    abot.insert(1, green);

	if (thisIsBullshit) return;

        var vizDarnell = new PolygonSpectogram(vocals.opponentVocals.members[0], dad.healthColour, a_bot_screen_dsides.height, 2, SPECDIRECTION.HORIZONTAL);
        vizDarnell.setPosition(55, 345);
        vizDarnell.alpha = 0.8;
        abot.insert(1, vizDarnell);

        purp = new FlxSprite(55, 345).makeGraphic(a_bot_screen_dsides.width, 1, dad.healthColour);
        abot.insert(1, purp);

        var vizPico = new PolygonSpectogram(vocals.playerVocals.members[0], boyfriend.healthColour, a_bot_screen_dsides.height, 2, SPECDIRECTION.HORIZONTAL);
        vizPico.setPosition(55, 417);
        vizPico.alpha = 0.8;
        abot.insert(1, vizPico);

        pink = new FlxSprite(55, 417).makeGraphic(a_bot_screen_dsides.width, 1, boyfriend.healthColour);
        abot.insert(1, pink);
}

function onSongStart(){
    if (ClientPrefs.lowQuality || ClientPrefs.streamedMusic || thisIsBullshit) return;

    green.visible = false;
    pink.visible = false;
    purp.visible = false;
}

function onBeatHit()
{
    if ((curBeat % 2 == 0) && womenIsFucked && gf.getAnimName() == 'idle-fucked')
    {
        gf.playAnim('idle-fucked', true);
    }
}

var inTunnel = false;

var curShader = null;
function onUpdate(elapsed){
    if (curShader == gf.shader) return;
    curShader = gf.shader;
    for (i in abot.members)
        i.shader = curShader;
}
