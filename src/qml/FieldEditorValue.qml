/***********************************************************************
 *
 * Filename: FieldEditorValue.qml 
 *
 * Description: Used to display values in the field editor. 
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

import QtQuick 2.3
import feather.field 1.0

Rectangle {
    id: intField
    height: 14
   
    property alias uId: field.uid // this is a unique of the node 
    property alias nodeKey: field.node // this if the node's number assigned by the plugin
    property alias fieldKey: field.field // this is the fields number assigned by the plugin
    //property alias label: label.text 
    property int fieldType: 0 
    property int value: field.intVal
    property Properties properties: Null
    property alias label: label.text

    Field { id: field }

    FieldPopup { id: popup }

    //Translation { id: name }


    // LABEL

    Text {
        id: label
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: valueBox.left
        anchors.margins: 4
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 10
        //text: name.get_field_name(nodeKey,fieldKey);
    }    
   
    // VALUE
 
    Rectangle {
        id: valueBox
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 80
        border.color: "black"
        border.width: 1

        Text {
            id: valueText
            text: value 
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: false 
            font.pixelSize: 10
        }
    } 


    states: [
        // NORMAL
        State {
            name: "normal"
            PropertyChanges {
                target: intField 
                color: typeNormalStateColor() //"lightgrey"
            }

            PropertyChanges {
                target: label 
                color: "black"
                font.bold: false
            }
 
            PropertyChanges {
                target: valueBox
                color: (field.connected) ? "deeppink" : "lightblue"
            }

            PropertyChanges {
                target: valueText
                color: "black"
                font.bold: false
            }
        },

        // HOVER
        State {
            name: "hover"
            PropertyChanges {
                target: intField 
                color: "lightblue"
            }

            PropertyChanges {
                target: label 
                color: "black"
                font.bold: true 
            }

            PropertyChanges {
                target: valueBox
                color: "midnightblue"
            }

            PropertyChanges {
                target: valueText
                color: "white"
                 font.bold: true 
            }
        },

        // PRESSED  
        State {
            name: "pressed"
            PropertyChanges {
                target: intField 
                color: "green"
            }

            PropertyChanges {
                target: label 
                color: "black"
                font.bold: true 
            }

            PropertyChanges {
                target: valueBox
                color: "limegreen"
            }

            PropertyChanges {
                target: valueText
                color: "black"
                font.bold: true 
            }
        }

    ]


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true 
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onPressed: {
            if(mouse.button == Qt.RightButton)
                popup.popup()

            intField.state="pressed"
            intField.update()
        }

        //onPositionChanged: { }
        onReleased: { intField.state="normal" }
        onEntered: { intField.state="hover" }
        onExited: { intField.state="normal" }
        onWheel: { field.intVal = field.intVal+1 }
    }

    Component.onCompleted: { intField.state="normal" }

    function typeNormalStateColor(t) {
        console.log("field type=" + intField.fieldType)
        switch(intField.fieldType) {
            case Field.Bool || Field.BoolArray: return properties.getColor("boolType"); break;
            case Field.Int || Field.IntArray: return properties.getColor("intType"); break;
            case Field.Float || Field.FloatArray: return properties.getColor("floatType"); break;
            case Field.Double || Field.DoubleArray: return properties.getColor("doubleType"); break;
            case Field.Vertex || Field.VertexArray: return properties.getColor("vertexType"); break;
            case Field.Vector || Field.VectorArray: return properties.getColor("vertexType"); break;
            case Field.Mesh: return properties.getColor("meshType"); break;
            case Field.RGB || Field.RGBA: return properties.getColor("rgbType"); break;
            default: return "white";
        }
    }
}
