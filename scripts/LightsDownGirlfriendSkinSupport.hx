var darkGF = null;

var baddieExists:Bool = true;
var allow_gf_taunt = true;

function onLoad()
{
	switch (PlayState.SONG.stage)
	{
		//no gf stages

		case "beach-old", "boiling", "chef", "dave", "defeat", "esculent", "finalem", "idk", "jads", "jerma", "kills", "lounge", "monotone", "nuzzus", "piptowers", "pretender", "turbulence", "victory", "who":
			baddieExists = false;
	}
}

function onCreatePost()
{
	if (!baddieExists) return;

	darkGF = gf.getFlag('variants')?.dark;

	if (darkGF != null) addCharacterToList(darkGF, 2);
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