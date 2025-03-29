#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 pdbfrrep;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

bool is_in_rotated_sprite(vec2 uv) {
    float angle = -0.785398;
    mat2 rot = mat2(cos(angle), -sin(angle),
                sin(angle), cos(angle));
    
    vec2 rotated_uv = rot * (uv - 0.5) + 0.5;
    
    return rotated_uv.x >= 0.0 && rotated_uv.x <= 1.0 && 
           rotated_uv.y >= 0.0 && rotated_uv.y <= 1.0;
}

vec3 round_to_palette(vec3 color) {
    const vec3[17] palette = vec3[17](
        vec3(0.3765, 0.2824, 0.6392), 
        vec3(0.4235, 0.3333, 0.7020),  
        vec3(0.4706, 0.3843, 0.7647), 
        vec3(0.5569, 0.4510, 0.8510), 
        vec3(0.3333, 0.3098, 0.4000),  
        vec3(0.4118, 0.3882, 0.5020),  
        vec3(0.4902, 0.4667, 0.6039), 
        vec3(0.5804, 0.5490, 0.7020),
        vec3(0.6706, 0.6314, 0.8000), 
        vec3(0.7608, 0.7137, 0.8980),  
        vec3(0.7961, 0.7216, 1.0000), 
        vec3(0.8471, 0.8118, 1.0000), 
        vec3(0.8980, 0.9020, 1.0000), 
        vec3(0.9490, 0.9529, 1.0000),  
        vec3(0.9725, 0.9608, 1.0000), 
        vec3(0.9843, 0.9765, 1.0000), 
        vec3(0.2471, 0.1647, 0.4784)
    );
    
    float min_dist = 999.9;
    int index = 0;
    
    for(int i = 0; i < 17; i++) {
        float dist = 0.4*abs(color.r - palette[i].r) 
           + 0.7*abs(color.g - palette[i].g) 
           + 0.1*abs(color.b - palette[i].b);
        if(dist < min_dist) {
            min_dist = dist;
            index = i;
        }
    }
    return palette[index];
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv) {
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 1.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
    
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = 0.001 * (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = 0.001 * vec2(0.2, 0.8);

    float res = 0.001 * (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

vec4 HSL_to_RGB(vec4 c) {
    if(c.y < 0.0001) return vec4(vec3(c.z), c.a);
    
    float t = (c.z < 0.5) ? c.y*c.z + c.z : -c.y*c.z + (c.y + c.z);
    float s = 2.0 * c.z - t;
    
    float h = mod(c.x, 1.0) * 6.0;
    float hs = floor(h);
    float f = h - hs;
    
    vec3 rgb;
    if(hs < 1.0) rgb = vec3(t, mix(s, t, f), s);
    else if(hs < 2.0) rgb = vec3(mix(t, s, f), t, s);
    else if(hs < 3.0) rgb = vec3(s, t, mix(s, t, f));
    else if(hs < 4.0) rgb = vec3(s, mix(t, s, f), t);
    else if(hs < 5.0) rgb = vec3(mix(s, t, f), s, t);
    else rgb = vec3(t, s, mix(s, t, f));
    
    return vec4(rgb, c.w);
}

vec4 RGB_to_HSL(vec4 c) {
    float low = min(c.r, min(c.g, c.b));
    float high = max(c.r, max(c.g, c.b));
    float delta = high - low;
    
    vec4 hsl = vec4(0.0, 0.0, 0.5*(high + low), c.a);
    if(delta < 0.0001) return hsl;
    
    hsl.y = (hsl.z < 0.5) ? delta/(high + low) : delta/(2.0 - high - low);
    
    if(high == c.r) hsl.x = (c.g - c.b)/delta + (c.g < c.b ? 6.0 : 0.0);
    else if(high == c.g) hsl.x = (c.b - c.r)/delta + 2.0;
    else hsl.x = (c.r - c.g)/delta + 4.0;
    
    hsl.x /= 6.0;
    return hsl;
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = ((texture_coords*image_details) - texture_details.xy*texture_details.ba)/texture_details.ba;

    bool in_rotated = is_in_rotated_sprite(uv);

    vec4 hsl = RGB_to_HSL(tex);
        
    if(pdbfrrep.g != 0.0) hsl.z = 1.0 - hsl.z;
    if(pdbfrrep.g != 0.0) hsl.z = 1.0 - hsl.z;
    tex = HSL_to_RGB(hsl) + vec4(0.3098, 0.3882, 0.4039, 0.0)*0.8;
    tex.rgb = round_to_palette(tex.rgb);
    if(tex.a < 0.7) tex.a /= 3.0;

    if (!in_rotated) {
        tex.rgb *= 0.9;
    }
    
    return dissolve_mask(tex*colour, texture_coords, uv);
}

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
} 
#endif