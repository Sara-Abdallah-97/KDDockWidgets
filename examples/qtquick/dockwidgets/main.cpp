/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2020 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sergio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/


#include <kddockwidgets/Config.h>
#include <kddockwidgets/core/DockRegistry.h>
#include <kddockwidgets/qtquick/ViewFactory.h>
#include <kddockwidgets/qtquick/Platform.h>
#include <kddockwidgets/qtquick/views/DockWidget.h>
#include <kddockwidgets/qtquick/views/MainWindow.h>

#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QCommandLineParser>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    KDDockWidgets::initFrontend(KDDockWidgets::FrontendType::QtQuick);

    // Create your engine which loads main.qml. A simple QQuickView would work too.
    QQmlApplicationEngine appEngine;

    KDDockWidgets::QtQuick::Platform::instance()->setQmlEngine(&appEngine);
    appEngine.load((QUrl("qrc:/main.qml")));

    return app.exec();
}
