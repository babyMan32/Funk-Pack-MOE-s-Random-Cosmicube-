function onKeyPress(k:Int):Void
{
	if (k == 0 && parent.getAnimName() == 'idle' && (tauntCharacter == null || tauntCharacter == parent))
	{
		parent.playAnim('scared');
		parent.specialAnim = parent.holding = true;
	}
}