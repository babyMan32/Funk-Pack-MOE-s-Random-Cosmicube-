import funkin.audio.visualize.PolygonSpectogram;
import funkin.game.shaders.ChromaticAbberation;

var vus:PolygonSpectogram;

var chroma:ChromaticAbberation;
var chromaPet:ChromaticAbberation;

var strengthing:Float = 0.15;
var strengthingPet:Float = 0.25;

function onCreatePost()
{
	vus = new PolygonSpectogram(audio.inst);
	add(vus);

	canPause = false;

	playFields.members[1].camera = PlayState.instance.camGame;
	modManager.setValue("transformX", -100, 1);

	modManager.setValue('sustainSplashAlpha', 1, 1);

	chroma = new ChromaticAbberation();
	chromaPet = new ChromaticAbberation();

	chroma.set_amount(strengthing);
	chromaPet.set_amount(strengthingPet);

	boyfriend.shader = chroma.shader;
	pet?.shader = chromaPet.shader;
}

function onStepHit()
{
	switch (curStep)
	{
		case 188:
			defaultCamZoom = 1.2;
			bfOff[1] = 1420;

		case 192:
			bfOff[1] = 920;

			triggerEventNote('Legacy', 'Show Task Song', 'info');
			canPause = true;
	}
}

function onSpawnNote(note)
{
	if (note.lane == 1)
	{
		note.camera = playFields.members[1].camera;
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 == 'scream')
			{
				strengthing += 0.1;
				strengthingPet += 0.15;

				chroma.set_amount(strengthing);
				chromaPet.set_amount(strengthingPet);
			}
	}
}