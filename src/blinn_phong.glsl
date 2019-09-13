// Compute Blinn-Phong Shading given a material specification, a point on a
// surface and a light direction. Assume the light is white and has a low
// ambient intensity.
//
// Inputs:
//   ka  rgb ambient color
//   kd  rgb diffuse color
//   ks  rgb specular color
//   p  specular exponent (shininess)
//   n  unit surface normal direction
//   v  unit view direction
//   l  unit light direction
// Returns rgb color
vec3 blinn_phong(
  vec3 ka,
  vec3 kd,
  vec3 ks,
  float p,
  vec3 n,
  vec3 v,
  vec3 l)
{
  vec3 I = vec3(1,1,1);
  float factor = max(n.x * l.x + n.y * l.y + n.z * l.z, 0);
  vec3 diffuse = factor * I * kd;

  vec3 h = normalize(v + l);
  factor = pow(max((n.x * h.x + n.y * h.y + n.z * h.z), 0), p);
  vec3 specular = factor * I * ks;

  vec3 ambient = ka;
  return ambient + diffuse + specular;

}


