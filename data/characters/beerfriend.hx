import openfl.filters.ShaderFilter;

var beer;
var drunk;

var value = 0.5;
var constValue = value;

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

function opponentNoteHit(note)
{
	audio.pitch = 1;

	camGame.filters = [];
	camHUD.filters = [];
	camOther.filters = [];

	addedShaders = false;

	value = constValue;
}

function extraNoteHit(note)
{
	audio.pitch = 1;

	camGame.filters = [];
	camHUD.filters = [];
	camOther.filters = [];

	addedShaders = false;

	value = constValue;
}

function onGameOverPost()
{
	camGame.filters = [];
	camHUD.filters = [];
	camOther.filters = [];

	addedShaders = false;

	value = constValue;
}

function goodNoteHit(note)
{
	if (boyfriend.curCharacter != 'beerfriend') return;

	// if (FlxG.random.bool(5))
	// {
	// 	value += 0.1;
	// 	addedShaders = false;
	// }

	// FlxG.signals.postUpdate.addOnce(function() {
	// 	audio.pitch = 1 + FlxG.random.float(-value, value);

	// 	shaderShit();
	// });
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