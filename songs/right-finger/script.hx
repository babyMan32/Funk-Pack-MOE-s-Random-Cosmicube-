function onCreatePost() {
    skipCountdown = true;

    var logo:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('onetimeuselol/wight_ringer_titlecard'));
    logo.camera = camHUD;
    logo.scale.set(0, 0);
    logo.screenCenter();
    playHUD.add(logo);
}