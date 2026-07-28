import funkin.FunkinAssets;
import funkin.states.FreeplayState;

function onUpdate()
{
	var game = FlxG.state;

	var select_song = Controls.instance.ACCEPT;
  
	if (Std.isOfType(game, FreeplayState))
	{
		if (game.ws_lock[FreeplayState.curSelect]) return;

		var song = game.week_songs[FreeplayState.curSelect];

		var songVars = Paths.json("variations/" + Paths.sanitize(song[0]), null, PathsTestMode.LOOSE);

		if (select_song)
		{
			if (FunkinAssets.exists(songVars))
			{
				if (game.lockMovement) return;

				game.lockMovement = true;
				Paths.overrideMode = PathsTestMode.LOOSE; // i was going insane trying to load substates not from legacy, thank you ashley
				game.openSubState(new ScriptedSubstate('VariationSubState'));
				return;
			}
		}
	}
}

// plugin scirpts dont have onUpdate rn so  this will do i guess??
function onLoad() FlxG.signals.preUpdate.add(onUpdate);
function onDestroy() FlxG.signals.preUpdate.remove(onUpdate);