float3 rayOrigin = 1 - (viewDir - worldPos);
float3 rayStep = viewDir*-1;
float3 lightDirection = normalize(lPos);

struct sdShapes 
{  
    float3 sdDist(float3 pos, float size)
    {
        //Sphere
        float d0 = length(pos) - size;

        //Box
        float3 q3 = abs(pos - float3(150, 0, 0)) - float3(size, size, size);
        float d1 = length(max(q3, 0.0)) + min(max(q3.x, max(q3.y, q3.z)), 0.0);

        //Torus
        float3 tPos = pos - float3(-150, 0, 0);
        float2 q2 = float2(length(tPos.xz) - size, tPos.y);
        float d2 = length(q2) - 25;

        //Final distance
        float dmin1 = min(d0, d1);
        float d = min(dmin1, d2);

        return d;
    } 
};

sdShapes torus;
//ray marching loop
for(int i = 0; i < 512; i++)
{
    //get the distance
    float finalDist = torus.sdDist(rayOrigin, 50);
    //check for a hit on the surface
    if(finalDist < 0.01)
    {
        float eps = 0.001;

        //calculate the surface normal
        float normalx = torus.sdDist(rayOrigin + float3(eps, 0, 0), 50) - torus.sdDist(rayOrigin - float3(eps, 0, 0), 50);
        float normaly = torus.sdDist(rayOrigin + float3(0, eps, 0), 50) - torus.sdDist(rayOrigin - float3(0, eps, 0), 50);
        float normalz = torus.sdDist(rayOrigin + float3(0, 0, eps), 50) - torus.sdDist(rayOrigin - float3(0, 0, eps), 50);
        float3 normal = normalize(float3(normalx, normaly, normalz));
        
        //blinn-phong
        float diffuse = max(dot(normal, lightDirection), 0);
        float3 reflection = reflect(lightDirection, normal);
        float3 viewDirection = normalize(-worldPos - rayOrigin);
        float specular = pow(max(dot(reflection, viewDirection), 0), 16);

        return (diffuse * float3(1, 0, 0)) + (specular * float3(1, 1, 1));
    }
    //opacity around the shape
    opacityMask = 1;
    rayOrigin +=rayStep;
}
opacityMask = 0;
return float3(0, 0, 0);
