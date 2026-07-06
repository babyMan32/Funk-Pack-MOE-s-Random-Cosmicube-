var trsCharacters = ["TRSBF", "ghostJames", "thomas-termination-p1"];

var signalBodyPlayer:FlxSprite;
var signalLightPlayer:FlxSprite;

var signalBodyOpponent:FlxSprite;

var charWinning = 'nil';

function onCreatePost()
{
	if (trsCharacters.contains(boyfriend.curCharacter))
	{
		createSignals();
	}
}

function createSignals()
{
	signalBodyPlayer = new FlxSprite(0, 0).loadGraphic(Paths.image('signals/Signal_Body', null, null, PathsTestMode.LOOSE));
	signalBodyPlayer.camera = PlayState.instance.camHUD;
	signalBodyPlayer.antialiasing = false;
	signalBodyPlayer.screenCenter();
	signalBodyPlayer.updateHitbox();
	add(signalBodyPlayer);

	signalLightPlayer = new FlxSprite(0, 0);
	signalLightPlayer.frames = Paths.getSparrowAtlas('signals/SignalBladeAnimated', null, null, PathsTestMode.LOOSE);
	signalLightPlayer.animation.addByPrefix('stop', 'signal red', 24, false);
	signalLightPlayer.animation.addByPrefix('go', 'signal green', 24, false);
	signalLightPlayer.camera = PlayState.instance.camHUD;
	signalLightPlayer.animation.play('stop', true);
	signalLightPlayer.screenCenter();
	signalLightPlayer.updateHitbox();
	add(signalLightPlayer);

	signalBodyOpponent = new FlxSprite(0, 0).loadGraphic(Paths.image('signals/Signal_Body', null, null, PathsTestMode.LOOSE));
	signalBodyOpponent.camera = PlayState.instance.camHUD;
	signalBodyOpponent.antialiasing = false;
	signalBodyOpponent.screenCenter();
	signalBodyOpponent.updateHitbox();
	add(signalBodyOpponent);

	signalBodyPlayer.scale.set(0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));
	signalLightPlayer.scale.set(0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));

	signalBodyOpponent.scale.set(-0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));

	signalBodyPlayer.x = healthBar.x + 673;
	signalBodyPlayer.y = healthBar.y - (ClientPrefs.downScroll ? 178 : 128);
	signalLightPlayer.x = healthBar.x + 587;
	signalLightPlayer.y = healthBar.y - (ClientPrefs.downScroll ? 28 : 178);

	signalBodyOpponent.x = healthBar.x - 107;
	signalBodyOpponent.y = healthBar.y - (ClientPrefs.downScroll ? 178 : 128);
}

function onSongStart()
{
	FlxTween.tween(signalLightPlayer, {angle: (ClientPrefs.downScroll ? 45 : -45)}, 0.5, {ease: FlxEase.sineOut});
	signalLightPlayer.animation.play('go', true);
}

function onUpdatePost()
{
	if (health <= 0.4 && charWinning == 'nil')
	{
		FlxTween.tween(signalLightPlayer, {angle: 0}, 0.5, {ease: FlxEase.sineOut});
		signalLightPlayer.animation.play('stop', true);
		charWinning = 'opp';
	}
	else if (health > 0.4 && charWinning == 'opp')
	{
		FlxTween.tween(signalLightPlayer, {angle: (ClientPrefs.downScroll ? 45 : -45)}, 0.5, {ease: FlxEase.sineOut});
		signalLightPlayer.animation.play('go', true);
		charWinning = 'nil';
	}
}