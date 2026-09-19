public var _hell_yeah_picos = ['17bucks-pico', 'evil-impostor-pico', 'pick', 'pico_due_p1', 'pico_due_p2', 'pico-mix-player', 'pico-playable', 'piico'];

public var _array_picos = [
	['suspect', 'picoweird'],
	['roomcode', 'picoroomcode']
];

var baseChar = 'pico';

var leShitFuckAss;
var leShitFuckAss2;

function onLoad()
{
	songName = Paths.sanitize(PlayState.SONG.song);

	for (i in 0..._array_picos.length)
	{
		leShitFuckAss = _array_picos[i][0];
		leShitFuckAss2 = _array_picos[i][1];
	}

	switch (songName)
	{
		case leShitFuckAss:
			baseChar = leShitFuckAss2;

			for (phillies in 0..._hell_yeah_picos.length)
			{
				if (ClientPrefs.bfSkin == _hell_yeah_picos[phillies])
				{
					PlayState.SONG.player1 = ClientPrefs.bfSkin;
					return;
				}
				else
				{
					PlayState.SONG.player1 = baseChar;
				}
			}
	}
}