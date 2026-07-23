function onStartCountdown() 
{
    if (FlxG.random.bool(27)) 
    {
    pet.scale.set(1.2, 1.2);
    pet.y -= 450;
    pet.x -= 200;
    pet.updateHitbox();
    }
}