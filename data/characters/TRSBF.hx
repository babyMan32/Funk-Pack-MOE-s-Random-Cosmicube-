function onCreatePost()
{
	if (dad.curCharacter == 'TRSBF-opp')
	{
		boyfriend.playAnim('scared', true);
		boyfriend.specialAnim = true;

		dad.playAnim('scared', true);
		dad.specialAnim = true;
	}
}