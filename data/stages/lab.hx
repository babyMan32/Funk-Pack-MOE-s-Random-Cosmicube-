var ext = 'stages/wrongfinger/right/';

function onLoad() {
    var lab2:FlxSprite = new FlxSprite(465, 25).loadGraphic(Paths.image(ext + 'BG splice/labbe splice'));
    lab2.alpha = 0;
    add(lab2);

    var lab:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'labbe'));
    add(lab);

    var chair:FlxSprite = new FlxSprite(2175, 640).loadGraphic(Paths.image(ext + 'BG splice/chair sized'));
    chair.alpha = 0;
    add(chair);

    var wire:FlxSprite = new FlxSprite(350, 25).loadGraphic(Paths.image(ext + 'fg wire 1'));
    wire.scrollFactor.set(1.2, 1.2);
    add(wire);

    var wire2:FlxSprite = new FlxSprite(1250, 30).loadGraphic(Paths.image(ext + 'fg wire 2'));
    wire.scrollFactor.set(1.25, 1.25);
    add(wire2);

    var wire3:FlxSprite = new FlxSprite(2100, 25).loadGraphic(Paths.image(ext + 'fg wire 3'));
    wire.scrollFactor.set(1.15, 1.15);
    add(wire3);

    var overlay:FlxSprite = new FlxSprite(-55, -25).loadGraphic(Paths.image(ext + 'big ol graddie'));
    overlay.blend = BlendMode.OVERLAY;
    add(overlay);

    var overlay2:FlxSprite = new FlxSprite(1000, -100).loadGraphic(Paths.image(ext + 'greenie graddie'));
    overlay2.blend = BlendMode.OVERLAY;
    add(overlay2);

    var overlay3:FlxSprite = new FlxSprite(465, 25).loadGraphic(Paths.image(ext + 'BG splice/big ol graddie splace'));
    overlay3.blend = BlendMode.OVERLAY;
    overlay3.alpha = 0;
    add(overlay3);

    var overlay4:FlxSprite = new FlxSprite(750, 0).loadGraphic(Paths.image(ext + 'BG splice/greennie graddie splice'));
    overlay4.blend = BlendMode.OVERLAY;
    overlay4.alpha = 0;
    add(overlay4);

    var transition:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext +  'blur pan lab'));
    transition.camera = camHUD;
    transition.screenCenter();
    transition.x = -4600;
    add(transition);
}