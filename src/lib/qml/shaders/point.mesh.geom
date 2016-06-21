#version 450

#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (points) in;
layout (points, max_vertices = 1) out;

layout (binding = 1) uniform UBO 
{
	mat4 projection;
	mat4 model;
        int mode;
} ubo;

layout (location = 0) in vec3 inColor[];
layout (location = 1) in ivec4 inId[];
layout (location = 2) in int inPoint[];

layout (location = 0) out vec3 outColor;
layout (location = 1) out ivec4 outId;
layout (location = 2) out int outPoint;

void main() 
{
    float pointSize = 10.0;

    vec3 p0 = gl_in[0].gl_Position.xyz;
    //vec3 p1 = gl_in[1].gl_Position.xyz;

    // p0
    gl_Position = ubo.projection * (ubo.model * vec4(p0, 1.0));
    gl_PointSize = pointSize;
    outColor = vec3(0.0, 1.0, 0.0);
    outId = inId[0];
    outPoint = inPoint[0];
    EmitVertex();

    EndPrimitive();

    /* 
    int draw =  ubo.mode & 0x0001;
    if(draw>0)
    {
        // p0
        gl_Position = ubo.projection * (ubo.model * vec4(p0, 1.0));
        gl_PointSize = pointSize;
        outColor = vec3(0.0, 1.0, 0.0);
        outId = inId[0];
        outPoint = inPoint[0];
        EmitVertex();

        // p1
        gl_Position = ubo.projection * (ubo.model * vec4(p1, 1.0));
        gl_PointSize = pointSize;
        outColor = vec3(0.0, 1.0, 0.0);
        outId = inId[1];
        outPoint = inPoint[1];
        EmitVertex();

        EndPrimitive();
    }
    */
}
