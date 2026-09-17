import funkin.game.shaders.ExtraDropShadowShader;

var stageRimExtraExtras:ExtraDropShadowShader = new ExtraDropShadowShader();

public function shadersExtraCheck()
{
	if (ClientPrefs.shaders)
	{
		if(boyfriend.shader != null && Std.isOfType(boyfriend.shader, ExtraDropShadowShader))
		{
			stageRimExtraExtras.copyFrom(boyfriend.shader);
			return stageRimExtraExtras;
		}
	}

	return stageRimExtraExtras;
}