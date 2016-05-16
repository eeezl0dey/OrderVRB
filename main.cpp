#include <QApplication>
#include <QQmlApplicationEngine>
#include "sourcedb.h"
#include <QDebug>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *ctx;

    SourceDB sourceDB;
    if(sourceDB.connect())
    {
//        engine.load(QUrl(QStringLiteral("qrc:/Login.qml")));
//        engine.load(QUrl(QStringLiteral("qrc:/MainWND.qml")));
        engine.load(QUrl(QStringLiteral("qrc:/Kontragent.qml")));
//        sourceDB.loadMKontragent();
    }
    else
        qDebug() << sourceDB.getLastError();

    ctx = engine.rootContext();
    ctx->setContextProperty("dataBase", &sourceDB);

    return app.exec();
}
