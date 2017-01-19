#include "qlistmodels.h"

QListModels* QListModels::thisClass = nullptr;

QListModels::QListModels(QObject *parent)
{
    this->setParent(parent);
    db = QSqlDatabase::addDatabase("QMYSQL");
//    db.setHostName("localhost");
//    db.setDatabaseName("OrderVRB");
//    db.setUserName("root");
//    db.setPassword("kadet");
}

QListModels::~QListModels()
{
    if(db.isOpen())
        db.close();
}

bool QListModels::setConnect(QString hostName, QString databaseName, QString userName, QString password)
{
//    db.setHostName("localhost");
//    db.setDatabaseName("OrderVRB");
//    db.setUserName("root");
//    db.setPassword("kadet");

    db.setHostName(hostName);
    db.setDatabaseName(databaseName);
    db.setUserName(userName);
    db.setPassword(password);

    qDebug() << QSqlDatabase::drivers();
    qDebug() << QApplication::libraryPaths();

    connectdb = db.open();
    qDebug()<< QString("Connect is ") + QString((bool)connectdb?"accept":"error");
    if(!connectdb)
    {
        connectError = db.lastError().text();
        qDebug() << connectError;
    }
    return connectdb;
}

QListModels* QListModels::getInstance()
{
    if(thisClass == nullptr)
    {
        thisClass = new QListModels();
    }
    return thisClass;
}

bool QListModels::isConnected()
{
    return connectdb;
}

QString QListModels::getConnectError()
{
    return connectError;
}


QString QListModels::getUserFullName()
{
    return userFullName;
}

int QListModels::getUserId()
{
    return idUser;
}

bool QListModels::getUserIsAdmin()
{
    return isAdmin;
}


void QListModels::setUser(int id, QString fname, bool isadmin)
{
    idUser = id;
    userFullName = fname;
    isAdmin = isadmin;
    return ;
}

QSqlQueryModel* QListModels::getModel( mtype mt)
{
    QSqlQueryModel* sqlmodel;
    switch (mt) {
    case mtype::kontr:
        sqlmodel = new QSqlQueryModelKontragent(this);
        sqlmodel->setQuery("SELECT c.*, u.fullname as creatorname, b.name as bankname \
                            FROM OrderVRB.сontragent as c join OrderVRB.users as u on c.idusers = u.idusers \
                                                          join OrderVRB.bank as b on b.idbank = c.idbank \
                            order by c.idсontragent desc");
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
