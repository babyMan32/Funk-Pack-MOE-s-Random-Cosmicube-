var noSpeakerStages = ['ejected', 'ejectedErected', 'danger'];

function onCreatePost() {
	speaker = new FunkinSprite(0, 0).loadAtlas('characters/vs_cord/ROSE_SPEAKER', null, PathsTestMode.LOOSE);
	speaker.addAnimByPrefix('bop', 'speaker :3', 24, false);
	gfGroup.insert(0, speaker);
	speaker.x = gf.x;
	speaker.y = gf.y + 475;
	speaker.shader = gf.shader;

		if (noSpeakerStages.contains(PlayState.SONG.stage))
	{
		platformFloat();
		return;
	}
}

function onBeatHit() {
	speaker.playAnim('bop', true, false, 0);
}

function onUpdatePost()
{
	if (noSpeakerStages.contains(PlayState.SONG.stage))
	return FlxTween.cancelTweensOf(gf);
	
	speaker.shader = gf.shader;
	speaker.color = gf.color;
	speaker.alpha = gf.alpha;
	speaker.visible = gf.visible;
	speaker.angle = gf.angle;
}

function platformFloat()
{
	platformGF = new FlxSprite(75, 315);
	platformGF.frames = Paths.getSparrowAtlas('stages/common/platform');
	platformGF.animation.addByPrefix('bop', 'floating', 24, true);
	platformGF.animation.play('bop');

	platformGF.shader = gf.shader;
	gfGroup.insert(0, platformGF);
	refreshZ(stage);

	if (PlayState.SONG.stage == 'danger') return;

	FlxG.signals.postUpdate.addOnce(function() {
		platformGF.scrollFactor.set(0.7, 0.7);
	});
}

function noteMiss(note)
{
	if (songMisses >= 10)
	{
		triggerEventNote('Alt Idle Animation', 'gf', '-alt');
	}
}