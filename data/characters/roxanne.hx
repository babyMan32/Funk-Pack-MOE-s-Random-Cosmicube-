var look_dir;
var looking = false;
var last_look = 'dad';

function onLoad()
{
	gf.animation.onFinish.add((animName) -> {
		switch (animName)
		{
			case 'flip':
				gf.playAnim('idle-alt', true);

			case 'flip-alt':
				gf.playAnim('idle', true);
		}
	});
}

function onMoveCamera(focus)
{
	look_dir = (focus == 'boyfriend') ? true : false;
	looking = (last_look != focus) ? true : false;

	if (looking)
	{
		triggerEventNote('Alt Idle Animation', 'gf', look_dir ? '-alt' : '');

		gf.playAnim(look_dir ? 'flip' : 'flip-alt');
	}

	last_look = focus;
}