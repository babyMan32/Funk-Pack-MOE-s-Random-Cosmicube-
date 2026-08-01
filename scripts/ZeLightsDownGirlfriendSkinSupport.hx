var darkGF = null;

function onCreatePost()
{
	FlxG.signals.postUpdate.addOnce(function() {
		if (!baddieExists) return;

		darkGF = gf.getFlag('variants')?.dark;

		if (darkGF != null) addCharacterToList(darkGF, 2);
	});
}

function onEvent(ev, v1, v2)
{
	switch (ev)
	{
		case 'Lights out':
			if (v1 == '2' /* ????? */ || (v1 == '1' && !ClientPrefs.flashing)) return;

			if (darkGF == null) return;

			FlxG.signals.postUpdate.addOnce(function() {
				gf.alpha = 1;
			});

			changeCharacter(darkGF, 2);

		case 'Lights on':
			if (v1 == '1' && !ClientPrefs.flashing) return;

			if (darkGF == null) return;

			changeCharacter(ClientPrefs.gfSkin, 2);
	}
}