var allow_taunt = true;
var allow_transition = true;

var coolAnims = false;
var beatboxAnims = false;

var animSuffixVariable:Array = ["", "-alt", "-beatbox"];
var idleSuffixVariable:Array = ["", "-alt", "-extralt"];
var animSuffixInt:Int = 0;

function onLoad()
{
	boyfriend.useRenderTexture = true;
}

function onUpdate(elapsed:Float):Void
{
	onTaunt();

	onAnimSwitch();

	if (boyfriend.getAnimName() != 'uh oh' && boyfriend.getAnimName() != 'miau' && boyfriend.getAnimName() != 'funny')
	{
		allow_transition = true;
	}
}

function onTaunt()
{
	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'cord' && allow_taunt && allow_transition && boyfriend.canTaunt)
	{
		boyfriend.playAnim('yea');

		boyfriend.specialAnim = boyfriend.holding = true;

		allow_taunt = false;
	}

	if (boyfriend.getAnimName() != 'yea')
	{
		allow_taunt = true;
	}
}

function onAnimSwitch()
{
	if (FlxG.keys.justPressed.CONTROL && boyfriend.curCharacter == 'cord' && allow_taunt && allow_transition && boyfriend.canTaunt)
	{
		animSuffixInt = (animSuffixInt + 1) % 3;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
		triggerEventNote('Alt Idle Animation', 'boyfriend', idleSuffixVariable[animSuffixInt]);

		coolAnims = (boyfriend.animSuffix == '-alt' ? true : false);
		beatboxAnims = (boyfriend.animSuffix == '-beatbox' ? true : false);

		boyfriend.playAnim(coolAnims ? 'uh oh' : (beatboxAnims ? 'miau' : 'funny'));
		boyfriend.specialAnim = true;

		boyfriend.danceEveryNumBeats = (beatboxAnims ? 1 : 2);

		allow_transition = false;

		boyfriend.gameoverCharacter = coolAnims ? 'cord-fallen' : 'genericDeath';
		boyfriend.gameoverInitialDeathSound = coolAnims ? 'cordFall' : 'fnf_loss_sfx';
	}
}