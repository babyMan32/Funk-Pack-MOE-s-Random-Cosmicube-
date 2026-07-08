var womanExists:Bool = true;
var gf_falling_var = false;
var allow_taunt = true;

function onCreatePost()
{
	if (hasGfSkin)
	{
		switch (PlayState.SONG.song)
		{
			case "Reactor":
				triggerEventNote('Change Character', 'gf', 'gfr-dialogue');

			case "Ejected":
				triggerEventNote('Change Character', 'gf', 'gf-fall-dialogue');

				gf_falling_var = true;

				gf.shader = dad.shader;

			case "Danger":
					triggerEventNote('Change Character', 'gf', 'gfdanger-dialogue');
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	if (gf_falling_var)
	{
		gf.x = 500;
	}
}