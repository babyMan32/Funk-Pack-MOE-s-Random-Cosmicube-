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

	wIcons = new FlxSprite(0, 0);
	wIcons.frames = Paths.getSparrowAtlas('icons/icon-bf-amtake', null, null, PathsTestMode.LOOSE);
	wIcons.animation.addByPrefix('state0', 'basic0', 24, false);
	wIcons.animation.addByPrefix('state1', 'basic-to-lose', 24, false);
	wIcons.animation.addByPrefix('state2', 'lose0', 24, false);
	wIcons.animation.addByPrefix('state3', 'lose-to-basic', 24, false);
	wIcons.animation.addByPrefix('state4', 'basic-to-win', 24, false);
	wIcons.animation.addByPrefix('state5', 'win0', 24, false);
	wIcons.animation.addByPrefix('state6', 'win-to-basic', 24, false);
	wIcons.animation.addByPrefix('state7', 'lose-to-predeath', 24, false);
	wIcons.animation.addByPrefix('state8', 'predeath0', 24, false);
	wIcons.animation.addByPrefix('state9', 'predeath-to-lose', 24, false);
	wIcons.scale.set(0.8, 0.8);
	wIcons.animation.play('state0');
	wIcons.updateHitbox();
	playHUD.insert(11, wIcons);

	wIcons.animation.onFinish.add((animName) -> {
		switch (animName)
		{
			case 'state1':
				wIcons.animation.play('state2');

			case 'state3':
				wIcons.animation.play('state0');

			case 'state4':
				wIcons.animation.play('state5');

			case 'state6':
				wIcons.animation.play('state0');

			case 'state7':
				wIcons.animation.play('state8');

			case 'state9':
				wIcons.animation.play('state2');
		}
	});
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 == 'Switch State')
			{
				if (boyfriend.curCharacter.contains('animania-bf'))
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

	if (boyfriend.curCharacter.contains('animania-bf'))
	{
		wIcons.visible = iconP1.visible;
		wIcons.alpha = iconP1.alpha;

		FlxG.signals.postUpdate.addOnce(function() {
			iconP1.x = 999999;
		});
	}
	else
	{
		wIcons.visible = false;
	}

	wIcons.x = playHUD.healthBar.barCenter - (150 / 2) + 26 * 2;
	wIcons.y = iconP1.y;
	wIcons.scale.x = iconP1.scale.x * 0.8;
	wIcons.scale.y = iconP1.scale.y * 0.8;
	iconCheck();

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

	if (inCutscene || cpuControlled || songForcesAnims) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter.contains('animania-bf') && allow_taunt && boyfriend.canTaunt)
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

function goodNoteHitPre(note)
{
	if (note.noteData == 2 && boyfriend.curCharacter.contains('animania-bf'))
	{
		if (note.isSustainNote) return;

		if (boyfriend.animSuffix == '-fresh')
		{
			if (!FlxG.random.bool(10)) return;

			note.animSuffix = '-erect';
		}
	}
}

function iconCheck() // absolutely horrid code, please someone fix this
{
	if (health >= 1.6 && wIcons.animation.curAnim.name == 'state0')
	{
		wIcons.animation.play('state4', true);
	}
	else if (health < 1.6 && (wIcons.animation.curAnim.name == 'state4' || wIcons.animation.curAnim.name == 'state5'))
	{
		wIcons.animation.play('state6', true);
	}
	else if (health <= 0.4 && wIcons.animation.curAnim.name == 'state0')
	{
		wIcons.animation.play('state1', true);
	}
	else if (health <= 0.2 && (wIcons.animation.curAnim.name == 'state1' || wIcons.animation.curAnim.name == 'state2'))
	{
		wIcons.animation.play('state7', true);
	}
	else if (health > 0.2 && (wIcons.animation.curAnim.name == 'state7' || wIcons.animation.curAnim.name == 'state8'))
	{
		wIcons.animation.play('state9', true);
	}
	else if (health > 0.4 && (wIcons.animation.curAnim.name == 'state9' || wIcons.animation.curAnim.name == 'state2'))
	{
		wIcons.animation.play('state3', true);
	}
}

function animSwap()
{
	if (FlxG.keys.justPressed.CONTROL && boyfriend.curCharacter.contains('animania-bf'))
	{
		animSuffixInt = (animSuffixInt + 1) % 8;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
	}
}

function animSwapManual()
{
	if (FlxG.keys.pressed.ALT)
	{
		if (!boyfriend.curCharacter.contains('animania-bf')) return if (ClientPrefs.inDevMode) trace('WHO THE HELL IS THIS');

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

function onStepHit()
{
	if (curStep == 1182 && curSong == 'Magmatic')
	{
		boyfriend.playAnim('brt', true);
		boyfriend.specialAnim = boyfriend.skipDance = true;
	}
}

function onSpawnNote(note)
{
	if ((note.noteType == 'Hey!' || curStep >= 1170) && curSong == 'Magmatic')
	{
		note.noAnimation = note.noMissAnimation = true;
	}
}

function noteMiss(note)
{
	if ((note.noteType == 'Hey!' || curStep >= 1181) && curSong == 'Magmatic')
	{
		FlxG.signals.postUpdate.addOnce(function() {
			audio.playerVocals.volume = 1;
		});
	}
}