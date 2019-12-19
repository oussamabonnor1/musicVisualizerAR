Shader "Custom/Rim" {
	Properties {
		_Color ("Color", Color) = (0,0,0,0)
		_RimPower ("Rim Power", Range(0,5)) = 0
		_RimColor ("Rim Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		LOD 200
		Cull Back


		CGPROGRAM

		#pragma surface surf Standard alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
			float3 worldPos;
		};

		float _RimPower;
		fixed4 _RimColor;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			o.Albedo = _Color;
			float dotP = 1 - saturate(dot( normalize(IN.viewDir), normalize(o.Normal)));
			o.Emission = pow(dotP, _RimPower) * _RimColor;
			o.Alpha = pow(dotP, _RimPower) + _Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
