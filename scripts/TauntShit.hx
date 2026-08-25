var tauntAnim = 'cheer';

public var _character_sets = [ // you can do "_character_sets.push('bfChar', 'gfChar');" in theory to add any chars you want without having to modify this script
	['boyfriend', 'girlfriend', 'combo50'],
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
	['bf-b2', 'whittygf', 'hey'],
	['nene-playable', 'cassandra', 'combo50']
];

function onUpdatePost(elapsed:Float):Void
{
	if (!baddieExists || gf.skipDance) return;

	if (controls.NOTE_TAUNT_P)
	{
		for (i in 0..._character_sets.length)
		{
			tauntCheck(_character_sets[i][0], _character_sets[i][1], (_character_sets[i][2] == null ? tauntAnim : _character_sets[i][2]));
		}
	}
}

function tauntCheck(bfChar, gfChar, heyPose)
{
	if (inCutscene || cpuControlled) return;

	if (boyfriend.curCharacter == bfChar)
	{
		if (gf.curCharacter == gfChar)
		{
			tauntAnim = heyPose;

			if (!gf.hasAnim(tauntAnim)) return;

			gf.playAnim(tauntAnim);
			gf.specialAnim = true;
		}
	}
}