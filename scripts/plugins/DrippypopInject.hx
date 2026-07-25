import funkin.states.FreeplayState;

function onUpdate()
{
	var game = FlxG.state;

	var select_song = Controls.instance.ACCEPT;
  
	if (Std.isOfType(game, FreeplayState))
	{
		var song = game.week_songs[FreeplayState.curSelect];

		if (select_song)
		{
			if (song[0] != 'Drippypop') return;

			if (game.lockMovement) return;

			game.lockMovement = true;
			Paths.overrideMode = PathsTestMode.LOOSE; // i was going insane trying to load substates not from legacy, thank you ashley
			game.openSubState(new ScriptedSubstate('DrippyGlungSubState'));
			Paths.overrideMode = null;
			return;
		}
	}
}

// plugin scirpts dont have onUpdate rn so  this will do i guess??
function onLoad() FlxG.signals.preUpdate.add(onUpdate);
function onDestroy() FlxG.signals.preUpdate.remove(onUpdate);