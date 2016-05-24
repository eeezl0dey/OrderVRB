TEMPLATE = app

QT += qml quick widgets sql core network

CONFIG+=qml_debug
CONFIG+= c++11

SOURCES += main.cpp \
    sourcedb.cpp \
    qsqlquerymodelkontragent.cpp \
    qsqlquerymodelusers.cpp \
    qlistmodels.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    sourcedb.h \
    qsqlquerymodelkontragent.h \
    qsqlquerymodelusers.h \
    qlistmodels.h
