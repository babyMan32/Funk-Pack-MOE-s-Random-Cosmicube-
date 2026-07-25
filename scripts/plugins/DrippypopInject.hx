import funkin.states.FreeplayState;

function onUpdate()
{
	var game = FlxG.state;

	var select_song = Controls.instance.ACCEPT;

	var overlappingCard = (FlxG.mouse.y >= 319) && (FlxG.mouse.y <= 424);
  
	if (Std.isOfType(game, FreeplayState))
	{
		var select_song_mouse = FlxG.mouse.justPressed && FlxG.mouse.overlaps(game.cards) && overlappingCard;

		if (game.ws_lock[FreeplayState.curSelect]) return;

		if (select_song || select_song_mouse)
		{
			var song = game.week_songs[FreeplayState.curSelect];
      
			if (song[0] == 'Drippypop' && !game.lockMovement)
			{
				game.lockMovement = true;
				Paths.overrideMode = PathsTestMode.LOOSE; // i was going insane trying to load substates not from legacy, thank you ashley
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