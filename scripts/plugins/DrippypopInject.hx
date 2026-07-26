import funkin.states.FreeplayState;

var lastSong;

function onUpdate()
{
	var game = FlxG.state;

	var select_song = Controls.instance.ACCEPT;
  
	if (Std.isOfType(game, FreeplayState))
	{
		if (game.ws_lock[FreeplayState.curSelect]) return;

		var song = game.week_songs[FreeplayState.curSelect];

		var select_song_mouse = FlxG.mouse.y >= (game.upperBar.y + game.upperBar.height) && FlxG.mouse.justPressed && FlxG.mouse.overlaps(game.cards) && (song[0] == lastSong);

		if (select_song || select_song_mouse)
		{
			if (song[0] != 'Drippypop') return;
		
			if (game.lockMovement) return;

			game.lockMovement = true;
			Paths.overrideMode = PathsTestMode.LOOSE; // i was going insane trying to load substates not from legacy, thank you ashley
			game.openSubState(new ScriptedSubstate('DrippyGlungSubState'));
			Paths.overrideMode = null;
		}

		lastSong = song[0];
	}
}

// plugin scirpts dont have onUpdate rn so  this will do i guess??
function onLoad() FlxG.signals.preUpdate.add(onUpdate);
function onDestroy() FlxG.signals.preUpdate.remove(onUpdate);