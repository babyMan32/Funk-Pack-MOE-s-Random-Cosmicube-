import funkin.states.MainMenuState;
import funkin.FunkinAssets;
import flixel.FlxSprite;
import funkin.Paths;

var _these_shits = ['backlit', 'floating', 'ghost', 'isPixel', 'runner', 'seeThrough'];

var flagVisible = false;

var menuFlag;

function onUpdate()
{
	var game = FlxG.state;

	if (Std.isOfType(game, MainMenuState))
	{
		for (items in 0..._these_shits.length)
		{
			Paths.overrideMode = PathsTestMode.LOOSE;

			if (FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[items])) == 'true' && !flagVisible)
			{
				menuFlag = new FlxSprite(0, 0).loadGraphic(Paths.image('flag rofl'));
				// menuFlag.scale.set(0.05, 0.05);
				menuFlag.updateHitbox();
				// add(menuFlag);

				trace(FunkinAssets.getContent(Paths.txt('_flags_collected/' + _these_shits[items])));

				flagVisible = true;
			}
			trace(flagVisible);
		}
	}

	Paths.overrideMode = null;
}

function onLoad() FlxG.signals.preUpdate.add(onUpdate);
function onDestroy() FlxG.signals.preUpdate.remove(onUpdate);