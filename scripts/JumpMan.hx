import funkin.game.shaders.ExtraDropShadowShader;

//do NOT touch these
var momentum = 0;
var landing_position = 0;
var grounded = true;

var allow_jump = false;
var jump_check_var = false;

var got_hit = false;
var hurt_timer_const = hurt_timer;

var jump_char_exists = false;

var darkJumpShader:ExtraDropShadowShader;

//you can edit these tho
var in_water = false;
var weight_reduction = 0.4;

var initial_momentum = 24;
var momentum_decrease = 1.2;

var hurt_timer = 1;

function createJumpChar()
{
	bfJump = new Character(0, 0, 'bfMADNESSnewhopping', true);
	boyfriendGroup.insert(boyfriendGroup.members.indexOf(bfJump) + 1, bfJump);

	bfJump.alpha = 0;
	bfJump.visible = jump_char_exists = true;

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
		}
	});
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
	boyfriend.useRenderTexture = true;
	bfJump.shader = null;
}

function onCreatePost()
{
	switch (boyfriend.curCharacter)
	{
		case "bfMADNESSnew":
			allow_jump = jump_check_var = true;

			createJumpChar();
	}
}

function onUpdate(elapsed:Float):Void
{
	if (boyfriend.curCharacter == "bfMADNESSnew")
	{
		jump_check_var = true;
	}

	if (boyfriend.curCharacter != "bfMADNESSnew")
	{
		jump_check_var = false;
	}

	checkCurChar();

	initJump();
}

function checkCurChar()
{
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

function initJump()
{
	if (!jump_check_var) return;

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

	if (got_hit)
	{
		hurt_timer -= elapsed;

		if (hurt_timer <= 0)
		{
			got_hit = false;
			allow_jump = true;
			hurt_timer = hurt_timer_const;
		}
	}

	if (!grounded)
	{
		recalculate_momentum = in_water ? weight_reduction : 1;
		fps_measures = 60 / FlxG.save.data.framerate; //fix so he jumps at the same speed no matter your fps

		bfJump.y -= (momentum * fps_measures) * playbackRate;
		momentum -= ((momentum_decrease * recalculate_momentum) * fps_measures) * playbackRate;

		if (bfJump.y >= landing_position)
		{
			bfJump.y = landing_position;
			momentum = 0;
			grounded = true;

			bfJump.playAnim("land");

			new FlxTimer().start(0.21 / playbackRate, function(_) {
				bfJump.alpha = 0;
				boyfriend.alpha = 1;

				allow_jump = true;
			});
		}
	}
}

function killBFJump()
{
	grounded = allow_jump = true;
	momentum = 0;

	bfJump.visible = jump_char_exists = false;
	bfJump.shader = null;
	bfJump.alpha = 0;
	bfJump.kill();
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
						bfJump.shader = boyfriend.shader;
					});

				case 'ending':
					FlxG.signals.postUpdate.addOnce(function() {
						killBFJump();
					});

				case 'readykill':
					FlxG.signals.postUpdate.addOnce(function() {
						killBFJump();
						boyfriend.alpha = 1;
					});
			}

		case 'Lights out':
			if (value1 == '2') return;
			if (value1 == '1' && !ClientPrefs.flashing) return;

			bfJump.shader = darkJumpShader;

		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;

			FlxG.signals.postUpdate.addOnce(function() {
				bfJump.shader = boyfriend.shader;
			});
	}
}