// Generate a pseudorandom unit 3D vector
// 
// Inputs:
//   seed  3D seed
// Returns psuedorandom, unit 3D vector drawn from uniform distribution over
// the unit sphere (assuming random2 is uniform over [0,1]²).
//
// expects: random2.glsl, PI.glsl
vec3 random_direction( vec3 seed)
{
  /*
  vec2 alpha_beta = random2(seed);
  float alpha = alpha_beta.x * 2 * M_PI * 100;
  float beta = alpha_beta.y * 2 * M_PI * 100;

  float z = sin(beta);
  float w = cos(beta);
  float x = w * cos(alpha);
  float y = w * sin(alpha);
  */

  vec2 uv = random2(seed);
  float theta = uv.x * 2 * M_PI;
  float r = 0;
  if (uv.y > 0.5) {
    r = (uv.y - 1) * 2;
  }
  if (uv.y < 0.5) {
    r = (uv.y * 2) - 1;
  }
  if (uv.y == 0.5) {
    r = 0;
  }
  float x = sqrt(1 - r*r) * cos(theta);
  float y = sqrt(1 - r*r) * sin(theta);
  float z = r;

  return vec3(x,y,z);
}
