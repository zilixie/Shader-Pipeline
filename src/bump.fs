// Set the pixel color using Blinn-Phong shading (e.g., with constant blue and
// gray material color) with a bumpy texture.
// 
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
//                     linearly interpolated from tessellation evaluation shader
//                     output
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
//               rgb color of this pixel
out vec3 color;
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{
  mat3 bump = mat3(5,0,0,
                   0,5,0,
                   0,0,5);

  vec3 bi_norm = vec3(0,0,0);
  vec3 tang = vec3(0,0,0);
  tangent(normal_fs_in, tang, bi_norm);

  float eps = 0.0001;
  vec3 new_n = cross((bump_position(is_moon, bump*sphere_fs_in + eps*tang)
                    - bump_position(is_moon, bump*sphere_fs_in))/eps,
                     (bump_position(is_moon, bump*sphere_fs_in + eps*bi_norm)
                    - bump_position(is_moon, bump*sphere_fs_in))/eps);

  new_n = normalize(new_n);

  float p = 2000;
  float theta = M_PI * animation_seconds * 0.1;
  vec3 I = vec3(1,1,1);
  vec3 l = vec3(sin(theta), 1, -cos(theta));
  vec3 v = -normalize(vec3(view_pos_fs_in));
  vec3 n = normalize(vec3(normal_fs_in));
  vec3 h = normalize(v+l);

  vec3 ka = vec3(0.02,0.05,0.08);
  vec3 ks = vec3(1,1,1);
  vec3 kd_earth = vec3(0.19,0.24,0.72);
  vec3 kd_moon = vec3(0.5,0.5,0.5);

  if (is_moon) {
    color = blinn_phong(ka, kd_moon, ks, p, new_n, v, l);
  }
  else {
    color = blinn_phong(ka, kd_earth, ks, p, new_n, v, l);
  }
}
