// Input:
//   N  3D unit normal vector
// Outputs:
//   T  3D unit tangent vector
//   B  3D unit tangent vector
void tangent(in vec3 N, out vec3 T, out vec3 B)
{
  //T = cross(N, vec3(0,0,1));
  float t_z = (-1) * (N.x + N.y)/N.z;
  T = vec3(1,1,t_z);
  B = cross(N, T);
}
