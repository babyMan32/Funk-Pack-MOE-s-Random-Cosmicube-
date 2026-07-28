function onCreatePost() {
    skipCountdown = true;

    logo = new FlxSprite(0, 0).loadGraphic(Paths.image('onetimeuselol/wight_ringer_titlecard'));
    logo.camera = camHUD;
    logo.scale.set(0, 0);
    logo.screenCenter();
    playHUD.add(logo);
}

function onEvent(ev, v1, v2)
{
	if (ev == 'Legacy')
	{
		switch (v1)
		{
			case 'renderin':
				FlxTween.tween(logo, {"scale.x": 0.75, "scale.y": 0.75}, 1.75, {startDelay: 0.25, ease: FlxEase.quartOut});
            case 'renderout':
                FlxTween.tween(logo, {"scale.x": 0, "scale.y": 0}, 1.25, {startDelay: 1, ease: FlxEase.quintIn});
        }
    }
}