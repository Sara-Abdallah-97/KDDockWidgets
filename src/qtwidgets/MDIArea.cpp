/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2020-2021 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

#include "MDIArea.h"

#include "controllers/DockWidget.h"
#include "controllers/MDILayout.h"
#include "controllers/DropArea.h"

#include "qtwidgets/views/View_qtwidgets.h"

#ifdef KDDOCKWIDGETS_QTWIDGETS
#include <QVBoxLayout>
#else
#include "DockWidgetQuick.h"
#endif

using namespace KDDockWidgets;
using namespace KDDockWidgets::Controllers;

class MDIArea::Private
{
public:
    Private(View *parent)
        : layoutWidget(new MDILayout(parent))
    {
    }

    ~Private()
    {
        delete layoutWidget;
    }

    MDILayout *const layoutWidget;
};

MDIArea::MDIArea(QWidget *parent)
    : Views::View_qtwidgets<QWidget>(nullptr, Type::MDIArea, parent)
    , d(new Private(this))
{
#ifdef KDDOCKWIDGETS_QTWIDGETS
    auto vlay = new QVBoxLayout(this);
    vlay->addWidget(View_qtwidgets::asQWidget(d->layoutWidget));
#else
    QWidgetAdapter::makeItemFillParent(d->layoutWidget);
#endif
}

MDIArea::~MDIArea()
{
    delete d;
}

void MDIArea::addDockWidget(Controllers::DockWidget *dw, QPoint localPt, InitialOption addingOption)
{
    if (dw->options() & Controllers::DockWidget::Option_MDINestable) {
        // We' wrap it with a drop area, so we can drag other dock widgets over this one and dock
        auto wrapperDW = new Controllers::DockWidget(QStringLiteral("%1-mdiWrapper").arg(dw->uniqueName()));
        auto dropAreaWrapper = new DropArea(wrapperDW->view(), {}, /*isMDIWrapper= */ true);
        dropAreaWrapper->addDockWidget(dw, Location_OnBottom, nullptr);
        wrapperDW->setGuestView(dropAreaWrapper->view()->asWrapper());

        dw = wrapperDW;
    }

    d->layoutWidget->addDockWidget(dw, localPt, addingOption);
}

void MDIArea::moveDockWidget(Controllers::DockWidget *dw, QPoint pos)
{
    d->layoutWidget->moveDockWidget(dw, pos);
}

void MDIArea::resizeDockWidget(Controllers::DockWidget *dw, QSize size)
{
    d->layoutWidget->resizeDockWidget(dw, size);
}

QList<Controllers::Frame *> MDIArea::frames() const
{
    return d->layoutWidget->frames();
}
