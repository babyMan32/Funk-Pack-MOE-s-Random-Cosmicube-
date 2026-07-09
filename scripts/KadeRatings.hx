var StartedPlayerTurns = false;

public function KadeRatings()
{
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.999935) return 'AAAAA';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.9998) return 'AAAA:';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.9997) return 'AAAA.';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.99955) return 'AAAA';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.999) return 'AAA:';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.998) return 'AAA.';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.997) return 'AAA';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.99) return 'AA:';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.965) return 'AA.';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.93) return 'AA';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.9) return 'A:';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.85) return 'A.';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.8) return 'A';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.7) return 'B';
	if ((Math.round(ratingPercent * 10000) / 10000) >= 0.6) return 'C';
	if ((game.totalNotesHit + songMisses) > 0) return 'D';
	return 'N/A';
}

public function KadeCombos()
{
	if (!StartedPlayerTurns || cpuControlled) return '';

	if (goods < 1) return '(MFC) ';
	if (bads < 1 && shits < 1) return '(GFC) ';
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