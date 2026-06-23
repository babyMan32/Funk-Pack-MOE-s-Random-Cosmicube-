var drain_amount_normal = 0.01;
var drain_amount_extra = 0.015;

function opponentNoteHit()
{
	hitCausesDrain("opp");
}

function extraNoteHit()
{
	hitCausesDrain("extra");
}

function hitCausesDrain(noteHit)
{
	drain_amount = noteHit == "extra" ? drain_amount_extra : drain_amount_normal;

	if (health - drain_amount <= 0.1)
	{
		health = 0.1;
		return;
	}

	health -= drain_amount;
}