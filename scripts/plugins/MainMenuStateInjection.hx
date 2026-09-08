import funkin.states.MainMenuState;
import funkin.FunkinAssets;
import flixel.FlxSprite;
import funkin.Paths;

var _these_shits = ['backlit', 'floating', 'ghost', 'isPixel', 'runner', 'seeThrough'];

var flagVisible = false;

var menuFlag;

function onStateSwitchPost()
{
	var game = FlxG.state;

	if (Std.isOfType(game, MainMenuState))
	{
		for (items in 0..._these_shits.length)
		{
			if (FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[items], null, PathsTestMode.LOOSE)) == 'true' && !flagVisible)
			{
				menuFlag = new FlxSprite(0, 0).loadGraphic(Paths.image('flag rofl', null, null, PathsTestMode.LOOSE));
				menuFlag.scale.set(0.05, 0.05);
				menuFlag.updateHitbox();
				game.add(menuFlag);

				trace(FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[items], null, PathsTestMode.LOOSE)));

				flagVisible = true;
			}

			trace(flagVisible);
		}
	}
}

function onUpdate()
{
	var game = FlxG.state;

	if (Std.isOfType(game, MainMenuState))
	{
		if (menuFlag == null) return;

		if (FlxG.mouse.overlaps(menuFlag) && FlxG.mouse.justPressed)
		{
			trace('it was clicked');
		}
	}
}

function onLoad() FlxG.signals.preUpdate.add(onUpdate);

function onDestroy()
{
	if (flagVisible)
	{
		flagVisible = false;
		FlxG.state.remove(menuFlag);
	}

	FlxG.signals.preUpdate.remove(onUpdate);
}