function onCreatePost()
{
	divideBy = 1;

	bf2Check = (bf2 != null ? true : false);
	bf3Check = (bf3 != null ? true : false);

	color1 = boyfriend.healthColour;
	color2 = (bf2Check ? bf2.healthColour : 0);
	color3 = (bf3Check ? bf3.healthColour : 0);

	divideBy = divideBy + (bf2Check ? 1 : 0) + (bf3Check ? 1 : 0);

	colorFinal = ((color1 + color2 + color3) / divideBy);

	playHUD.healthBar.setColors(dad.healthColour, colorFinal);
}