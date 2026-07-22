#pragma header

uniform float ratio = 1;

void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec4 tex = flixel_texture2D(bitmap, uv);

    if (tex.a > 0.0) 
    {
        if (tex.r <= 0.05 && tex.g <= 0.05 && tex.b <= 0.05) tex.rgb = vec3(255,0.0,0.0);
        else tex.rgb = vec3(0.0,0.0,0.0);
    }

    tex.rgb = mix(tex.rgb,flixel_texture2D(bitmap,uv).rgb,1.0 - ratio);

    if (tex.rgba == vec4(0.0,0.0,0.0,0.0)) discard;
    else gl_FragColor = tex;
}