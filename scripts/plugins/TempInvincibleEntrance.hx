import funkin.states.MainMenuState;
import funkin.states.FreeplayState;
import funkin.FunkinAssets;

var charsToType = ['G', 'F', 'PERIOD', 'H', 'X'];
var index = 0;

function onUpdate()
{
	var game = FlxG.state;

	if (Std.isOfType(game, MainMenuState))
	{
		if (FlxG.keys.anyJustPressed(charsToType[index]))
		{
			index++;
			FlxG.sound.play(Paths.sound('equip', null, PathsTestMode.LOOSE));
		}

		trace(charsToType[index]);

		if (index == 5) FreeplayState.loadSong('Invincible (Noimix)');
	}
}