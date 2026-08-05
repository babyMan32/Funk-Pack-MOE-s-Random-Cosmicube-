import openfl.filters.ShaderFilter;

var beer;
var drunk;

var addedShaders = false;

function onCreatePost()
{
	beer = newShader('lsd');
	drunk = newShader('vhs');

	if (camGame.filters == null)
	{
		camGame.filters = [];
	}

	if (camHUD.filters == null)
	{
		camHUD.filters = [];
	}

	if (camOther.filters == null)
	{
		camOther.filters = [];
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (boyfriend.curCharacter != 'beerfriend') return;

	if (health >= 1.6)
	{
		playHUD.healthBar.setColors((dad.curCharacter == 'beerfriend-shimny' ? 0x67009b : null), FlxColor.WHITE);
		playHUD.iconP1.animation.curAnim.curFrame = 2;

		if (dad.curCharacter == 'beerfriend-shimny')
		{
			playHUD.iconP2.animation.curAnim.curFrame = 1;
		}
	}
	else if (health < 1.6 && health > 0.4)
	{
		playHUD.healthBar.setColors(null, boyfriend.healthColour);
		playHUD.iconP1.animation.curAnim.curFrame = 0;

		if (dad.curCharacter == 'beerfriend-shimny')
		{
			playHUD.iconP2.animation.curAnim.curFrame = 0;
		}
	}
	else
	{
		playHUD.healthBar.setColors((dad.curCharacter == 'beerfriend-shimny' ? FlxColor.PURPLE : null), 0x701e4d);
		playHUD.iconP1.animation.curAnim.curFrame = 1;

		if (dad.curCharacter == 'beerfriend-shimny')
		{
			playHUD.iconP2.animation.curAnim.curFrame = 2;
		}
	}
}

function opponentNoteHit(note)
{
	audio.pitch = 1 + (dad.curCharacter == 'beerfriend-shimny' ? FlxG.random.float(-0.5, 0.5) : 0);
	FlxG.timeScale = 1;

	camGame.filters = [];
	camHUD.filters = [];
	camOther.filters = [];

	addedShaders = false;
}

function goodNoteHit(note)
{
	if (boyfriend.curCharacter != 'beerfriend') return;

	FlxG.signals.postUpdate.addOnce(function() {
		audio.pitch = 1 + FlxG.random.float(-0.5, 0.5);

		shaderShit();
	});
}

function shaderShit()
{
	if (addedShaders) return;

	addedShaders = true;

	camGame.filters.push(new ShaderFilter(beer));
	camGame.filters.push(new ShaderFilter(drunk));

	camHUD.filters.push(new ShaderFilter(beer));
	camHUD.filters.push(new ShaderFilter(drunk));

	camOther.filters.push(new ShaderFilter(beer));
	camOther.filters.push(new ShaderFilter(drunk));
}