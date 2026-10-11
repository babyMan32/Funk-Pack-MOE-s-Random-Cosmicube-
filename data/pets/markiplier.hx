import funkin.objects.Bopper;

var mark:Bopper;

var endSFX:String;
var biteSFX:String;

function onLoad()
{
	parent.visible = false;
	parent.active = false;

	mark = new Bopper();
	mark.frames = Paths.getSparrowAtlas('pets/markiplier', null, null, PathsTestMode.LOOSE);
	mark.camera = PlayState.instance.camOther;

	mark.animation.addByPrefix('idle', 'idle', 24, false);
	mark.animation.addByPrefix('songend', 'songend', 24);

	mark.dance();

	add(mark);
}

function onCreatePost()
{
	// The bullshit that has to be done...
	endSFX = Paths.sound('markiplier_songend');
	biteSFX = Paths.sound('markiplier_bite');
}

function onEndSong()
{
	mark.playAnim('songend');

	FunkinSound.play(endSFX);
}

function onGameOverPost()
{
	var mark:FunkinSprite = new FunkinSprite();
	mark.frames = Paths.getSparrowAtlas('pets/markiplier_bite', null, null, PathsTestMode.LOOSE);
	mark.camera = GameOverSubstate.instance.camCTRL;

	mark.animation.addByPrefix('anim', 'anim', 24, false);
	mark.animation.play('anim');

	GameOverSubstate.instance.add(mark);

	FunkinSound.play(biteSFX);
}