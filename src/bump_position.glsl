// Create a bumpy surface by using procedural noise to generate a new 3D position
// via displacement in normal direction.
// 
// Inputs:
//   is_moon  whether we're looking at the moon or centre planet
//   s  3D position of seed for noise generation, also assumed to be surface
//     point on the unit spher (and thus also equal to its normal)
// Returns 3D position of p adjusted along n by bump amount
//
// Hint: for a unit sphere object, you might use s=p=n
//
// expects: bump_height
vec3 bump_position(bool is_moon , vec3 s)
{
  float noise = bump_height(is_moon, s);
  vec3 d = normalize(s);
  vec3 adjust = mat3(noise,0,0,
                     0,noise,0,
                     0,0,noise) * d;
  return s + adjust;
  //return s + bump_height(is_moon, s) * s;
}
