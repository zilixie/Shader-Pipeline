// Set the pixel color to an interesting procedural color generated by mixing
// and filtering Perlin noise of different frequencies.
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

// expects: blinn_phong, perlin_noise
void main()
{
  mat3 texture = mat3(5,0,0,
                      0,5,0,
                      0,0,5);
  vec3 texture_sphere = texture * sphere_fs_in;
  float noise = (perlin_noise(texture_sphere) + 1)/2;
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
    color = blinn_phong(ka, noise + kd_moon, ks, p, n, v, l);
  }
  else {
    color = blinn_phong(ka, noise + kd_earth, ks, p, n, v, l);
  }
}
