// Given a 3d position as a seed, compute an even smoother procedural noise
// value. "Improving Noise" [Perlin 2002].
//
// Inputs:
//   st  3D seed
// Values between  -½ and ½ ?
//
// expects: random_direction, improved_smooth_step
float improved_perlin_noise( vec3 st) 
{
  vec3 a = vec3(floor(st.x), floor(st.y), floor(st.z));
  vec3 b = vec3(ceil(st.x), floor(st.y), floor(st.z));
  vec3 c = vec3(ceil(st.x), ceil(st.y), floor(st.z));
  vec3 d = vec3(floor(st.x), ceil(st.y), floor(st.z));
  vec3 e = vec3(floor(st.x), floor(st.y), ceil(st.z));
  vec3 f = vec3(ceil(st.x), floor(st.y), ceil(st.z));
  vec3 g = vec3(ceil(st.x), ceil(st.y), ceil(st.z));
  vec3 h = vec3(floor(st.x), ceil(st.y), ceil(st.z));

  vec3 a_dir = random_direction(a);
  vec3 b_dir = random_direction(b);
  vec3 c_dir = random_direction(c);
  vec3 d_dir = random_direction(d);
  vec3 e_dir = random_direction(e);
  vec3 f_dir = random_direction(f);
  vec3 g_dir = random_direction(g);
  vec3 h_dir = random_direction(h);

  vec3 a_seed = st - a;
  vec3 b_seed = st - b;
  vec3 c_seed = st - c;
  vec3 d_seed = st - d;
  vec3 e_seed = st - e;
  vec3 f_seed = st - f;
  vec3 g_seed = st - g;
  vec3 h_seed = st - h;

  float dot_a = a_dir.x * a_seed.x + a_dir.y * a_seed.y + a_dir.z * a_seed.z;
  float dot_b = b_dir.x * b_seed.x + b_dir.y * b_seed.y + b_dir.z * b_seed.z;
  float dot_c = c_dir.x * c_seed.x + c_dir.y * c_seed.y + c_dir.z * c_seed.z;
  float dot_d = d_dir.x * d_seed.x + d_dir.y * d_seed.y + d_dir.z * d_seed.z;
  float dot_e = e_dir.x * e_seed.x + e_dir.y * e_seed.y + e_dir.z * e_seed.z;
  float dot_f = f_dir.x * f_seed.x + f_dir.y * f_seed.y + f_dir.z * f_seed.z;
  float dot_g = g_dir.x * g_seed.x + g_dir.y * g_seed.y + g_dir.z * g_seed.z;
  float dot_h = h_dir.x * h_seed.x + h_dir.y * h_seed.y + h_dir.z * h_seed.z;

  float alpha_x = improved_smooth_step(a_seed.x);
  float alpha_y = improved_smooth_step(a_seed.y);
  float alpha_z = improved_smooth_step(a_seed.z);

  float ab = mix(dot_a, dot_b, alpha_x);
  float dc = mix(dot_d, dot_c, alpha_x);
  float ef = mix(dot_e, dot_f, alpha_x);
  float hg = mix(dot_h, dot_g, alpha_x);

  float abcd = mix(ab, dc, alpha_y);
  float efgh = mix(ef, hg, alpha_y);

  float abcdefgh = mix(abcd, efgh, alpha_z);

  return abcdefgh - 0.5;
}

