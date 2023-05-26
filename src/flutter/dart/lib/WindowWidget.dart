/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2019-2023 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

import 'package:flutter/material.dart' hide View;
import 'package:flutter/widgets.dart';
import 'package:KDDockWidgets/View_mixin.dart';
import 'package:KDDockWidgetsBindings/Bindings_KDDWBindingsCore.dart'
    as KDDWBindingsCore;
import 'package:KDDockWidgetsBindings/Bindings_KDDWBindingsFlutter.dart'
    as KDDWBindingsFlutter;

import 'WindowOverlayWidget.dart';

/// @brief A Widget that hosts a single KDDW FloatingWindow or MainWindow
/// Since Flutter doesn't support real OS level multi-windows yet we need
/// to draw the windows ourselves
class WindowWidget extends StatefulWidget {
  late final View_mixin kddwView;
  WindowWidget(KDDWBindingsCore.View view)
      : super(key: GlobalObjectKey("WindowWidget-${view.thisCpp.address}")) {
    kddwView = KDDWBindingsFlutter.View.fromCache(view.thisCpp) as View_mixin;
  }

  @override
  State<StatefulWidget> createState() {
    return WindowWidgetState(kddwView);
  }
}

class WindowWidgetState extends State<WindowWidget> {
  late final View_mixin kddwView;
  WindowWidgetState(this.kddwView);

  void onGeometryChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final geo = kddwView.viewGeometry();
    final x = geo.x().toDouble();
    final y = geo.y().toDouble();
    final width = geo.width();
    final height = geo.height();

    final parentRB = WindowOverlayWidget.globalKey()
        .currentContext!
        .findRenderObject() as RenderBox?;

    final localPos =
        parentRB == null ? Offset(x, y) : parentRB.globalToLocal(Offset(x, y));

    return Positioned(
        left: localPos.dx,
        top: localPos.dy,
        width: width.toDouble(),
        height: height.toDouble(),
        child: kddwView.flutterWidget);
  }
}
