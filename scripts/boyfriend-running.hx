using StringTools;

public var bfOldLegs:Character;
var bfAnchorPoint:Array<Float> = [0, 0];
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];

function onLoad()
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	bfOldLegs = new Character(0, 0, 'boyfriend-legs', true);
	boyfriendGroup.insert(0, bfOldLegs);
}

function onCreatePost()
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	bfOldLegs.x = game.boyfriend.x + 30;
	bfOldLegs.y = game.boyfriend.y + 275;
	bfAnchorPoint[0] = game.boyfriend.x;
	bfAnchorPoint[1] = game.boyfriend.y;
}

function onUpdate(elapsed)
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	game.boyfriend.y = bfAnchorPoint[1] + legPosY[bfOldLegs.animation.curAnim.curFrame];

	// This changes the legs from the miss version to the normal one and makes sure it starts on the same animation frame where it left off
	if (!boyfriend.getAnimName().contains('miss') && bfOldLegs.getAnimName().contains('miss'))
	{
		var lastFrame:Int = 0;
		lastFrame = bfOldLegs.animation.curAnim.curFrame;
		bfOldLegs.idleSuffix = '';
		bfOldLegs.recalculateDanceIdle();
		bfOldLegs.animation.curAnim.curFrame = lastFrame;
	}

	if (boyfriend.getAnimName().contains('dance'))
	{
		bfOldLegs.visible = false;
	}
}

function goodNoteHit()
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	bfOldLegs.visible = true;
}

function onKeyRelease()
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	game.boyfriend.danced = bfOldLegs.danced;
}

function onCountdownTick()
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	bfOldLegs.dance();
}

function onBeatHit()
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	if (curBeat % 1 == 0)
	{
		bfOldLegs.dance();
	}
}

// This changes the legs from the normal version to the miss version and makes sure it starts on the same animation frame where it left off
function noteMiss(daNote)
{
	if (ClientPrefs.bfSkin != 'boyfriend' && PlayState.SONG.stage != 'danger') return;

	var lastFrame:Int = 0;
	
	lastFrame = bfOldLegs.animation.curAnim.curFrame;
	bfOldLegs.idleSuffix = '-miss';
	bfOldLegs.recalculateDanceIdle();
	bfOldLegs.animation.curAnim.curFrame = lastFrame;
}
