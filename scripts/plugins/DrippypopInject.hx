import funkin.states.FreeplayState;

function onUpdate()
{
	var game = FlxG.state;

	var select_song = Controls.instance.ACCEPT;
  
	if (Std.isOfType(game, FreeplayState))
	{
		if (select_song && !game.ws_lock[FreeplayState.curSelect])
		{
			var song = game.week_songs[FreeplayState.curSelect];
      
			if (song[0] == 'Drippypop' && !game.lockMovement)
			{
				game.lockMovement = true;
				Paths.overrideMode = PathsTestMode.LOOSE;
				game.openSubState(new ScriptedSubstate('DrippyGlungSubState'));
				Paths.overrideMode = null;
				return;
			}
		}
	}
}

// plugin scirpts dont have onUpdate rn so  this will do i guess??
function onLoad() FlxG.signals.preUpdate.add(onUpdate);
function onDestroy() FlxG.signals.preUpdate.remove(onUpdate);