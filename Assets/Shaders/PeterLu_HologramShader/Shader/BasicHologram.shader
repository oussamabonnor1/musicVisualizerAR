Shader "Custom/BasicHologram" {
	Properties {
		[Header(Holo Section)]
		_Color ("Base Color", Color) = (1,1,1,1)
		_HoloColor("Holo Color", Color) = (1,1,1,1)
		_HoloValue ("Holo Value", Range(0, 10)) = 1
		_HoloDistance ("Holo Distance", Range(0,1)) = 0.5
		_HoloDirection("Holo Direction", Vector) = (0,1,0,0)
		_EmissionMultiplier("Emission Multiplier", Float) = 1

		[Space(50)]
		[Header(Glitch Section)]
		_GlitchStrength("Glitch Strength", Range(0,0.1)) = 0
		_GlitchDensity("Glitch Density", Float) = 0
		_GlitchPeriod("GlitchPeriod", Float) = 0
		_GlitchDirection("Glitch Direction", Vector) = (0,1,0,0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Transparent" }
		LOD 200

		Cull Off

		CGPROGRAM

		#pragma surface surf PeterLu vertex:vert alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
			float2 uv_NoiseMap;
			float3 viewDir;
			float3 worldPos;
		};

		sampler2D _NoiseMap;
		float _HoloValue;
		float _HoloDistance;
		float _EmissionMultiplier;
		float _GlitchStrength;
		float _GlitchDensity;
		float _GlitchPeriod;
		float4 _GlitchDirection;
		float4 _HoloDirection;
		fixed4 _Color;
		fixed4 _HoloColor;

          half4 LightingPeterLu (SurfaceOutput s, half3 lightDir, half atten) {
              half4 c;
              c.rgb = s.Albedo;
              c.a = s.Alpha;
              return c;
          }

		void vert(inout appdata_full v, out Input o)    
        {    
			UNITY_INITIALIZE_OUTPUT(Input,o)
            v.vertex.y += sin(_GlitchPeriod * _Time.y + v.vertex.x * _GlitchDensity)*_GlitchStrength * _GlitchDirection.y;
			v.vertex.x += sin(_GlitchPeriod * _Time.y + v.vertex.y * _GlitchDensity)*_GlitchStrength * _GlitchDirection.x;
			v.vertex.z += sin(_GlitchPeriod * _Time.y + v.vertex.z * _GlitchDensity)*_GlitchStrength * _GlitchDirection.z;
		}

		void surf (Input IN, inout SurfaceOutput o) 
		{
			float finalP = IN.worldPos.x * _HoloDirection.x + IN.worldPos.y * _HoloDirection.y + IN.worldPos.z * _HoloDirection.z;
			if(frac((finalP + _Time.y) * _HoloValue) > _HoloDistance)
			{
				o.Emission = _HoloColor;
				o.Alpha = _HoloColor.a;
			}
			else
			{
				o.Emission = _Color;
				o.Alpha = _Color.a;
			}

			o.Emission *= _EmissionMultiplier;
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
