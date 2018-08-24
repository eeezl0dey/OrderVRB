#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "sourcedb.h"
#include "localprint.h"
#include <QDebug>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("Home Soft");
    app.setApplicationName("Order VRB");

    QQmlApplicationEngine engine;

    QQmlContext *ctx;

    SourceDB sourceDB;
    LocalPrint localPrint;

    ctx = engine.rootContext();
    ctx->setContextProperty("dataBase", &sourceDB);
    ctx->setContextProperty("lprint", &localPrint);

//    engine.load(QUrl(QStringLiteral("qrc:/QML/MainWND.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/QML/main.qml")));

    return app.exec();
}
