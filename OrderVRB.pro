TEMPLATE = app

QT += qml quick widgets sql core network

CONFIG+=qml_debug
CONFIG+= c++1y #на будущее, возможно потребуется

#UI_SOURCES_DIR = ../OrderVRB/Source
#UI_HEADERS_DIR = ../OrderVRB/Source
SOURCE_DIR = Source
MODELS_DIR = $${SOURCE_DIR}/Models

INCLUDEPATH += $${SOURCE_DIR} \
            $${MODELS_DIR} \

DEPENDPATH += $$INCLUDEPATH

SOURCES += $${SOURCE_DIR}/main.cpp \
    $${SOURCE_DIR}/sourcedb.cpp \
    $${MODELS_DIR}/qsqlquerymodelkontragent.cpp \
    $${MODELS_DIR}/qsqlquerymodelusers.cpp \
    $${SOURCE_DIR}/qlistmodels.cpp \
    $${MODELS_DIR}/qsqlquerymodelbank.cpp \
    Source/Models/qsqlquerymodelorder.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    Source/Models/qsqlquerymodelbank.h \
    Source/Models/qsqlquerymodelkontragent.h \
    Source/Models/qsqlquerymodelusers.h \
    Source/qlistmodels.h \
    Source/sourcedb.h \
    Source/Models/qsqlquerymodelorder.h
