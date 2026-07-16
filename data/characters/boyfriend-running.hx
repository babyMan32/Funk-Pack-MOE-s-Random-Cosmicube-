using StringTools;

var doWeLegs:Bool = false;
public var bfOldLegs:Character;
var bfAnchorPoint:Array<Float> = [0, 0];
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];

function onLoad()
{
	doWeLegs = (ClientPrefs.bfSkin == 'boyfriend' && PlayState.SONG.stage == 'danger');
	if (!doWeLegs) return;

	bfOldLegs = new Character(0, 0, 'boyfriend-legs', true);
	boyfriendGroup.insert(0, bfOldLegs);
}

function onCreatePost()
{
	if (!doWeLegs) return;

	bfOldLegs.x = game.boyfriend.x + 30;
	bfOldLegs.y = game.boyfriend.y + 275;
	bfAnchorPoint[0] = game.boyfriend.x;
	bfAnchorPoint[1] = game.boyfriend.y;
}

function onUpdate(elapsed)
{
	if (!doWeLegs) return;

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

	if (boyfriend.getAnimName().contains('idle'))
	{
		bfOldLegs.visible = false;
	}
}

function goodNoteHit()
{
	if (!doWeLegs) return;

	bfOldLegs.visible = true;
}

function onKeyRelease()
{
	if (!doWeLegs) return;

	boyfriend.danced = bfOldLegs.danced;
}

function onCountdownTick()
{
	if (!doWeLegs) return;

	bfOldLegs.dance();
}

function onBeatHit()
{
	if (!doWeLegs) return;

	if (curBeat % 1 == 0)
	{
		bfOldLegs.dance();
	}
}

// This changes the legs from the normal version to the miss version and makes sure it starts on the same animation frame where it left off
function noteMiss(daNote)
{
	if (!doWeLegs) return;

	var lastFrame:Int = 0;
	
	lastFrame = bfOldLegs.animation.curAnim.curFrame;
	bfOldLegs.idleSuffix = '-miss';
	bfOldLegs.recalculateDanceIdle();
	bfOldLegs.animation.curAnim.curFrame = lastFrame;
}
