import funkin.states.FreeplayState;

var game;

var song;

var select_song_mouse;

function onUpdate()
{
	game = FlxG.state;

	var select_song = Controls.instance.ACCEPT;
  
	if (Std.isOfType(game, FreeplayState))
	{
		if (game.ws_lock[FreeplayState.curSelect]) return;

		song = game.week_songs[FreeplayState.curSelect];

		if (select_song || select_song_mouse)
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

function onUpdatePost()
{
	if (Std.isOfType(game, FreeplayState))
	{
		select_song_mouse = FlxG.mouse.y >= (game.upperBar.y + game.upperBar.height) && FlxG.mouse.justPressed && FlxG.mouse.overlaps(game.cards);
	}
}

// plugin scirpts dont have onUpdate rn so  this will do i guess??
function onLoad()
{
	FlxG.signals.preUpdate.add(onUpdate);
	FlxG.signals.postUpdate.add(onUpdatePost);
}

function onDestroy()
{
	FlxG.signals.preUpdate.remove(onUpdate);
	FlxG.signals.postUpdate.remove(onUpdatePost);
}