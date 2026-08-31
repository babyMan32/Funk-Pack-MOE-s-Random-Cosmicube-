//basically the script from Nene Roomcode but not copied at all and probably completely different

var neneExists = true;

var VULTURE_THRESHOLD = 0.5;
var MIN_BLINK_DELAY = 3;
var MAX_BLINK_DELAY = 7;

var raise_her_knife = false;

var blinkCountdown = 3;

var yo_nenes = ['nene_v-slice', 'nene_v-slice-dark', 'nene_v-slice-pixel', 'nene_d-sides'];

var playedAnim = false;

function onCreatePost()
{
	if (gf == null)
	{
		neneExists = false;
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!neneExists) return;

	if (!yo_nenes.contains(gf.curCharacter)) return;

	if (health <= VULTURE_THRESHOLD && !raise_her_knife)
	{
		neneing(gf.skipDance ? 'RAISE' : 'PRE-RAISE');
	}

	if (health > VULTURE_THRESHOLD && gf.skipDance)
	{
		neneing(raise_her_knife ? 'LOWER' : 'DEFAULT');
	}
}

function neneing(neneState)
{
	if (neneState == 'PRE-RAISE')
	{
		gf.skipDance = true;
	}

	if (neneState == 'RAISE' && gf.isAnimFinished())
	{
		raise_her_knife = true;
		gf.playAnim('raiseKnife', true);
	}

	if (neneState == 'LOWER')
	{
		raise_her_knife = false;
		gf.playAnim('lowerKnife', true);
	}

	if (neneState == 'DEFAULT' && gf.isAnimFinished())
	{
		gf.skipDance = false;
	}
}

function onBeatHit()
{
	if (!neneExists) return;

	if (!raise_her_knife) return;

	if (blinkCountdown == 0)
	{
		gf.playAnim('idleKnife', true);
		blinkCountdown = FlxG.random.int(MIN_BLINK_DELAY, MAX_BLINK_DELAY);
	}

	if (blinkCountdown > 0)
	{
		blinkCountdown--;
	}
}

function goodNoteHit(note)
{
	if (!neneExists) return;

	if (note.isSustainNote) return;

	FlxG.signals.postUpdate.addOnce(function() {
		comboAnim = 'combo' + game.combo;

		if (gf.hasAnim(comboAnim) && !playedAnim)
		{
			gf.playAnim(comboAnim, true);
			gf.specialAnim = true;
			playedAnim = true;
		}
	});
}

function noteMiss(note)
{
	if (!neneExists) return;

	if (game.combo >= 70)
	{
		if (!gf.hasAnim('drop70')) return;

		gf.playAnim('drop70', true);
		gf.specialAnim = true;
	}

	playedAnim = false;
}