var allow_taunt = false;
var allow_transition = false;
var coolAnims = false;

var animSuffixVariable:Array = ["", "-beatbox"];
var idleSuffixVariable:Array = ["", "-alt"];
var animSuffixInt:Int = 0;

function onCreatePost()
{
	boyfriend.idleSuffix = '-prep';
	boyfriend.playAnim('idle-prep');
}

function onUpdate(elapsed:Float):Void
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'hev bf' && allow_taunt && allow_transition)
	{
		boyfriend.playAnim(coolAnims ? 'heycool' : 'heynormal');

		boyfriend.specialAnim = boyfriend.holding = true;

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'heynormal' && boyfriend.getAnimName() != 'heycool' && !game.startingSong)
	{
		allow_taunt = true;
	}

	if (FlxG.keys.justPressed.CONTROL && boyfriend.curCharacter == 'hev bf' && allow_transition)
	{
		animSuffixInt = (animSuffixInt + 1) % 2;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
		boyfriend.idleSuffix = idleSuffixVariable[animSuffixInt];

		coolAnims = (boyfriend.animSuffix == '' ? false : true);

		boyfriend.playAnim(coolAnims ? 'swaws-transition' : 'heynormal');
		boyfriend.specialAnim = boyfriend.holding = true;

		allow_transition = false;
	}

	if (boyfriend.getAnimName() != 'heynormal' && boyfriend.getAnimName() != 'swaws-transition' && !game.startingSong)
	{
		allow_transition = true;
	}
}

function onCountdownTick(tick)
{
	switch (tick)
	{
		case 0:
			boyfriend.playAnim('3');
			boyfriend.specialAnim = boyfriend.holding = true;

		case 1:
			boyfriend.playAnim('2');
			boyfriend.specialAnim = boyfriend.holding = true;

		case 2:
			boyfriend.playAnim('1');
			boyfriend.specialAnim = boyfriend.holding = true;

		case 3:
			boyfriend.playAnim('heynormal');
			boyfriend.specialAnim = boyfriend.holding = true;
			boyfriend.idleSuffix = '';
	}
}