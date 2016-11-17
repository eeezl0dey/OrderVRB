TEMPLATE = app

QT += qml quick widgets sql core network

CONFIG+=qml_debug
CONFIG+= c++11

#UI_SOURCES_DIR = ../OrderVRB/Source
#UI_HEADERS_DIR = ../OrderVRB/Source

INCLUDE_DIR = Include

INCLUDEPATH += $${INCLUDE_DIR} \
DEPENDPATH += $$INCLUDEPATH

SOURCE_DIR = Source

SOURCES += $${SOURCE_DIR}/main.cpp \
    $${SOURCE_DIR}/sourcedb.cpp \
    $${SOURCE_DIR}/qsqlquerymodelkontragent.cpp \
    $${SOURCE_DIR}/qsqlquerymodelusers.cpp \
    $${SOURCE_DIR}/qlistmodels.cpp \
    Source/qsqlquerymodelbank.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    $${INCLUDE_DIR}/sourcedb.h \
    $${INCLUDE_DIR}/qsqlquerymodelkontragent.h \
    $${INCLUDE_DIR}/qsqlquerymodelusers.h \
    $${INCLUDE_DIR}/qlistmodels.h \
    Include/qsqlquerymodelbank.h
