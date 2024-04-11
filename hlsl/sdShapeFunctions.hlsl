float sdSphere( float3 p, float s )
{
  return length(p)-s;
}

float sdPlane(float3 p)
{
  return 1;
}