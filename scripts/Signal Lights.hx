var trsCharacters = ["TRSBF", "ghostJames", "thomas-termination-p1"];

var signalBodyPlayer:FlxSprite;
var signalBodyOpponent:FlxSprite;

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

	signalBodyOpponent = new FlxSprite(0, 0).loadGraphic(Paths.image('signals/Signal_Body', null, null, PathsTestMode.LOOSE));
	signalBodyOpponent.camera = PlayState.instance.camHUD;
	signalBodyOpponent.antialiasing = false;
	signalBodyOpponent.screenCenter();
	signalBodyOpponent.updateHitbox();
	add(signalBodyOpponent);

	if (ClientPrefs.downScroll)
	{
		signalBodyPlayer.scale.set(0.7, -0.7);
		signalBodyOpponent.scale.set(-0.7, -0.7);

		signalBodyPlayer.x = healthBar.x + 673;
		signalBodyPlayer.y = healthBar.y - 178;
		signalBodyOpponent.x = healthBar.x - 107;
		signalBodyOpponent.y = healthBar.y - 178;
	}
	else
	{
		signalBodyPlayer.scale.set(0.7, 0.7);
		signalBodyOpponent.scale.set(-0.7, 0.7);

		signalBodyPlayer.x = healthBar.x + 673;
		signalBodyPlayer.y = healthBar.y - 128;
		signalBodyOpponent.x = healthBar.x - 107;
		signalBodyOpponent.y = healthBar.y - 128;
	}

	insert(members.indexOf(iconP2) - 1, signalBodyOpponent);
}