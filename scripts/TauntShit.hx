var allow_gf_taunt = true;
var tauntAnim = 'cheer';

public var _character_sets = [ // you can do "_character_sets.push('bfChar', 'gfChar');" in theory to add any chars you want without having to modify this script
	['boyfriend', 'girlfriend'],
	['girlfriend-playable', 'boyfriend-speaker'],
	['bf-dialogue', 'gf-dialogue'],
	['bf-b3', 'gf-b3'],
	['bf-b-classic', 'gf-b-classic'],
	['bf-b-redux', 'gf-b-redux'],
	['bf-costume', 'gf-costume'],
	['bf-dsides', 'gf-dsides'],
	['bf-dsides_OLD', 'gf-dsides_OLD'],
	['bf-gsides', 'gf-gsides'],
	['bf-mix', 'gf-mix'],
	['bf-b2', 'whittygf'],
	['nene-playable', 'cassandra']
];

function onUpdatePost(elapsed:Float):Void
{
	if (!baddieExists || gf.skipDance) return;

	if (controls.NOTE_TAUNT_P)
	{
		tauntCheck();
	}

	if (gf.getAnimName() != tauntAnim)
	{
		allow_gf_taunt = true;
	}
}

function tauntCheck()
{
	if (inCutscene || cpuControlled) return;

	for (i in 0..._character_sets.length)
	{
		if (boyfriend.curCharacter == _character_sets[i][0])
		{
			if (gf.curCharacter == _character_sets[i][1] && allow_gf_taunt)
			{
				tauntAnim = (gf.hasAnim('hey') ? 'hey' : (gf.hasAnim('cheer') ? 'cheer' : 'combo50'));

				if (!gf.hasAnim(tauntAnim)) return; // how the fuck do you have none of these?

				gf.playAnim(tauntAnim);
				gf.specialAnim = true;

				allow_gf_taunt = false;
			}
		}
	}
}