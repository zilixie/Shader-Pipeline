// Construct the model transformation matrix. The moon should orbit around the
// origin. The other object should stay still.
//
// Inputs:
//   is_moon  whether we're considering the moon
//   time  seconds on animation clock
// Returns affine model transformation as 4x4 matrix
//
// expects: identity, rotate_about_y, translate, PI

mat4 model(bool is_moon, float time)
{
  if (is_moon) {
    float theta = M_PI * time * 0.5;
    mat4 m_r = rotate_about_y(theta);
    mat4 m_t = translate(vec3(2,0,0));
    mat4 m_s = uniform_scale(0.3);

    return m_r * m_t * m_s;
  }
  else {
    return identity();
  }
}
