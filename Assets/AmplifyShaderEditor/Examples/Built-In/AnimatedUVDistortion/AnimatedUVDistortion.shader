// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/AnimatedUVDistort"
{
	Properties
	{
		_MainTexture("Main Texture", 2D) = "white" {}
		_DistortTexture("Distort Texture", 2D) = "bump" {}
		[HDR]_TintColor("Tint Color", Color) = (1,0.4196078,0,1)
		_Speed("Speed", Float) = 9
		_UVDistortIntensity("UV Distort Intensity", Range( 0 , 0.04)) = 0.04
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float4 _TintColor;
		uniform sampler2D _MainTexture;
		uniform float _Speed;
		uniform sampler2D _DistortTexture;
		uniform float4 _DistortTexture_ST;
		uniform float _UVDistortIntensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime10 = _Time.y * _Speed;
			float2 panner11 = ( mulTime10 * float2( -1,-1 ) + float2( 0,0 ));
			float2 uv_TexCoord9 = v.texcoord.xy + panner11;
			float2 uv_DistortTexture = v.texcoord * _DistortTexture_ST.xy + _DistortTexture_ST.zw;
			float3 tex2DNode6 = UnpackScaleNormal( tex2Dlod( _DistortTexture, float4( uv_DistortTexture, 0, 0.0) ), _UVDistortIntensity );
			float mulTime15 = _Time.y * _Speed;
			float2 panner17 = ( mulTime15 * float2( 1,0.5 ) + float2( 0,0 ));
			float2 uv_TexCoord18 = v.texcoord.xy + panner17;
			v.vertex.xyz += ( _TintColor * ( tex2Dlod( _MainTexture, float4( ( float3( uv_TexCoord9 ,  0.0 ) + tex2DNode6 ).xy, 0, 0.0) ) * tex2Dlod( _MainTexture, float4( ( float3( uv_TexCoord18 ,  0.0 ) + tex2DNode6 ).xy, 0, 0.0) ) ) ).rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
1167;73;752;926;2478.225;562.2499;1.691017;False;False
Node;AmplifyShaderEditor.RangedFloatNode;23;-2400.123,58.86468;Float;False;Property;_Speed;Speed;3;0;Create;True;0;0;0;False;0;False;9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-1722.107,490.1429;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-1643.784,-111.7641;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;11;-1449.904,-251.4571;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-1,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;17;-1493.972,362.5278;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1916.708,106.293;Float;False;Property;_UVDistortIntensity;UV Distort Intensity;4;0;Create;True;0;0;0;False;0;False;0.04;0;0;0.04;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1225.597,-252.8895;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1272.574,354.2421;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1558.098,90.11827;Inherit;True;Property;_DistortTexture;Distort Texture;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-978.4656,-159.0065;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1013.526,448.6211;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-856.8282,-182.0895;Inherit;True;Property;_MainTexture;Main Texture;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-850.0068,1.76078;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-851.9389,-413.8653;Float;False;Property;_TintColor;Tint Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,0.4196078,0,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-530.4052,-105.6451;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-301.6053,-187.0681;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;267.9615,-227.9616;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;ASESampleShaders/AnimatedUVDistort;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;23;0
WireConnection;10;0;23;0
WireConnection;11;1;10;0
WireConnection;17;1;15;0
WireConnection;9;1;11;0
WireConnection;18;1;17;0
WireConnection;6;5;13;0
WireConnection;12;0;9;0
WireConnection;12;1;6;0
WireConnection;19;0;18;0
WireConnection;19;1;6;0
WireConnection;1;1;12;0
WireConnection;14;1;19;0
WireConnection;8;0;1;0
WireConnection;8;1;14;0
WireConnection;20;0;7;0
WireConnection;20;1;8;0
WireConnection;0;11;20;0
ASEEND*/
//CHKSM=62A76779E5872CC90886B69EA02C5D2EE421724D