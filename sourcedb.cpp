#include "sourcedb.h"
#include <QPluginLoader>

SourceDB::SourceDB(QObject *parent)
{

    this->setParent(parent);
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("OrderVRB");
    db.setUserName("root");
    db.setPassword("kadet");
    mKontr = new QSqlQueryModelKontragent(this);
}

SourceDB::~SourceDB()
{
    if(db.isOpen())
        db.close();
    delete mKontr;
}

bool SourceDB::connect()
{
    bool ok = db.open();
    qDebug()<< QString("Connect is ") + QString((bool)ok?"accept":"error");
    //    qDebug() << QSqlDatabase::drivers();
    //    qDebug() << QApplication::libraryPaths();
    return ok;
}

QString SourceDB::getLastError()
{
    return db.lastError().text();
}

bool SourceDB::login(QString username, QString pass)
{
    QSqlQuery query;
    bool isFind = false;
    query.prepare("select * from users where username = :login and userpass = :pass");
    query.bindValue(":login", username);
    query.bindValue(":pass", pass);
    query.exec();
    if(query.next() > 0)
    {
       userFullName = query.value("fullname").toString();
       isFind = true;
    }
    return isFind;
}

QString SourceDB::getUserFullName()
{
    return userFullName;
}

QSqlQueryModel* SourceDB::getModelKontr()
{
    return mKontr;
}


void SourceDB::loadMKontragent()
{
    mKontr->setQuery("SELECT * FROM OrderVRB.сontragent;");
    emit modelKontrChanged();
    return;
}

