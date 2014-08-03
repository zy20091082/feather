// =====================================================================================
// 
//       Filename:  commands.cpp
// 
//    Description:  
// 
//        Version:  1.0
//        Created:  08/02/2014 09:47:41 PM
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Richard Layman (), rlayman2000@yahoo.com
//        Company:  
// 
// =====================================================================================
#include "commands.hpp"
#include "polygon_mesh.hpp"
#include "scenegraph.hpp"

using namespace feather;
using namespace feather::qml;

status command::make_cube() {
    std::cout << "make cube\n";
   // create a sgNode
    scenegraph::sgNode sgnode(1,node::PolygonMesh);
    scenegraph::SceneGraphSingleton::Instance()->push_back(sgnode);
    scenegraph::update();
    return status();
}

