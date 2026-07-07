var trsCharacters = ["TRSBF", "ghostJames", "thomas-termination-p1"];

var signalBodyPlayer:FlxSprite;
var signalLightPlayer:FlxSprite;

var signalBodyOpponent:FlxSprite;

var charWinning = 'nil';

var trsCharsAsPlayer = false;

function onCreatePost()
{
	if (trsCharacters.contains(boyfriend.curCharacter))
	{
		createSignals();
		trsCharsAsPlayer = true;
	}
}

function createSignals()
{
	signalLightPlayer = new FlxSprite(0, 0);
	signalLightPlayer.frames = Paths.getSparrowAtlas('signals/SignalBladeAnimated', null, null, PathsTestMode.LOOSE);
	signalLightPlayer.animation.addByPrefix('stop', 'signal red', 24, false);
	signalLightPlayer.animation.addByPrefix('go', 'signal green', 24, false);
	signalLightPlayer.cameras = [camHUD];
	signalLightPlayer.animation.play('stop', true);
	signalLightPlayer.screenCenter();

	signalBodyOpponent = new FlxSprite(0, 0).loadGraphic(Paths.image('signals/Signal_Body', null, null, PathsTestMode.LOOSE));
	signalBodyOpponent.cameras = [camHUD];
	signalBodyOpponent.antialiasing = false;
	signalBodyOpponent.screenCenter();
	
	signalBodyPlayer = new FlxSprite(0, 0).loadGraphic(Paths.image('signals/Signal_Body', null, null, PathsTestMode.LOOSE));
	signalBodyPlayer.cameras = [camHUD];
	signalBodyPlayer.antialiasing = false;
	signalBodyPlayer.screenCenter();

	signalLightOpponent = new FlxSprite(0, 0);
	signalLightOpponent.frames = Paths.getSparrowAtlas('signals/SignalBladeAnimated', null, null, PathsTestMode.LOOSE);
	signalLightOpponent.animation.addByPrefix('stop', 'signal red', 24, false);
	signalLightOpponent.animation.addByPrefix('go', 'signal green', 24, false);
	signalLightOpponent.cameras = [camHUD];
	signalLightOpponent.animation.play('stop', true);
	signalLightOpponent.screenCenter();

	signalBodyPlayer.scale.set(0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));
	signalLightPlayer.scale.set(0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));

	signalBodyOpponent.scale.set(-0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));
	signalLightOpponent.scale.set(-0.7, (ClientPrefs.downScroll ? -0.7 : 0.7));

	signalBodyPlayer.x = healthBar.x + 673;
	signalBodyPlayer.y = healthBar.y - (ClientPrefs.downScroll ? 178 : 128);
	signalLightPlayer.x = healthBar.x + 587;
	signalLightPlayer.y = healthBar.y - (ClientPrefs.downScroll ? 28 : 178);

	signalBodyOpponent.x = healthBar.x - 117;
	signalBodyOpponent.y = healthBar.y - (ClientPrefs.downScroll ? 178 : 128);
	signalLightOpponent.x = healthBar.x - 210;
	signalLightOpponent.y = healthBar.y - (ClientPrefs.downScroll ? 28 : 178);

	playHUD.insert(playHUD.members.indexOf(playHUD.healthBar) - 0, signalLightPlayer);
	playHUD.insert(playHUD.members.indexOf(playHUD.healthBar) - 1, signalBodyPlayer);

	playHUD.insert(playHUD.members.indexOf(playHUD.healthBar) - 1, signalBodyOpponent);
	playHUD.insert(playHUD.members.indexOf(playHUD.healthBar) - 0, signalLightOpponent);

	signalLightPlayer.updateHitbox();
	signalBodyPlayer.updateHitbox();

	signalBodyOpponent.updateHitbox();
	signalLightOpponent.updateHitbox();
}

function onSongStart()
{
	if (!trsCharsAsPlayer) return;

	FlxTween.tween(signalLightPlayer, {angle: (ClientPrefs.downScroll ? 45 : -45)}, 0.5, {ease: FlxEase.sineOut});
	signalLightPlayer.animation.play('go', true);

	FlxTween.tween(signalLightOpponent, {angle: (ClientPrefs.downScroll ? -45 : 45)}, 0.5, {ease: FlxEase.sineOut});
	signalLightOpponent.animation.play('go', true);
}

function onUpdatePost()
{
	if (!trsCharsAsPlayer) return;

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

	if (health >= 1.6 && charWinning == 'nil')
	{
		FlxTween.tween(signalLightOpponent, {angle: 0}, 0.5, {ease: FlxEase.sineOut});
		signalLightOpponent.animation.play('stop', true);
		charWinning = 'play';
	}
	else if (health < 1.6 && charWinning == 'play')
	{
		FlxTween.tween(signalLightOpponent, {angle: (ClientPrefs.downScroll ? -45 : 45)}, 0.5, {ease: FlxEase.sineOut});
		signalLightOpponent.animation.play('go', true);
		charWinning = 'nil';
	}
}