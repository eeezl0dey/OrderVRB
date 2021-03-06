#include "sourcedb.h"
#include <QPluginLoader>
#include <QSqlRecord>

SourceDB::SourceDB(QObject *parent)
{

    this->setParent(parent);

}

SourceDB::~SourceDB()
{
}

bool SourceDB::setConnect(QString hostName, QString databaseName, QString userName, QString password)
{
    return QListModels::getInstance()->setConnect(hostName, databaseName, userName, password);
}


bool SourceDB::isConnected()
{
    return QListModels::getInstance()->isConnected();
}

QString SourceDB::getConnectError()
{
    return QListModels::getInstance()->getConnectError();
}

bool SourceDB::login(QString username, QString pass)
{
    QSqlQueryModelUsers* mUsers;
    mUsers = static_cast<QSqlQueryModelUsers*>(getModelUsers());
    QSqlQuery query = mUsers->query();
    bool isFind = false;
    if(query.first())
    {
        do{
           if(query.value("username").toString() == username &&
                   query.value("userpass").toString() == pass)
           {
              QString userFullName = query.value("fullname").toString();
              int idUser = query.value("idusers").toInt();
              QListModels::getInstance()->setUser(idUser, userFullName, query.value("isadmin").toBool());
              isFind = true;
              break;
           }
        }
        while(query.next());
    }
    return isFind;
}

QString SourceDB::getUserFullName()
{
    return QListModels::getInstance()->getUserFullName();
}


QAbstractItemModel* SourceDB::getModelKontr()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::kontr);
}


QAbstractItemModel* SourceDB::getModelUsers()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::users);
}

QAbstractItemModel* SourceDB::getModelBank()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::banks);
}

QAbstractItemModel* SourceDB::getModelOrder()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::order);
}

QAbstractItemModel* SourceDB::getModelOrderRetrieve()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::order, true);
}

QAbstractItemModel* SourceDB::getModelProxyKontr()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::proxyKontr);
}



bool SourceDB::getUserIsAdmin()
{
    return QListModels::getInstance()->getUserIsAdmin();
}
