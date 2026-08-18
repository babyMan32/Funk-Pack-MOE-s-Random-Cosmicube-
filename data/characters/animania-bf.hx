using StringTools;

var allow_taunt = true;

var songForcesAnims = false;

var animSuffixVariable:Array = ["", "-alt", "-angry", "-angryAlt", "-beatbox", "-blush", "-fresh", "-xmas"];
var animSuffixInt:Int = 0;

function onCreatePost()
{
	if (PlayState.SONG.song == 'Double Kill (SUSKILL)')
	{
		songForcesAnims = true;

		boyfriend.animSuffix = '-angry';

		FlxG.signals.postUpdate.addOnce(function() {
			yellowShield.x += 70;
		});
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 == 'Switch State')
			{
				if (boyfriend.curCharacter == 'animania-bf')
				{
					switch (value2)
					{
						case 'base':
							boyfriend.animSuffix = '';

						case 'erm':
							boyfriend.animSuffix = '-fresh';

						case 'annoyed', 'nervous':
							boyfriend.animSuffix = '-angry';

						case 'magicrainbow', 'scared':
							boyfriend.animSuffix = '-angryAlt';
					}
				}
			}
	}
}

function onUpdate(elapsed:Float):Void
{
	if (!songForcesAnims)
	{
		animSwap();

		animSwapManual();
	}

	if (boyfriend.animSuffix.contains('angry') && !boyfriend.idleSuffix.contains('angry'))
	{
		var lastFrame:Int = 0;

		boyfriend.idleSuffix = '-angry';
		boyfriend.recalculateDanceIdle();

		if (!boyfriend.getAnimName().contains('sing'))
		{
			lastFrame = boyfriend.animation.curAnim.curFrame;
			boyfriend.playAnim('idle-angry', true);
			boyfriend.animation.curAnim.curFrame = lastFrame;
		}
		else if (boyfriend.getAnimName().contains('sing'))
		{
			lastFrame = boyfriend.animation.curAnim.curFrame;
			boyfriend.playAnim(boyfriend.getAnimName() + '-angry', true);
			boyfriend.animation.curAnim.curFrame = lastFrame;
		}
	}
	else if (!boyfriend.animSuffix.contains('angry') && boyfriend.idleSuffix.contains('angry'))
	{
		var lastFrame:Int = 0;

		boyfriend.idleSuffix = '';
		boyfriend.recalculateDanceIdle();

		if (!boyfriend.getAnimName().contains('sing'))
		{
			lastFrame = boyfriend.animation.curAnim.curFrame;
			boyfriend.playAnim('idle', true);
			boyfriend.animation.curAnim.curFrame = lastFrame;
		}
		else if (boyfriend.getAnimName().contains('sing'))
		{
			splitAnimName = boyfriend.getAnimName().split("-");

			lastFrame = boyfriend.animation.curAnim.curFrame;
			boyfriend.playAnim(splitAnimName[0], true);
			boyfriend.animation.curAnim.curFrame = lastFrame;
		}
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