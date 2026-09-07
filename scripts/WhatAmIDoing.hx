import funkin.FunkinAssets;
import haxe.ds.WeakMap;
import sys.io.File;

var _stage_flag_pos = [
	['cargo', 3350, 1300, 'ghost'],
	['danger', 26000, 500, 'runner', true, true, 'horizontal'],
	['ejected', 2000, 3000, 'floating', true, true, 'vertical']
];

var _the_flag_maybe;

var whatIsThis:Map<FunkinSprite, Dynamic> = new WeakMap();

var flagspeed:Float = (ClientPrefs.photosensitive ? 7 : 9);

function onCreatePost()
{
	for (stages in 0..._stage_flag_pos.length)
	{
		if (PlayState.SONG.stage == _stage_flag_pos[stages][0])
		{
			if (!FunkinAssets.exists(Paths.txt('_flags_collected/' + _stage_flag_pos[stages][3]))) return;

			if (FunkinAssets.getContent(Paths.txt('_flags_collected/' + _stage_flag_pos[stages][3])) == 'true') return;

			_the_flag_maybe = new FlxSprite(_stage_flag_pos[stages][1], _stage_flag_pos[stages][2]).loadGraphic(Paths.image('flag rofl', null, null, PathsTestMode.LOOSE));
			_the_flag_maybe.scale.set(0.05, 0.05);
			_the_flag_maybe.updateHitbox();

			whatIsThis.set(_the_flag_maybe, {
				name: "Weird Flag | " + _stage_flag_pos[stages][0],
				flagToGive: _stage_flag_pos[stages][3],
				layerBehind: (_stage_flag_pos[stages][4] ?? false),
				canMove: (_stage_flag_pos[stages][5] ?? false),
				moveDirection: (_stage_flag_pos[stages][6] ?? 'horizontal')
			});

			if (whatIsThis.get(_the_flag_maybe).layerBehind != true)
			{
				add(_the_flag_maybe);
			}
			else
			{
				stage.insert(stage.members.indexOf(dadGroup) - 0, _the_flag_maybe);
			}
		}
	}

	if (!FunkinAssets.exists(Paths.txt('_flags_collected/' + whatIsThis.get(_the_flag_maybe)?.flagToGive))) return;

	trace('Is "' + whatIsThis.get(_the_flag_maybe)?.name + '" Collected? | ' + FunkinAssets.getContent(Paths.txt('_flags_collected/' + whatIsThis.get(_the_flag_maybe)?.flagToGive)));

	trace(whatIsThis.get(_the_flag_maybe)?.moveDirection);
	trace(whatIsThis.get(_the_flag_maybe)?.canMove);
	trace(whatIsThis.get(_the_flag_maybe)?.layerBehind);
	trace(whatIsThis.get(_the_flag_maybe)?.flagToGive);
	trace(whatIsThis.get(_the_flag_maybe)?.name);
}

function onUpdatePost(elapsed:Float):Void
{
	if (whatIsThis.get(_the_flag_maybe)?.canMove == true)
	{
		if (whatIsThis.get(_the_flag_maybe)?.moveDirection == 'horizontal')
		{
			final leSpeed:Float = (elapsed * flagspeed * playbackRate);

			_the_flag_maybe.x -= (leSpeed * 300);
		}

		if (whatIsThis.get(_the_flag_maybe)?.moveDirection == 'vertical')
		{
			final leSpeed:Float = (elapsed * flagspeed);

			_the_flag_maybe.y -= (leSpeed * 20);
		}
	}

	didYouClickFlag();
}

function didYouClickFlag()
{
	if (_the_flag_maybe == null) return;

	if (!FlxG.mouse.overlaps(_the_flag_maybe)) return;

	if (!FlxG.mouse.justPressed) return;

	if (!_the_flag_maybe.visible) return;

	_the_flag_maybe.visible = false;

	FlxG.sound.play(Paths.sound('equip'));

	File.saveContent(Paths.txt('_flags_collected/' + whatIsThis.get(_the_flag_maybe)?.flagToGive), 'true');

	trace('Is "' + whatIsThis.get(_the_flag_maybe)?.name + '" Collected? | ' + FunkinAssets.getContent(Paths.txt('_flags_collected/' + whatIsThis.get(_the_flag_maybe)?.flagToGive)));
}