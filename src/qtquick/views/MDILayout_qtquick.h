/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2019-2022 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

#include "kddockwidgets/docks_export.h"
#include "kddockwidgets/KDDockWidgets.h"

#include "View_qtquick.h"

namespace KDDockWidgets {
class MDILayout;

namespace Views {

class DOCKS_EXPORT MDILayout_qtquick : public Views::View_qtquick
{
    Q_OBJECT
public:
    explicit MDILayout_qtquick(MDILayout *controller, View *parent);
    ~MDILayout_qtquick();

    /// TODOv2
    void onLayoutRequest() override;
    bool onResize(QSize newSize) override;

private:
    MDILayout *const m_controller;
};

}
}
