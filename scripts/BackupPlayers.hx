using StringTools;

var extraPlayer;

public var bf2:Null<String>;

public var extraIdleSuffix = '';
public var extraAnimSuffix = '';
public var tauntAnim = 'hey';

var direction = 'Left';

var bf2StageRim;

function onCreatePost()
{
	if (!hasBfSkin || boyfriend.curCharacter != ClientPrefs.bfSkin) return;

	extraPlayer = ClientPrefs.equipment.get('extraPlayerSkin');

	if (extraPlayer == null) return;

	bf2 = new Character(0, 0, extraPlayer, true);
	boyfriendGroup.insert(0, bf2);
	bf2.x += bf2.getFlag('offsetX') ?? 250;
	bf2.y += bf2.getFlag('offsetY') ?? 75;

	bf2Icon = new HealthIcon(bf2.healthIcon, true);
	playHUD.insert(2, bf2Icon);

	bf2StageRim = shadersCheck();

	if (bf2StageRim == null)
	{
		bf2.shader = boyfriend.shader;
		return;
	}

	bf2Rim = bf2StageRim;
	bf2Rim.attachedSprite = bf2;
	bf2.useRenderTexture = true;
}

function onBeatHit()
{
	if (bf2 == null) return;

	if (curBeat % bf2.danceEveryNumBeats == 0)
	{
		if (bf2.getAnimName().contains('idle'))
		{
			bf2.playAnim('idle' + extraIdleSuffix);
		}

		if (bf2.getAnimName().contains('dance'))
		{
			bf2.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf2.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function onCountdownTick(tick)
{
	if (bf2 == null) return;

	if (tick % bf2.danceEveryNumBeats == 0)
	{
		if (bf2.getAnimName().contains('idle'))
		{
			bf2.playAnim('idle' + extraIdleSuffix);
		}

		if (bf2.getAnimName().contains('dance'))
		{
			bf2.playAnim('dance$direction' + extraIdleSuffix);
			direction = (bf2.getAnimName() == 'danceLeft' ? 'Right' : 'Left');
		}
	}
}

function goodNoteHit(note)
{
	if (bf2 == null) return;

	bf2.holdTimer = 0;

	if (note.isSustainNote && bf2.vSliceSustains) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + extraAnimSuffix, true);
}

function noteMiss(note)
{
	if (bf2 == null) return;

	bf2.playAnim(note.skin.data.singAnimations[note.noteData] + 'miss' + extraAnimSuffix, true);
	bf2.holdTimer = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (bf2 == null) return;

	bf2Icon.x = iconP1.x + 75;
	bf2Icon.y = iconP1.y - 25;
	bf2Icon.scale.set(iconP1.scale.x, iconP1.scale.y);
	bf2Icon.shader = iconP1.shader;
	bf2Icon.updateIconAnim(healthBar.percent * 0.01);
	bf2Icon.alpha = iconP1.alpha;
	bf2Icon.visible = iconP1.visible;

	curAnim = bf2.getAnimName();

	curAnimFinished = bf2.isAnimFinished();

	if (curAnimFinished)
	{
		switch (curAnim)
		{
			case "idle", "idle-loop":
				if (bf2.hasAnim("idle-loop"))
				{
					bf2.playAnim('idle-loop');
				}

			case "singLEFT", "singLEFT-loop":
				if (bf2.hasAnim("singLEFT-loop"))
				{
					bf2.playAnim('singLEFT-loop');
				}

			case "singDOWN", "singDOWN-loop":
				if (bf2.hasAnim("singDOWN-loop"))
				{
					bf2.playAnim('singDOWN-loop');
				}

			case "singUP", "singUP-loop":
				if (bf2.hasAnim("singUP-loop"))
				{
					bf2.playAnim('singUP-loop');
				}

			case "singRIGHT", "singRIGHT-loop":
				if (bf2.hasAnim("singRIGHT-loop"))
				{
					bf2.playAnim('singRIGHT-loop');
				}
		}
	}

	if (cpuControlled) return;

	if (controls.NOTE_TAUNT_P && bf2.hasAnim(tauntAnim))
	{
		bf2.playAnim(tauntAnim);
		bf2.specialAnim = true;
	}
}