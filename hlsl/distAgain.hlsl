struct sdShapes 
{  
    float3 sdTorus(float3 pos, float size, float cutout)
    {
        float2 q = float2(length(pos.xz) - size, pos.y);
        return length(q) - cutout;
    }
    
    float2 sdBox(float3 pos, float3 size)
    {
        float3 q = abs(pos) - size;
        return length(max(q, 0.0)) + min(max(q.x, max(q.y, q.z)), 0.0);
    }

    float3 sdSphere(float3 pos, float size)
    {
        return length(pos) - size;
    }  
};

sdShapes torus;

float dist = torus.