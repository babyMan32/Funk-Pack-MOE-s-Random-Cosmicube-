var ext = 'characters/cassandra/';

var noSpeakerStages = ['ejected', 'ejectedErected', 'danger'];
var floatingStages = ['ejected', 'ejectedErected'];

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "ejected", "ejectedErected":
			changeCharacter("cassandra-wind", 2);

			gf.useRenderTexture = true;

			gf.shader = boyfriend.shader;

		case "danger":
			changeCharacter("cassandra-wind", 2);
	}

	if (noSpeakerStages.contains(PlayState.SONG.stage))
	{
		platformFloat();
		return;
	}

	speakerCass = new FlxSprite(0, 0);
	speakerCass.frames = Paths.getSparrowAtlas(ext + 'base-boom', null, null, PathsTestMode.LOOSE);
	speakerCass.animation.addByPrefix('danceLeft', 'boom-idle-left', 24, false);
	speakerCass.animation.addByPrefix('danceRight', 'boom-idle-right', 24, false);
	gfGroup.insert(0, speakerCass);

	speakerCass.x = gf.x - 205;
	speakerCass.y = gf.y + 335;
}

function platformFloat()
{
	platformGF = new FlxSprite(160, 285);
	platformGF.frames = Paths.getSparrowAtlas('stages/common/platform');
	platformGF.animation.addByPrefix('bop', 'floating', 24, true);
	platformGF.animation.play('bop');

	platformGF.shader = gf.shader;
	gfGroup.insert(0, platformGF);

	if (PlayState.SONG.stage == 'danger') return;

	FlxG.signals.postUpdate.addOnce(function() {
		platformGF.scrollFactor.set(0.7, 0.7);
	});
}

function onBeatHit()
{
	if (noSpeakerStages.contains(PlayState.SONG.stage)) return;

	speakerCass.animation.play(gf.getAnimName(), true);
}

function onCountdownTick(tick)
{
	if (noSpeakerStages.contains(PlayState.SONG.stage)) return;

	speakerCass.animation.play(gf.getAnimName(), true);
}

function goodNoteHit(note)
{
	if (note.isSustainNote) return;

	FlxG.signals.postUpdate.addOnce(function() {
		comboAnim = 'combo' + game.combo;

		if (gf.hasAnim(comboAnim))
		{
			gf.playAnim(comboAnim, true);
			gf.specialAnim = true;
		}
	});
}

function onEvent(ev, v1, v2)
{
	if (ev == 'Legacy')
	{
		switch (v1)
		{
			case 'bye gf':
				FlxTween.tween(platformGF, {x: platformGF.x - 3500}, 4, {ease: FlxEase.quartIn, onComplete: function() platformGF.kill()});
		}
	}
}

function onUpdatePost()
{
	if (floatingStages.contains(PlayState.SONG.stage))
		return FlxTween.cancelTweensOf(gf);

	if (noSpeakerStages.contains(PlayState.SONG.stage)) return;

	speakerCass.shader = gf.shader;
	speakerCass.color = gf.color;
	speakerCass.alpha = gf.alpha;
	speakerCass.visible = gf.visible;
}