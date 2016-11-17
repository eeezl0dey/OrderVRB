#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "sourcedb.h"
#include <QDebug>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *ctx;

    SourceDB sourceDB;
    ctx = engine.rootContext();
    ctx->setContextProperty("dataBase", &sourceDB);

    engine.load(QUrl(QStringLiteral("qrc:/QML/MainWND.qml")));

    return app.exec();
}