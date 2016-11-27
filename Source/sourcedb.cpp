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
    mUsers = (QSqlQueryModelUsers*)getModelUsers();
    QSqlQuery query = mUsers->query();
    bool isFind = false;
    if(query.first())
    {
        do{
           if(query.value("username").toString() == username &&
                   query.value("userpass").toString() == pass)
           {
            userFullName = query.value("fullname").toString();
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
    return userFullName;
}

QSqlQueryModel* SourceDB::getModelKontr()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::kontr);
}

QSqlQueryModel* SourceDB::getModelUsers()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::users);
}

QSqlQueryModel* SourceDB::getModelBank()
{
    return QListModels::getInstance()->getModel(QListModels::mtype::banks);
}


bool SourceDB::acceptKontr(int rowId){
    return true;
}

