var shader = game.createRuntimeShader("adjustColor");
var shader2 = game.createRuntimeShader("RGB_PIN_SPLIT");

function onCreatePost() game.camGame.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]); game.camHUD.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]);

var twn;
var twn2;
var twn3;

function onEvent(ev,v1,v2) 
{
    if (ev == 'Trigger') 
    {
        if (v1 == 'coolbop')
        {
        if (twn != null) twn.cancel();
        if (twn2 != null) twn2.cancel();
        if (twn3 != null) twn3.cancel();

        twn = FlxTween.num(40, 0, 0.75, {ease: FlxEase.quadOut}, f -> shader.setFloat("contrast", f));
        twn2 = FlxTween.num(40, 0, 0.65, {ease: FlxEase.quadOut}, s -> shader.setFloat("brightness", s));
        twn3 = FlxTween.num(0.02, 0, 1, {ease: FlxEase.quadOut}, t -> shader2.setFloat("amount", t));
        }
    }
}