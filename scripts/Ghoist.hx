using StringTools;

var stroed1 = 0;
var sotred2 = 0;

var speed = 5000;

function onCreatePost()
{
	stroed1 = bfOff[0];
	sotred2 = bfOff[1];
}

function onUpdatePost(elapsed:Float):Void
{
	if (boyfriend.getFlag('ghost') != true) return;

	anim = boyfriend.getAnimName();

	if (boyfriend.getAnimName().contains('idle'))
	{
		boyfriend.offset.x -= elapsed * speed * (boyfriend.offset.x > 0 ? 1 : (boyfriend.offset.x < 0 ? -1 : 0));
		boyfriend.offset.y -= elapsed * speed * (boyfriend.offset.y > 0 ? 1 : (boyfriend.offset.y < 0 ? -1 : 0));
	}

	if (boyfriend.getAnimName().contains('singLEFT'))
	{
		boyfriend.offset.x += elapsed * speed;
	}

	if (boyfriend.getAnimName().contains('singDOWN'))
	{
		boyfriend.offset.y -= elapsed * speed;
	}

	if (boyfriend.getAnimName().contains('singUP'))
	{
		boyfriend.offset.y += elapsed * speed;
	}

	if (boyfriend.getAnimName().contains('singRIGHT'))
	{
		boyfriend.offset.x -= elapsed * speed;
	}

	boyfriend.offset.x = (Math.round(boyfriend.offset.x * 10000) / 10000);
	boyfriend.offset.y = (Math.round(boyfriend.offset.y * 10000) / 10000);

	camSpecialThing(-1, [stroed1 - boyfriend.offset.x, sotred2 - boyfriend.offset.y]);
}