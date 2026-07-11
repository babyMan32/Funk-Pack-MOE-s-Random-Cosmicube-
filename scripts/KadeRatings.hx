var StartedPlayerTurns = false;

public function KadeRatings()
{
	calculatedPercent = (Math.round(ratingPercent * 1000000) / 1000000);

	if (calculatedPercent >= 0.999935) return 'AAAAA';
	if (calculatedPercent >= 0.9998) return 'AAAA:';
	if (calculatedPercent >= 0.9997) return 'AAAA.';
	if (calculatedPercent >= 0.99955) return 'AAAA';
	if (calculatedPercent >= 0.999) return 'AAA:';
	if (calculatedPercent >= 0.998) return 'AAA.';
	if (calculatedPercent >= 0.997) return 'AAA';
	if (calculatedPercent >= 0.99) return 'AA:';
	if (calculatedPercent >= 0.965) return 'AA.';
	if (calculatedPercent >= 0.93) return 'AA';
	if (calculatedPercent >= 0.9) return 'A:';
	if (calculatedPercent >= 0.85) return 'A.';
	if (calculatedPercent >= 0.8) return 'A';
	if (calculatedPercent >= 0.7) return 'B';
	if (calculatedPercent >= 0.6) return 'C';
	if ((game.totalNotesHit + songMisses) > 0) return 'D';
	return 'N/A';
}

public function KadeCombos()
{
	if (!StartedPlayerTurns || cpuControlled) return '';

	if (goods < 1 && bads < 1 && shits < 1 && songMisses < 1) return '(MFC) ';
	if (bads < 1 && shits < 1 && songMisses < 1) return '(GFC) ';
	if (songMisses < 1) return '(FC) ';
	if (songMisses < 10) return '(SDCB) ';
	if (songMisses >= 10) return '(Clear) ';
}

function noteMiss()
{
	StartedPlayerTurns = true;
}

function goodNoteHit()
{
	StartedPlayerTurns = true;
}