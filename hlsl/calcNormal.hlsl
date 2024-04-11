float eps = 0.001;
float3 h = float2(1.0, -1.0);//*0.5773;
float3 normal = normalize(float3(   h.xyy*map(p + h.xyy*eps) +
                                    h.yyx*map(p + h.yyx*eps) + 
                                    h.yxy*map(p + h.yxy*eps) + 
                                    h.xxx*map(p + h.xxx*eps)));