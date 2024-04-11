float3 rayOrigin = 1 - (viewDir - worldPos);

//Sphere
float d0 = length(pos) - size;

//Box
float3 q3 = abs(pos - float3(50, 0, 0)) - float3(size, size, size);
float d1 = length(max(q3, 0.0)) + min(max(q3.x, max(q3.y, q3.z)), 0.0);

//Torus
float3 tPos = pos - float3(-50, 0, 0);
float2 q2 = float2(length(tPos.xz) - size, tPos.y);
float d2 = length(q2) - 25;

float dmin1 = min(d0, d1);
float d = min(dmin1, d);

return d;