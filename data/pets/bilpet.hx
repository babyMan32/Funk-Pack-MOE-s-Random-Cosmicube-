var beeg = false;

function onLoad() 
{
    if (FlxG.random.bool(10)) 
    {
        pet.scale.set(1.2, 1.2);
        pet.y -= 450;
        pet.x -= 200;
        pet.updateHitbox();
        beeg = true;
    }
}

function onCreatePost()
{
    if (beeg && PlayState.SONG.song == 'Identity Crisis')
    {
        copyPet.scale.set(1.2, 1.2);
        copyPet.y = pet.y - 25;
        copyPet.x -= 200;
        copyPet.updateHitbox();
    }
}