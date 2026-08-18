using StringTools;

var allow_taunt = true;

var animSuffixVariable:Array = ["", "-alt", "-angry", "-angryAlt", "-beatbox", "-blush", "-fresh", "-xmas"];
var animSuffixInt:Int = 0;

function onUpdate(elapsed:Float):Void
{
	animSwap();

	animSwapManual();

	if (boyfriend.animSuffix.contains('angry'))
	{
		boyfriend.idleSuffix = '-angry';
	}
	else
	{
		boyfriend.idleSuffix = '';
	}

	if (inCutscene || cpuControlled) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'animania-bf' && allow_taunt && boyfriend.canTaunt)
	{
		heyAnim = 'yo' + boyfriend.animSuffix;

		if (boyfriend.hasAnim(heyAnim))
		{
			boyfriend.playAnim('yo' + boyfriend.animSuffix);
		}
		else
		{
			boyfriend.playAnim('yo');
		}

		boyfriend.specialAnim = boyfriend.holding = true;

		allow_taunt = false;
	}

	if (!boyfriend.getAnimName().contains('yo'))
	{
		allow_taunt = true;
	}
}

function animSwap()
{
	if (FlxG.keys.justPressed.CONTROL && boyfriend.curCharacter == 'animania-bf')
	{
		animSuffixInt = (animSuffixInt + 1) % 8;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
	}
}

function animSwapManual()
{
	if (FlxG.keys.pressed.ALT)
	{
		if (boyfriend.curCharacter != 'animania-bf') return if (ClientPrefs.inDevMode) trace('WHO THE HELL IS THIS');

		if (FlxG.keys.justPressed.Z)
		{
			animSuffixInt = 0;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('BASE ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.X)
		{
			animSuffixInt = 1;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('ALT ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.C)
		{
			animSuffixInt = 2;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('ANGRY ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.V)
		{
			animSuffixInt = 3;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('ANGRY ALT ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.B)
		{
			animSuffixInt = 4;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('BEATBOX ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.N)
		{
			animSuffixInt = 5;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('BLUSH ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.M)
		{
			animSuffixInt = 6;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('FRESH ANIMS ENABLES');
		}

		if (FlxG.keys.justPressed.COMMA)
		{
			animSuffixInt = 7;

			boyfriend.animSuffix = animSuffixVariable[animSuffixInt];

			if (ClientPrefs.inDevMode) trace('XMAS ANIMS ENABLES');
		}
	}
}