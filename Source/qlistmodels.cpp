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
    QSqlQueryModel* sqlmodel;
    switch (mt) {
    case mtype::kontr:
        sqlmodel = new QSqlQueryModelKontragent(this);
        sqlmodel->setQuery("SELECT c.*, u.fullname as creatorname FROM OrderVRB.сontragent as c join OrderVRB.users as u on c.idusers = u.idusers");
        break;
    case mtype::users:
        sqlmodel = new QSqlQueryModelUsers(this);
        sqlmodel->setQuery("SELECT * FROM OrderVRB.users;");
        break;
    case mtype::banks:
        sqlmodel = new QSqlQueryModelBank(this);
        sqlmodel->setQuery("SELECT b.*, u.fullname as creatorname FROM OrderVRB.bank as b left outer join OrderVRB.users as u on u.idusers = b.idusers");
        break;
    default:
        sqlmodel = NULL;
        break;
    }
    return sqlmodel;
}
