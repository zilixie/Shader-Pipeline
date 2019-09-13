// Generate a procedural planet and orbiting moon. Use layers of (improved)
// Perlin noise to generate planetary features such as vegetation, gaseous
// clouds, mountains, valleys, ice caps, rivers, oceans. Don't forget about the
// moon. Use `animation_seconds` in your noise input to create (periodic)
// temporal effects.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
out vec3 color;
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{
  mat3 bump = mat3(5,0,0,
                   0,5,0,
                   0,0,5);

  mat3 texture = mat3(9,0,0,
                      0,9,0,
                      0,0,9);
  mat3 texture2 = mat3(2,0,0,
                      0,2,0,
                      0,0,2);

  vec3 bi_norm = vec3(0,0,0);
  vec3 tang = vec3(0,0,0);
  tangent(normal_fs_in, tang, bi_norm);

  float eps = 0.0001;
  vec3 new_n = cross((bump_position(is_moon, bump*sphere_fs_in + eps*tang)
                    - bump_position(is_moon, bump*sphere_fs_in))/eps,
                     (bump_position(is_moon, bump*sphere_fs_in + eps*bi_norm)
                    - bump_position(is_moon, bump*sphere_fs_in))/eps);

  new_n = normalize(new_n);

  vec3 texture_sphere = texture * sphere_fs_in;
  vec3 texture_sphere2 = texture2 * sphere_fs_in;
  float noise = improved_perlin_noise(texture_sphere) + 0.5;
  float noise2 = improved_perlin_noise(texture_sphere2) + 0.5;

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

  vec3 tmp_color = vec3(0,0,0);

  if (is_moon) {
    color = blinn_phong(ka, noise2 + kd_moon, ks, 2, new_n, v, l);
  }
  else {
    //15*sin(3x) + sin(45x)
    if (noise2 > 0) {
      color = blinn_phong(ka, vec3(0.68,1,0.18), ks, 20000, new_n, v, l);
    }
    else {
      color = blinn_phong(ka, vec3(0,0.75,1), ks, 200, new_n, v, l);
    }
  }
}
