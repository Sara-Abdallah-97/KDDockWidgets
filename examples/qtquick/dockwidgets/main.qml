/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2020 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sergio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts
import com.kdab.dockwidgets 2.0 as KDDW

ApplicationWindow {
    visible: true
    width: 1000
    height: 800

    RowLayout {

        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            KDDW.DockingArea {
                id: dockingArea1
                anchors.fill: parent

                uniqueName: "MainLayout-1"

                KDDW.DockWidget {
                    id: dock4
                    uniqueName: "dockingArea1_dock4"
                    source: ":/Another.qml"
                }

                KDDW.DockWidget {
                    id: dock5
                    uniqueName: "dockingArea1_dock5"
                    Rectangle {
                        id: guest
                        color: "#2E8BC0"
                        anchors.fill: parent
                    }
                }

                KDDW.DockWidget {
                    id: dock6
                    uniqueName: "dockingArea1_dock6"
                    Rectangle {
                        color: "#145DA0"
                        anchors.fill: parent
                    }
                }

                Component.onCompleted: {
                    dockingArea1.addDockWidget(dock4, KDDW.KDDockWidgets.Location_OnBottom);
                    dockingArea1.addDockWidget(dock5, KDDW.KDDockWidgets.Location_OnRight, dock4);
                    dock5.addDockWidgetAsTab(dock6);
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            KDDW.DockingArea {
                id: dockingArea2

                anchors.fill: parent

                // Each main layout needs a unique id
                uniqueName: "MainLayout-2"

                KDDW.DockWidget {
                    id: dockingArea2_Dock1
                    uniqueName: "dockingArea2_Dock1"
                    source: ":/Another.qml"
                }

                KDDW.DockWidget {
                    id: dockingArea2_Dock2
                    uniqueName: "dockingArea2_Dock2"
                    source: ":/Another.qml"
                }

                Component.onCompleted: {
                    dockingArea2.addDockWidget(dockingArea2_Dock1, KDDW.KDDockWidgets.Location_OnBottom);
                    dockingArea2_Dock1.addDockWidgetAsTab(dockingArea2_Dock2);
                }

            }
        }
    }

}
