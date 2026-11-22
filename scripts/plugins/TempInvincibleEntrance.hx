import funkin.states.MainMenuState;
import funkin.states.FreeplayState;
import funkin.FunkinAssets;

var charsToType = [FlxG.keys.pressed.G, FlxG.keys.pressed.F, FlxG.keys.pressed.PERIOD, FlxG.keys.pressed.H, FlxG.keys.pressed.X];
var index = 0;

function onUpdate()
{
	var game = FlxG.state;

	if (Std.isOfType(game, MainMenuState))
	{
		if (charsToType[index])
		{
			index++;
			FlxG.sound.play(Paths.sound('equip', null, PathsTestMode.LOOSE));
		}

		trace(charsToType[index]);

		if (index == 5) FreeplayState.loadSong('Invincible (Noimix)');
	}
}