shader_type spatial;
render_mode world_vertex_coords;

const int num_of_positions = 10;
uniform vec4 positions[num_of_positions];
uniform float border_thickness = 0.1;
uniform float scale_offset = 0.0;
uniform float smooth_minimum_blend = 0.5;

uniform vec3 border_color : source_color = vec3(0.0);
uniform float border_alpha : hint_range(0.0,1.0) = 1.0;
uniform vec3 map_color : source_color = vec3(1.0);
uniform float map_alpha : hint_range(0.0,1.0) = 1.0;

const float UV_scale = 0.1;



//const colors
const vec3 black = vec3(0.0,0.0,0.0);
const vec3 white = vec3(1.0,1.0,1.0);

//Returns the distance between point P to the edge of circle C
//If the value returns less than zero, then we know that a specific position P is inside the circle C
//This function literally DEFINES our circles
float signed_dist_circ(vec2 p, vec2 c, float radius) {
	return sqrt(
		pow(p.x - c.x,2) +
		pow(p.y - c.y, 2)
	) - radius;
}

//This function performs the union action on two SDF shapes
float opSmoothUnion( float d1, float d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

void fragment() {
	//credit for path to solution: clepirelli 
	//https://www.shadertoy.com/view/3t23DG
	//The trick was to union between the SDF shapes themselves, and not blend between the distances
	
	
	float major_sdf, minor_sdf;
	//Initialize the major and minor sdf shapes
	//The major sdf is the black circle around each position. Its solid black.
	//The minor sdf is a white circle around each position, that's smaller than the black circle.
	//The minor sdf overwrites the major sdf, effectively "cutting out" the interior of the shape
	//which makes the hollow border effect.
	major_sdf = opSmoothUnion(signed_dist_circ(UV.xy / UV_scale, positions[0].xz + scale_offset, positions[0].w),signed_dist_circ(UV.xy / UV_scale, positions[1].xz + scale_offset, positions[1].w), smooth_minimum_blend);
	minor_sdf = opSmoothUnion(signed_dist_circ(UV.xy / UV_scale, positions[0].xz + scale_offset, positions[0].w - border_thickness),signed_dist_circ(UV.xy / UV_scale, positions[1].xz + scale_offset, positions[1].w - border_thickness), smooth_minimum_blend);
	//We want to blend all possible SDFs. Most examples I found hardcoded two,
	//but this will cover as many as needed.
	for (int i = 2; i < num_of_positions; i++) {
		//Because of how arrays in shaders work, num_of_positions has to be a constant instead of a uniform.
		//So num_of_positions will almost always be larger or smaller than the actual num of positions.
		//So num_of_positions will be set to a larger than needed number, but since no objects will almost ever be at EXACTLY (0,0)
		//We can safely ignore those positions at the origin (0,0).
		if (positions[i].xyz != vec3(0.0)) {
			major_sdf = opSmoothUnion(major_sdf, signed_dist_circ(UV.xy / UV_scale, positions[i].xz + scale_offset, positions[i].w), smooth_minimum_blend);
			minor_sdf = opSmoothUnion(minor_sdf, signed_dist_circ(UV.xy / UV_scale, positions[i].xz + scale_offset, positions[i].w - border_thickness), smooth_minimum_blend);
		}
	}
	
	//Set the default color of the current UV coordinate.
	vec3 col = map_color;
	float alpha = map_alpha;
	//If the current UV coordinate is within the major sdf, set to black.
	if (major_sdf <= 0.0 && minor_sdf > 0.0) {
		col = border_color;
		alpha = border_alpha;
	}
	//If the current UV is within the minjor sdf, we overwrite and set back to white.
	//if (minor_sdf < 0.0) {
		//col = white;
	//}
	ALBEDO = col;
	ALPHA = alpha;
}