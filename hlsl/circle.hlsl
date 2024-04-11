uv = 2*uv - 1;
float circle = length(uv - p);
//circle = step(0.1, circle);

if(r >= 0)
{
    return circle >=r;
}
else
{
    return circle<=r;
}