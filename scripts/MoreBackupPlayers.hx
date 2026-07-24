using StringTools;

var extraExtraPlayer;

public var bf3:Null<String>;

public var extraExtraIdleSuffix = '';
public var extraExtraAnimSuffix = '';
public var tauntAnim2 = 'hey';

var direction = 'Left';

var bf3StageRim;

function onCreatePost()
{
	if (!hasBfSkin || boyfriend.curCharacter != ClientPrefs.bfSkin) return;

	extraExtraPlayer = ClientPrefs.equipment.get('extraExtraPlayerSkin');

	if (extraExtraPlayer == null) return;

	bf3 = new Character(0, 0, extraExtraPlayer, true);
	boyfriendGroup.insert(3, bf3);
	bf3.x += bf3.getFlag('offsetX') ?? -250;
	bf3.y += bf3.getFlag('offsetY') ?? 225;

	bf3Icon = new HealthIcon(bf3.healthIcon, true);

	if (bf2 != null)
	{
		playHUD.insert(5, bf3Icon);
	}
	else
	{
		playHUD.insert(4, bf3Icon);
	}

	bf3StageRim = shadersExtraCheck();

	if (bf3StageRim == null)
	{
		bf3.shader = boyfriend.shader;
		return;
	}

	bf3Rim = bf3StageRim;
	bf3Rim.attachedSprite = bf3;
	bf3.useRenderTexture = true;
}

function onBeatHit()
{
	if (bf3 == null) return;

	if (curBeat % bf3.danceEveryNumBeats == 0)
	{
		if (bf3.getAnimName().contains('idle'))
		{
			bf3.playAnim('idle' + extraExtraIdleSuffix);
		}

		if (bf3.getAnimName().contains('dance'))
		{
			bf3.playAnim('dance$direction' + extraExtraIdleSuffix);
			direction = (bf3.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function onCountdownTick(tick)
{
	if (bf3 == null) return;

	if (tick % bf3.danceEveryNumBeats == 0)
	{
		if (bf3.getAnimName().contains('idle'))
		{
			bf3.playAnim('idle' + extraExtraIdleSuffix);
		}

		if (bf3.getAnimName().contains('dance'))
		{
			bf3.playAnim('dance$direction' + extraExtraIdleSuffix);
			direction = (bf3.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function goodNoteHit(note)
{
	if (bf3 == null) return;

	bf3.holdTimer = 0;

	if (note.isSustainNote && bf3.vSliceSustains) return;

	bf3.playAnim(note.skin.data.singAnimations[note.noteData] + extraExtraAnimSuffix, true);
}

function noteMiss(note)
{
	if (bf3 == null) return;

	bf3.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraExtraAnimSuffix, true);
	bf3.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (bf3 == null) return;

	bf3Icon.x = iconP1.x - 75;
	bf3Icon.y = iconP1.y + 25;
	bf3Icon.scale.set(iconP1.scale.x, iconP1.scale.y);
	bf3Icon.shader = iconP1.shader;
	bf3Icon.updateIconAnim(healthBar.percent * 0.01);
	bf3Icon.alpha = iconP1.alpha;
	bf3Icon.visible = iconP1.visible;

	curAnim = bf3.getAnimName();

	curAnimFinished = bf3.isAnimFinished();

	if (curAnimFinished)
	{
		switch (curAnim)
		{
			case "idle", "idle-loop":
				if (bf3.hasAnim("idle-loop"))
				{
					bf3.playAnim('idle-loop');
				}

			case "singLEFT", "singLEFT-loop":
				if (bf3.hasAnim("singLEFT-loop"))
				{
					bf3.playAnim('singLEFT-loop');
				}

			case "singDOWN", "singDOWN-loop":
				if (bf3.hasAnim("singDOWN-loop"))
				{
					bf3.playAnim('singDOWN-loop');
				}

			case "singUP", "singUP-loop":
				if (bf3.hasAnim("singUP-loop"))
				{
					bf3.playAnim('singUP-loop');
				}

			case "singRIGHT", "singRIGHT-loop":
				if (bf3.hasAnim("singRIGHT-loop"))
				{
					bf3.playAnim('singRIGHT-loop');
				}
		}
	}

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf3.hasAnim(tauntAnim))
	{
		bf3.playAnim(tauntAnim);
		bf3.specialAnim = true;
	}
}