import funkin.game.shaders.ExtraDropShadowShader;

//you can edit these
var floaty = false;
var weight_reduction = 0.4;

var initial_momentum = 24;
var momentum_decrease = 1.2;

var hurt_timer = 1.5;

var excludedStages = ["ejected", "voting", "turbulence", "skeldpixel"];

//but do NOT touch these
var momentum = 0;
var landing_position = 0;
var grounded = true;

var allow_jump = false;
var jump_check_var = false;

var got_hit = false;
var hurt_timer_const = hurt_timer;

var jump_char_exists = false;

var jumped_on_bill = false;
var billFallMomentum = 12;
var bullet_exists = false;

var low = false;
var showbills = false;

var darkJumpShader:ExtraDropShadowShader;

function createJumpChar()
{
	bfJump = new Character(0, 0, 'bfMADNESSnewhopping', true);
	boyfriendGroup.insert(boyfriendGroup.members.indexOf(bfJump) + 1, bfJump);

	bfJump.alpha = 0;
	bfJump.visible = jump_char_exists = true;

	boyfriendHurt = new Character(0, 0, 'bfMADNESSnew-hurtAnim', true);
	boyfriendGroup.insert(boyfriendGroup.members.indexOf(boyfriendHurt) + 1, boyfriendHurt);

	boyfriendHurt.alpha = 0;

	FlxG.signals.postUpdate.addOnce(function() {
		addLightsDownShaderBS();

		bfJump.x = boyfriend.x - 45;
		bfJump.y = boyfriend.y - 291;

		landing_position = bfJump.y;

		if (boyfriend.shader != null)
		{
			bfJumpingRim = new funkin.game.shaders.ExtraDropShadowShader().copyFrom(boyfriend.shader);
			bfJump.shader = bfJumpingRim;
			bfJumpingRim.attachedSprite = bfJump;
			bfJumpingRim.updateFrameInfo(bfJump.frame);

			bfPainedRim = new funkin.game.shaders.ExtraDropShadowShader().copyFrom(boyfriend.shader);
			boyfriendHurt.shader = bfPainedRim;
			bfPainedRim.attachedSprite = boyfriendHurt;
			bfPainedRim.updateFrameInfo(boyfriendHurt.frame);
		}
	});

	bfBounding = new FlxSprite().makeGraphic((bfJump.width * 6) / 7, (bfJump.height * 24) / 37, FlxColor.WHITE);
	bfBounding.x = bfJump.x;
	bfBounding.y = bfJump.y + 250;
	bfBounding.alpha = (ClientPrefs.inDevMode ? 0.3 : 0);
	add(bfBounding);

	showbills = true;
}

var evilBill;

function createBill()
{
	low = FlxG.random.bool();

	evilBill = new FlxSprite(0, 0).loadGraphic(Paths.image('bullet', null, null, PathsTestMode.LOOSE));
	evilBill.antialiasing = false;
	evilBill.x = BF_X - 10000;
	evilBill.y = (BF_Y + 300) + (low ? 250 : -350);
	evilBill.scale.x = 0.4;
	evilBill.scale.y = 0.4;
	evilBill.updateHitbox();
	evilBill.visible = showbills;
	evilBill.flipX = bullet_exists = true;
	jumped_on_bill = false;
	billFallMomentum = 12;

	stage.insert(stage.members.indexOf(boyfriendGroup) + 1, evilBill);
}

function addLightsDownShaderBS()
{
	darkJumpShader = new funkin.game.shaders.ExtraDropShadowShader();

	darkJumpShader.threshold = 0.03;
	darkJumpShader.setHollowColorMatrix([
		0, 0, 0, 0, 255,
		0, 0, 0, 0, 255,
		0, 0, 0, 0, 255,
		0, 0, 0, 1, 0
	]);
	darkJumpShader.setColorMatrix([
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 1, 0
	]);
	darkJumpShader.antialiasStages = 4;

	darkJumpShader.addLayer([
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 1, 0
	], -70, 22, 0);
	darkJumpShader.addLayer([
		0, 0, 0, 0, 255,
		0, 0, 0, 0, 255,
		0, 0, 0, 0, 255,
		0, 0, 0, 1, 0
	], 140, 15, 0);
	darkJumpShader.addLayer([
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 1, 0
	], -32, 15, 0);
	
	darkJumpShader.attachedSprite = bfJump;
	bfJump.shader = null;
}

function onCreatePost()
{
	switch (boyfriend.curCharacter)
	{
		case "bfMADNESSnew":
			allow_jump = true;

			checkSongAndStage();
	}
}

function checkSongAndStage()
{
	if (!excludedStages.contains(PlayState.SONG.stage))
	{
		jump_check_var = true;
	}

	if (PlayState.SONG.stage == "monotone")
	{
		floaty = false;
	}
}

function onUpdate(elapsed:Float):Void
{
	checkCurChar();

	initJump(elapsed);

	checkHurt(elapsed);
}

function onSectionHit()
{
	if (!jump_char_exists) return;

	if (FlxG.random.bool() && !bullet_exists)
	{
		createBill();
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!jump_char_exists) return;

	boyfriendHurt.x = bfJump.x + 45;
	boyfriendHurt.y = bfJump.y + 291;

	if (dad.curCharacter == "greenEjected")
	{
		floaty = true;
	}
	else
	{
		floaty = false;
	}
}

var bulletSpeed:Float = 2000;

function checkHurt(elapsed:Float)
{
	if (!jump_check_var || evilBill == null) return;

	if (!bullet_exists) return;

	if (!jumped_on_bill)
	{
		evilBill.x += (bulletSpeed * playbackRate) * elapsed;
	}

	if (jumped_on_bill)
	{
		evilBill.y -= billFallMomentum * playbackRate;

		if (billFallMomentum > -30)
		{
			billFallMomentum -= 0.8 * playbackRate;
		}
	}

	if (evilBill.x > boyfriend.x + 1500 || evilBill.y > boyfriend.y + 800)
	{
		bullet_exists = false;
		evilBill.destroy();
	}

	if (!evilBill.visible) return;

	pain = evilBill.overlaps(bfBounding);

	if (pain && !got_hit && !jumped_on_bill)
	{
		if (momentum < 0)
		{
			momentum = initial_momentum;
			jumped_on_bill = true;
			health += 0.1;
		}
		else if (momentum > 0 && low)
		{
			// run nothing just make sure he doesnt hurt lol
		}
		else
		{
			boyfriendHurt.playAnim("hurt");
			boyfriendHurt.specialAnim = boyfriendHurt.holding = got_hit = true;
			health /= 2;
		}
	}
}

function checkCurChar()
{
	if (!jump_check_var) return;

	if (boyfriend.curCharacter == "bfMADNESSnew" && !jump_char_exists)
	{
		createJumpChar();
	}

	if (boyfriend.curCharacter != "bfMADNESSnew" && jump_char_exists)
	{
		killBFJump();
		boyfriend.alpha = 1;
	}
}

function initJump(elapsed:Float)
{
	if (!jump_char_exists) return;

	bfBounding.y = bfJump.y + 250;

	if (controls.NOTE_TAUNT_P && grounded && allow_jump && !got_hit)
	{
		momentum = initial_momentum;
		allow_jump = false;

		bfJump.alpha = 1;
		boyfriend.alpha = 0;
		bfJump.visible = true;

		bfJump.playAnim("pre-jump");

		new FlxTimer().start(0.125 / playbackRate, function(_) {
			if (!got_hit)
			{
				bfJump.playAnim("jump");

				grounded = false;
			}
		});
	}

	if (controls.NOTE_TAUNT_R && momentum > 0 && !got_hit)
	{
		if (!allow_jump && grounded)
		{
			momentum = 4;
		}
		else if (!allow_jump && !grounded)
		{
			if (bfJump.y < landing_position - 100)
			{
				momentum = 4;
			}
			else if (bfJump.y >= landing_position - 100)
			{
				momentum = 0;
			}
		}
	}

	if (got_hit)
	{
		bfJump.alpha = 0;
		boyfriend.alpha = 0;
		boyfriendHurt.alpha = 1;
		hurt_timer -= elapsed;

		if (health > 0.001)
		{
			health -= (Math.max(health - 0.001, 0) * 0.0025);
		}

		if (hurt_timer <= 0)
		{
			got_hit = false;
			allow_jump = true;
			hurt_timer = hurt_timer_const;
			boyfriendHurt.alpha = 0;
			boyfriend.alpha = 1;
		}
	}

	if (!grounded)
	{
		recalculate_momentum = floaty ? weight_reduction : 1;
		fps_measures = 60 / FlxG.save.data.framerate; //fix so he jumps at the same speed no matter your fps

		bfJump.y -= (momentum * fps_measures) * playbackRate;
		momentum -= ((momentum_decrease * recalculate_momentum) * fps_measures) * playbackRate;

		if (bfJump.y >= landing_position)
		{
			bfJump.y = landing_position;
			momentum = 0;
			grounded = true;

			if (!got_hit)
			{
				bfJump.playAnim("land");

				new FlxTimer().start(0.21 / playbackRate, function(_) {
					bfJump.alpha = 0;
					boyfriend.alpha = 1;

					allow_jump = true;
				});
			}
		}
	}
}

function killBFJump()
{
	grounded = allow_jump = true;
	momentum = 0;

	bfJump.shader = boyfriendHurt.shader = null;
	bfJump.visible = jump_char_exists = false;
	boyfriendHurt.destroy();
	bfBounding.destroy();
	bfJump.alpha = 0;
	bfJump.destroy();

	showbills = false;
}

function onEvent(eventName, value1, value2)
{
	if (!jump_check_var) return;

	switch (eventName)
	{
		case 'Legacy':
			switch (value1)
			{
				case 'Vignette On', 'Vignette Off':
					FlxG.signals.postUpdate.addOnce(function() {
						bfJump.shader = boyfriendHurt.shader = boyfriend.shader;
					});

				case 'ending':
					FlxG.signals.postUpdate.addOnce(function() {
						bfJump.shader = boyfriendHurt.shader = boyfriend.shader;
						bfJump.visible = allow_jump = false;
						grounded = true;
						momentum = 0;
					});

				case 'readykill':
					FlxG.signals.postUpdate.addOnce(function() {
						killBFJump();
						boyfriend.alpha = 1;
					});
			}

		case 'Lights out':
			if (value1 == '2' /* ????? */ || (value1 == '1' && !ClientPrefs.flashing)) return;

			bfJump.shader = darkJumpShader;

		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;

			FlxG.signals.postUpdate.addOnce(function() {
				bfJump.shader = boyfriendHurt.shader = boyfriend.shader;
			});
	}
}