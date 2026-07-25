import funkin.objects.HealthIcon;
import flixel.system.FlxBGSprite;

var bg:FlxBGSprite;
var overlayCamera:FlxCamera;

public var canMove = false;
	
var bf:HealthIcon;
var glung:HealthIcon;
var iconArray:Array<HealthIcon> = [];

function onLoad()
{
	canMove = false;

	overlayCamera = new FlxCamera();
	overlayCamera.bgColor = 0x00000000;
	overlayCamera.antialiasing = ClientPrefs.globalAntialiasing;
	FlxG.cameras.add(overlayCamera, false);
		
	camera = overlayCamera;
		
	bg = new flixel.system.FlxBGSprite();
	bg.color = FlxColor.BLACK;
	bg.alpha = 0;
	add(bg);

	bf = new HealthIcon('bf', false);
	bf.screenCenter();
	bf.x -= 320;
	bf.alpha = 0;
	add(bf);
	iconArray.push(bf);

	glung = new HealthIcon('pico', false);
	glung.screenCenter();
	glung.x += 320;
	glung.alpha = 0;
	add(glung);
	iconArray.push(glung);
}