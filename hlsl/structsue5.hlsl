struct Distance
{
    float distance(float3 p)
    {
        float dist;
        return dist;
    }

    float3 calcNormal(float3 p)
    {
        float2 eps = (0.001, 0);
        float d0 = distance(p);
        float3 d1 = float3( distance(p - eps.xyy),
                            distance(p - eps.yxy),
                            distance(p - eps.yyx));

        return normalize(d0 - d1);
    }
};
