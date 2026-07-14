function onPause() {
    return; // doesnt work without global
    openCustomPause();

    return Function_Stop;
}

function openCustomPause() {
    FlxG.camera.followLerp = 0;
	game.persistentUpdate = false;
	game.persistentDraw = true;
	game.paused = true;
    game.audio?.pause();
    openSubState(new ScriptedSubstate('CustomPauseSubState'));
}