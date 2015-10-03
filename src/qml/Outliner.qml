/***********************************************************************
 *
 * Filename: Outliner.qml 
 *
 * Description: Window that display the node tree. 
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

import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import feather.scenegraph 1.0

Item {
//Window {
    id: outliner
    //title: "Outliner"
    //visible: true
    //flags: Qt.Tool
    //width: 300
    //height: 600
    property SceneGraph scenegraph: Null
    property Properties properties: Null
   
    TreeModel { id: treeModel }

    Action {
        id: testAction 
        text: "TEST"
        onTriggered: {
            console.log("test feature")
            treeModel.test()
            tree.update()
        }
    }

    Rectangle {
        id: toolBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 36
        border.color: "black"
        border.width: 1
        color: properties.getColor("toolBarBg")

        Row {
            spacing: 4
            anchors.fill: parent
            anchors.margins: 2

            ToolButton {
                width: 32; height: 32
                //iconSource: "/usr/local/feather/ui/icons/layer_add.svg"
                iconName: "test"
                action: testAction 
            }

        }
    }

    TreeView {
        id: tree
        anchors.top: toolBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        TableViewColumn {
            title: "name"
            role: "name"
            width: tree.width-40
        }

        TableViewColumn {
            title: "visible"
            role: "visible"
            //width: 100
        }

        model: treeModel
        selection: ItemSelectionModel { model: treeModel }
        //selectionMode: SelectionMode.ContiguousSelection
        selectionMode: SelectionMode.SingleSelection
        sortIndicatorVisible: true
        headerVisible: false
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        style: OutlinerLeafNode {}
 
        //onActivated: { console.log("item activated " + model.data(index,260)); scenegraph.clear_selection(); scenegraph.select_node(model.data(index,260)) }
        onClicked: {
            if(!model)
                console.log("no model found")
            else {
                console.log("item clicked for index " + index + " model " + model.data(index,260))
                scenegraph.clear_selection()
                scenegraph.select_node(model.data(index,260))
            }
        }
   }

    function updateSg(){
        console.log("updateSg() model" + tree.model)
        tree.model.updateTree()
    } 

    function selectNode(uid){
        var index = tree.model.setCurrentNode(uid)
        //console.log("selected index:" + index)
        //tree.selection.clear()
        // this does work
        tree.selection.setCurrentIndex(index,Qt.ClearAndSelect)
        // this does not work for some reason
        //tree.selection.select(index,Qt.ClearAndSelect)
    }

    function clear(){
        tree.model.clearTree()
    }

    Component.onCompleted: {
        scenegraph.updateGraph.connect(updateSg)
        // when we only want to update the tree's selected node, not the scenegraph's
        scenegraph.nodeSelected.connect(selectNode)
        scenegraph.cleared.connect(clear)
    }
}
