project(feather_qml)

SET(CMAKE_AUTOMOC ON)
SET(CMAKE_INCLUDE_CURRENT_DIR ON)

#SET(CMAKE_CXX_LINK_FLAGS "-lvulkan")
#SET(CMAKE_CXX_LINK_FLAGS "-lassimp")
#SET(CMAKE_CXX_LINK_FLAGS "-lxcb")

#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DVK_USE_PLATFORM_XCB_KHR")

#MESSAGE(STATUS ${VULKAN_LIB})

#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNOMINMAX -DVK_PROTOTYPES -D_USE_MATH_DEFINES")

#SET(CMAKE_AUTOMOC_RELAX_MODE ON)

ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS)

FIND_PACKAGE(Qt5Widgets REQUIRED)
FIND_PACKAGE(Qt5Qml REQUIRED)
FIND_PACKAGE(Qt5Quick REQUIRED)

#SET(QT_USE_QTOPENGL TRUE)

SET(feather_qml_SRCS
    # vulkan
    #tools.cpp
    #debug.cpp
    #node.cpp
    #axis.cpp
    #grid.cpp
    #mesh.cpp
    #pointlight.cpp
    #pipelines.cpp
    #viewport4.cpp
    
    # viewport
    #viewport3.cpp
    qml_status.cpp
    viewport.cpp

    # qml
    commands.cpp
    curves.cpp
    field_model.cpp
    layer_model.cpp
    tree_model.cpp
    sg_editor.cpp
    qml.cpp
)

SET_SOURCE_FILES_PROPERTIES(${feather_qml_SRCS}
 PROPERTIES
 COMPILE_FLAGS ${CMAKE_CXX_FLAGS} )


INCLUDE_DIRECTORIES(${feather_core_SOURCE_DIR}
    ${feather_plugin_SOURCE_DIR}
    ${Qt5Widgets_INCLUDE_DIRS}
    ${Qt5Qml_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
)

LINK_DIRECTORIES(${feather_core_BINARY_DIR}
    ${feather_plugin_BINARY_DIR}
)

LINK_LIBRARIES(feather_core feather_plugin)

ADD_DEFINITIONS(${Qt5Widgets_DEFINITIONS}
    ${Qt5Qml_DEFINITIONS}
    ${Qt5Quick_DEFINITIONS}
)

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Qml_EXECUTABLE_COMPILE_FLAGS}")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Quick_EXECUTABLE_COMPILE_FLAGS}")

ADD_LIBRARY(feather_qml SHARED ${feather_qml_SRCS})

QT5_USE_MODULES(feather_qml Widgets Qml Quick)

SET(feather_qml_LIBS
 ${BOOST_LIBRARIES}
 ${OPENGL_LIBRARIES}
 ${QT5Widgets_LIBRARIES}
 ${QT5Qml_LIBRARIES}
 ${QT5Quick_LIBRARIES}
)

TARGET_LINK_LIBRARIES(feather_qml ${feather_qml_LIBS})

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I/usr/include/boost")

SET_TARGET_PROPERTIES(feather_qml
    PROPERTIES
    CMAKE_CXX_STANDARD 14
    CMAKE_CXX_STANDARD_REQUIRED ON
)

SET_TARGET_PROPERTIES(feather_qml
    PROPERTIES
    VERSION 0.01
    SOVERSION 1
)

INSTALL(TARGETS feather_qml
    LIBRARY DESTINATION /usr/lib64/feather)

add_subdirectory(shaders)
