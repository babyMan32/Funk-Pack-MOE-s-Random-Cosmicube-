var enableCamBullshittery = false;
var camSpecialMidpoint = false;
var running_closer_var = false;
var camSpecialSameX = false;
var getting_frantic = false;
var camSpecialOppBaseX = 0;
var camSpecialZoom = 0.5;
var camSpecialPlayX = 0;
var oppInDanger = false;
var screaming = false;
var camSpecialY = 150;
var screamed = false;
var camSpecialX = 0;
var bonusGain = 0;
var ogPos = 0;

function onCreatePost()
{
	if (ClientPrefs.bfSkin == "bf-dialogue" || ClientPrefs.bfSkin == "bfMADNESSnew")
	{
		switch (PlayState.SONG.stage)
		{
			case "danger":
				running_closer_var = true;

				ogPos = dad.x;
		}
	}
}

function onBeatHit()
{
	if (!running_closer_var) return; //This is just for "Danger" lmfao

	switch (curBeat)
	{
		case 1:
			enableCamBullshittery = camSpecialSameX = camSpecialMidpoint = true;
			camSpecialX = 1200;
			camSpecialY = -54.3;
			camSpecialZoom = 0.3;
		case 64:
			camSpecialSameX = camSpecialMidpoint = false;
			camSpecialOppBaseX = 800;
			camSpecialPlayX = 1200;
			camSpecialY = 150;
			camSpecialZoom = 0.4;
		case 96:
			camSpecialOppBaseX = 700;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.6;
		case 128:
			camSpecialOppBaseX = 800;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.4;
		case 144:
			camSpecialOppBaseX = 800;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.5;
		case 152:
			camSpecialOppBaseX = 800;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.6;
		case 154:
			camSpecialSameX = true;
			camSpecialX = 600;
			camSpecialZoom = 0.6;
		case 156:
			camSpecialZoom = 0.8;
		case 158:
			camSpecialX = 900;
			camSpecialZoom = 0.6;
		case 160:
			camSpecialSameX = false;
			camSpecialOppBaseX = 800;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.4;
		case 192:
			camSpecialOppBaseX = 700;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.6;
		case 256:
			camSpecialOppBaseX = 800;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.4;
		case 288:
			camSpecialOppBaseX = 700;
			camSpecialPlayX = 1200;
			camSpecialZoom = 0.6;
		case 320:
			getting_frantic = true;
			health = health / 2;

			camSpecialSameX = camSpecialMidpoint = true;
			camSpecialX = 1200;
			camSpecialY = -54.3;
			camSpecialZoom = 0.3;
		case 384:
			camSpecialSameX = camSpecialMidpoint = false;
			camSpecialOppBaseX = 700;
			camSpecialPlayX = 1200;
			camSpecialY = 150;
			camSpecialZoom = 0.6;
		case 416:
			camSpecialPlayX = 1800;
			camSpecialY = 300;
			camSpecialZoom = 0.8;
	}
}

function onUpdate(elapsed:Float):Void
{
	if (running_closer_var)
	{
		if (screaming)
		{
			health = 0.00000000000000000000001;
		}

		distFromBasePos = ogPos + ((1 - health) * 500) * (getting_frantic ? 2 : 1);

		dad.x = FlxMath.lerp(dad.x, distFromBasePos, 0.1);

		bullshitCamLele();
	}
}

function onUpdatePost(elapsed):Void
{
	if (!running_closer_var) return;

	iconP1.x = 850;

	dadLegs.x = dad.x;

	oppInDanger = (healthBar.percent >= 80) ? true : false;
	bonusGain = (combo / 100000) * 2;
}

function opponentNoteHit()
{
	if (!running_closer_var) return;

	painAdd = 0.005 * (screamed ? 2 : 1) * (getting_frantic ? 2 : 1) * (oppInDanger ? 5 : 1);

	if (health - painAdd <= 0)
	{
		health = 0.00000000000000000000001;
		return;
	}

	health -= painAdd;
}

function goodNoteHit()
{
	if (!running_closer_var) return;

	health += bonusGain;
}

function bullshitCamLele()
{
	percentZoom = Math.abs(health / 2 - 1);

	newCamZoom = (camSpecialZoom * (percentZoom + 1)) * 1.4;

	camYRecalced = camSpecialY + (((2 - health) + 0.42) * 190);

	if (enableCamBullshittery)
	{
		camSpecialThing([camSpecialOppBaseX + distFromBasePos, camSpecialY], [camSpecialPlayX, camSpecialY], (camSpecialMidpoint ? newCamZoom : camSpecialZoom));

		if (camSpecialSameX)
		{
			bullshitVariable = camSpecialX + (distFromBasePos / (camSpecialMidpoint ? 2 : 1));

			camSpecialThing([bullshitVariable, (camSpecialMidpoint ? camYRecalced : camSpecialY)], [bullshitVariable, (camSpecialMidpoint ? camYRecalced : camSpecialY)], (camSpecialMidpoint ? newCamZoom : camSpecialZoom));
		}
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 == 'scream danger')
			{
				screaming = true;
				screamed = true;
			}

			if (value1 == 'unscream danger')
			{
				screaming = false;
			}
	}
}