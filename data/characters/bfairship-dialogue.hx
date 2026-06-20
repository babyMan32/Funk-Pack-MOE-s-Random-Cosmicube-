var animSuffixVariable:Array = ["", "-alt"];
var animSuffixInt:Int = 0;

function onUpdate(elapsed:Float):Void
{
	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'bfairship-dialogue')
	{
		animSuffixInt = (animSuffixInt + 1) % 2;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
	}
}