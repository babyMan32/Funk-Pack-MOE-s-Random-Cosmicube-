#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform vec4 iMouse;

vec2 getDistortion(vec2 uv, float d, float t) {
	uv.x += cos(d) + t * 0.9;
	uv.y += sin(d + t * 0.75);
	return uv;
}

vec4 getDistortedTexture(sampler2D iChanne0, vec2 uv) {
	vec4 rgb = texture(iChanne0, uv);
	return rgb;
}

void mainImage()
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float t = iTime;
	vec2 mid = vec2(0.5,0.5);
	vec2 focus = iMouse.xy / iResolution.xy;
	float d1 = distance(focus+sin(t * 0.25) * 0.5,uv);	
	float d2 = distance(focus
						+cos(t),uv);	
	vec4 rgb = (getDistortedTexture(iChannel0, getDistortion(uv, d1, t)) + getDistortedTexture(iChannel0, getDistortion(uv, -d2, t))) * 0.5;
	rgb.r /= d2;
	rgb.g += -0.5 + d1;
	rgb.b = -0.5 + (d1 + d2) / 2.0;
	fragColor = rgb;
}