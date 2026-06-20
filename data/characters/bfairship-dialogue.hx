var animSuffixVariable:Array = ["", "-alt"];
var animSuffixInt:Int = 0;

function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'bfairship-dialogue')
	{
		animSuffixInt = (animSuffixInt + 1) % 2;

		boyfriend.animSuffix = animSuffixVariable[animSuffixInt];
	}
}