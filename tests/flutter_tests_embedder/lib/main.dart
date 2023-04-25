/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2023 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:developer';

import 'package:KDDockWidgets/DockWidget.dart';
import 'package:KDDockWidgets/DropArea.dart';
import 'package:KDDockWidgets/PositionedWidget.dart';
import 'package:flutter/material.dart';
import 'package:KDDockWidgetsBindings/Bindings_KDDWBindingsCore.dart'
    as KDDWBindingsCore;
import 'package:KDDockWidgetsBindings/Bindings_KDDWBindingsFlutter.dart'
    as KDDWBindingsFlutter;
import 'package:KDDockWidgets/WindowOverlayWidget.dart' as KDDW;
import 'package:flutter/scheduler.dart';
import 'package:KDDockWidgets/View.dart' as KDDW;
import 'package:KDDockWidgets/Platform.dart' as KDDW;
import 'package:KDDockWidgetsBindings/Bindings.dart' as KDDWBindings;

void main(List<String> args) {
  window.setIsolateDebugName("Main dart isolate");

  if (args.contains("--wait")) debugger();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late KDDWBindingsCore.DropArea dropArea;
  late Widget dropAreaWidget;

  _MyHomePageState() {
    var plat = KDDW.Platform();
    dropArea = KDDWBindingsCore.DropArea(null,
        KDDWBindings.KDDockWidgets_MainWindowOption.MainWindowOption_None);

    final dropAreaView =
        KDDWBindingsFlutter.View.fromCache(dropArea.view().thisCpp)
            as KDDW.View;

    KDDWBindingsCore.View.fromCppPointer(dropArea.view().thisCpp);
    dropAreaView.setObjectName("droparea");

    dropAreaView.m_fillsParent = true;
    dropAreaWidget = dropAreaView.flutterWidget;

    plat.runTests();
  }

  void _incrementCounter() {
    dropArea.dumpLayout();
    print("Layout out equally");
    dropArea.layoutEqually();
    print("Layout out equally done");
    dropArea.dumpLayout();
  }

  @override
  Widget build(BuildContext context) {
    final windowOverlay = KDDW.WindowOverlayWidget();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Stack(children: [dropAreaWidget, windowOverlay])),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
