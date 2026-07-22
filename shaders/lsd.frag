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


#define PI 3.141592653
#define PI2 2.0*PI
#define EXP2PII(t) vec2(cos(PI2*t), sin(PI2*t))

vec4 colorWheel(in vec2 pos)
{
    float magn = length(pos);
    
    if (magn == 0.0) return vec4(0.0);
    
    float angle = acos(dot(pos, vec2(1.0, 0.0))/magn);
    
    vec3 rgb = clamp(abs(mod(angle*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0);

    return vec4(magn * (rgb-0.1), 0.0);
}

void mainImage()
{
    const float speed = 1.;
    float time = speed * iTime + 100.;
    
	vec2 uv = fragCoord/iResolution.xy;
    
    vec4 color = texture(iChannel0, uv);
    
    vec2 offset = vec2(0.);
    
    const int m = 62;
    for (int n = 0; n < m; n++)
    {
		vec2 testOffset = .02*EXP2PII(float(n) / float(m));
        vec4 testColor = texture(iChannel0, uv+testOffset);
        testColor /= float(m);
        
        float l = 1./sqrt(3.)*length(testColor);
        
        offset += l * testOffset;
    }
    
    vec2 warp = vec2(sin(.94*time+9.*uv.x+4.), cos(.7*time+16.*uv.y));
    vec2 uvOffset = 10.*warp*offset-.01*warp;
    
	fragColor = texture(iChannel0, uv+uvOffset)+colorWheel(100.*offset);
}
