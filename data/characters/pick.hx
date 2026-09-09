function noteMiss(note)
{
	if (boyfriend.curCharacter != 'pick') return;

	boyfriend.playAnim('miss', true);
	boyfriend.holdTimer = 0;
}

function noteMissPress(note)
{
	if (boyfriend.curCharacter != 'pick') return;

	boyfriend.playAnim('miss', true);
	boyfriend.holdTimer = 0;
}