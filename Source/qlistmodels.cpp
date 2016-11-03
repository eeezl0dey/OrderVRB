#include "qlistmodels.h"

QListModels* QListModels::thisClass = nullptr;

QListModels::QListModels(QObject *parent)
{
    this->setParent(parent);
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("OrderVRB");
    db.setUserName("root");
    db.setPassword("kadet");

    connect();

    QSqlQueryModelKontragent *mKontr;
    mKontr = new QSqlQueryModelKontragent(this);
    mKontr->setQuery("SELECT * FROM OrderVRB.сontragent;");
    hashlist.insert(mtype::kontr, mKontr);

    QSqlQueryModelUsers *mUsers;
    mUsers = new QSqlQueryModelUsers(this);
    mUsers->setQuery("SELECT * FROM OrderVRB.users;");
    hashlist.insert(mtype::users, mUsers);

}

QListModels::~QListModels()
{
    if(db.isOpen())
        db.close();
}

QListModels* QListModels::getInstance()
{
    if(thisClass == nullptr)
    {
        thisClass = new QListModels();
    }
    return thisClass;
}

void QListModels::connect()
{
    //    qDebug() << QSqlDatabase::drivers();
    //    qDebug() << QApplication::libraryPaths();

    bool ok = db.open();
    qDebug()<< QString("Connect is ") + QString((bool)ok?"accept":"error");
    if(!ok)
    {
        qDebug() << db.lastError().text();
        QApplication::quit();
    }
    return;
}

QSqlQueryModel* QListModels::getModel( mtype mt)
{
    return *(thisClass->hashlist.find(mt));
}
