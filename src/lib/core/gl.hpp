/***********************************************************************
 *
 * Filename: gl.hpp
 *
 * Description: Contains macros to simplify gl coding in plugins.
 *
 * Copyright (C) 2015 Richard Layman, rlayman2000@yahoo.com 
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***********************************************************************/

#ifndef GL_HPP
#define GL_HPP

#include "deps.hpp"
#include "types.hpp"
#include "status.hpp"

#define ADD_GL_FRAG_SHADER(__shader)\
    QOpenGLShader* frag = new QOpenGLShader(QOpenGLShader::Fragment);\
    frag->compileSourceFile(__shader);\
    info.program->addShader(frag);
 
#define ADD_GL_GEOM_SHADER(__shader)\
    QOpenGLShader* geom = new QOpenGLShader(QOpenGLShader::Geometry);\
    geom->compileSourceFile(__shader);\
    info.program->addShader(geom);
 
#define ADD_GL_VERT_SHADER(__shader)\
    QOpenGLShader* vert = new QOpenGLShader(QOpenGLShader::Vertex);\
    vert->compileSourceFile(__shader);\
    info.program->addShader(vert);

#define GL_INIT_FINISH()\
    info.program->link();\
    node.glVertex = info.program->attributeLocation("vertex");\
    node.glColor = info.program->attributeLocation("color");\
    node.glMatrix = info.program->uniformLocation("matrix");\
    node.glNormal = info.program->attributeLocation("normal");\
    node.glView = info.program->uniformLocation("modelview");\
    node.glSelected = info.program->uniformLocation("Selected");\
    node.glLayerColor = info.program->attributeLocation("LayerColor");\
    node.glLightPosition = info.program->attributeLocation("LightPosition");\
    node.glLightAmbient = info.program->attributeLocation("LightAmbient");\
    node.glLightDiffuse = info.program->attributeLocation("LightDiffuse");\
    node.glLightSpecular = info.program->attributeLocation("LightSpecular");\
    node.glMaterialAmbient = info.program->attributeLocation("MaterialAmbient");\
    node.glMaterialDiffuse = info.program->attributeLocation("MaterialDiffuse");\
    node.glMaterialSpecular = info.program->attributeLocation("MaterialSpecular");\
    node.glMaterialShininess = info.program->attributeLocation("MaterialShininess");\
    node.glCameraPosition = info.program->attributeLocation("CameraPosition");\
    node.glShaderDiffuse = info.program->attributeLocation("ShaderDiffuse");\

#endif
