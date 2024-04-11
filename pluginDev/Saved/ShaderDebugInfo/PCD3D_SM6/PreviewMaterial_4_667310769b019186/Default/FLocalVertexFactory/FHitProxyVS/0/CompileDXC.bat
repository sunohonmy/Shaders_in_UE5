@ECHO OFF
SET DXC="C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\ThirdParty\ShaderConductor\Win64\dxc.exe"
IF NOT EXIST %DXC% (
	ECHO Couldn't find dxc.exe under "C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\ThirdParty\ShaderConductor\Win64"
	GOTO :END
)
%DXC% -Zpr -O3 -auto-binding-space 0 -Wno-parentheses-equality -disable-lifetime-markers -T vs_6_6 -E Main -Fc HitProxyVertexShader.d3dasm -Fo HitProxyVertexShader.dxil HitProxyVertexShader
:END
PAUSE
