public var _hell_yeah_picos = ['17bucks-pico', 'evil-impostor-pico', 'pick', 'pico_due_p1', 'pico_due_p2', 'pico-mix-player', 'pico-playable', 'piico'];

function onLoad()
{
	songName = Paths.sanitize(PlayState.SONG.song);

	switch (songName)
	{
		case 'suspect':
			for (phillies in 0..._hell_yeah_picos.length)
			{
				if (ClientPrefs.bfSkin == _hell_yeah_picos[phillies])
				{
					PlayState.SONG.player1 = ClientPrefs.bfSkin;
					return;
				}
				else
				{
					PlayState.SONG.player1 = 'picoweird';
				}
			}

		case 'roomcode':
			for (phillies in 0..._hell_yeah_picos.length)
			{
				if (ClientPrefs.bfSkin == _hell_yeah_picos[phillies])
				{
					PlayState.SONG.player1 = ClientPrefs.bfSkin;
					return;
				}
				else
				{
					PlayState.SONG.player1 = 'picoroomcode';
				}
			}
	}
}