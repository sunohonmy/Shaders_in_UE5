//calcDistance
float dist = length(rayORigin) - size;

return dist;

//rayMarch
for(int i = 0; i < MAX_STEPS; i++)
{
    float finalDist = 0;
    finalDist += dist;
    if(finalDist < 0.01)
    {
        float diffuse = max(dot(normal, lightDirection), 0);
        float3 reflection = reflect(lightDirection, normal);
        float3 viewDirection = normalize(-worldPos - rayOrigin);
        float specular = pow(max(dot(reflection, viewDirection), 0), 16);

        return (diffuse * float3(1, 0, 0)) + (specular * float3(1, 1, 1));
    }
    opacityMask = 1;
    rayOrigin +=rayDirection;
    outDist = dist;
}

opacityMask = 0;
return float3(0, 0, 0);

//Position
float eps = 0.001;
float3 p = rayOrigin;
float3 positivePosx = rayOrigin + float3(eps, 0, 0);
float3 positivePosy = rayOrigin + float3(0, eps, 0);
float3 positivePosz = rayOrigin + float3(0, 0, eps);
float3 negativePosx = rayOrigin - float3(eps, 0, 0);
float3 negativePosy = rayOrigin - float3(0, eps, 0);
float3 negativePosz = rayOrigin - float3(0, 0, eps);

//calcNormal
float3 normal = normalize(float3(normalx, normaly, normalz));

return normal;
