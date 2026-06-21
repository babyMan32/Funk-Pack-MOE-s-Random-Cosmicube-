function onKeyPress(k:Int):Void
{
	if (k == 2 && parent.getAnimName() == 'idle' && (tauntCharacter == null || tauntCharacter == parent))
	{
		parent.playAnim('singUP');
		parent.specialAnim = parent.holding = true;
	}
}