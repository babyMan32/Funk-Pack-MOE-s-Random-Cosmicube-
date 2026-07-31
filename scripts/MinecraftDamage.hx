var minceraft = false;

function onCreatePost()
{
	minceraft = boyfriend.getFlag('minecraftSkin') ?? false;
}

function onBeatHit()
{
	if (!minceraft) return;

	if (curBeat % boyfriend.danceEveryNumBeats == 0)
	{
		boyfriend.color = 0xFF8888;

		health -= 0.025;

		camGame.angle = FlxG.random.bool() ? -5 : 5;

		FlxTween.tween(camGame, {angle: 0}, 0.3, {
			ease: FlxEase.quartOut,
			onComplete: function(tween:FlxTween)
			{
				boyfriend.color = 0xFFFFFF;
			}
		});
	}
}