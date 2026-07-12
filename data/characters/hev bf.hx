var allow_taunt = false;
var allow_transition = false;

var coolAnims = false;
var beatboxAnims = false;

var animSuffixVariable:Array = ["", "-alt", "-beatbox"];
var idleSuffixVariable:Array = ["", "-alt", ""];
var animSuffixInt:Int = 0;

function onCreatePost()
{
	boyfriend.idleSuffix = '-prep';
	boyfriend.playAnim('idle-prep');
}

function onUpdate(elapsed:Float):Void
{
	onTaunt();

	onAnimSwitch();

	if (boyfriend.getAnimName() != 'swaws-transition' && boyfriend.getAnimName() != 'un-swawsing' && boyfriend.getAnimName() != 'heynormal' && !game.startingSong)
	{
		allow_transition = true;
	}
}

function onTaunt()
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'hev bf' && allow_taunt && allow_transition && boyfriend.canTaunt)
	{
		boyfriend.playAnim(coolAnims ? 'heycool' : (beatboxAnims ? 'boo' : (FlxG.random.bool(50) ? 'haha' : 'heynormal')));

		boyfriend.specialAnim = boyfriend.holding = true;

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'heycool' && boyfriend.getAnimName() != 'boo' && boyfriend.getAnimName() != 'haha' && boyfriend.getAnimName() != 'heynormal' && !game.startingSong)
	{
		allow_taunt = true;
	}
}

function onAnimSwitch()
{
	if (FlxG.keys.justPressed.CONTROL && boyfriend.curCharacter == 'hev bf' && allow_taunt && allow_transition && boyfriend.canTaunt)
	{
		animSuffixInt = (animSuffixInt + 1) % 3;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
		boyfriend.idleSuffix = idleSuffixVariable[animSuffixInt];

		coolAnims = (boyfriend.animSuffix == '-alt' ? true : false);
		beatboxAnims = (boyfriend.animSuffix == '-beatbox' ? true : false);

		boyfriend.playAnim(coolAnims ? 'swaws-transition' : (beatboxAnims ? 'un-swawsing' : 'heynormal'));
		boyfriend.specialAnim = true;

		allow_transition = false;
	}
}

function onCountdownTick(tick)
{
	switch (tick)
	{
		case 0:
			boyfriend.playAnim('3');
			boyfriend.specialAnim = true;

		case 1:
			boyfriend.playAnim('2');
			boyfriend.specialAnim = true;

		case 2:
			boyfriend.playAnim('1');
			boyfriend.specialAnim = true;

		case 3:
			boyfriend.playAnim('heynormal');
			boyfriend.specialAnim = true;
			boyfriend.idleSuffix = '';
	}
}

function onBeatHit()
{
	if (curBeat == 432 && PlayState.SONG.song == 'Defeat')
	{
		forceAnimSet('cool');
	}
}

function forceAnimSet(animSet:String)
{
	if (animSet == 'basic' && (coolAnims || beatboxAnims))
	{
		animSuffixInt = 0;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
		boyfriend.idleSuffix = idleSuffixVariable[animSuffixInt];

		boyfriend.playAnim(coolAnims ? 'un-swawsing' : 'heynormal');
		boyfriend.specialAnim = true;

		coolAnims = false;
		beatboxAnims = false;

		allow_transition = false;
	}

	if (animSet == 'cool' && !coolAnims)
	{
		animSuffixInt = 1;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
		boyfriend.idleSuffix = idleSuffixVariable[animSuffixInt];

		coolAnims = true;
		beatboxAnims = false;

		boyfriend.playAnim('swaws-transition');
		boyfriend.specialAnim = true;

		allow_transition = false;
	}

	if (animSet == 'beatbox' && !beatboxAnims)
	{
		animSuffixInt = 2;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
		boyfriend.idleSuffix = idleSuffixVariable[animSuffixInt];

		boyfriend.playAnim(coolAnims ? 'un-swawsing' : 'haha');
		boyfriend.specialAnim = true;

		coolAnims = false;
		beatboxAnims = true;

		allow_transition = false;
	}
}