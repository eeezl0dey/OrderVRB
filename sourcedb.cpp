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

bool SourceDB::login(QString username, QString pass)
{
    bool isFind = false;
    QSqlQueryModelUsers* mUsers;

    mUsers = (QSqlQueryModelUsers*)getModelUsers();
    int rowCount;
    rowCount = mUsers->rowCount();
    int columnCount = mUsers->columnCount();
    for(int a=0; a < rowCount; a++)
    {
        QSqlRecord sr = mUsers->record(1);
        QString str = sr.value(1).toString();
        if(sr.value(sr.indexOf("username")).toString() == username &&
                sr.value(sr.indexOf("userpass")).toString() == pass)
        {
            userFullName = sr.value(sr.indexOf("fullname")).toString();
            isFind = true;
        }

    }

    return isFind;

//    QSqlQuery query;
//    bool isFind = false;
//    query.prepare("select * from users where username = :login and userpass = :pass");
//    query.bindValue(":login", username);
//    query.bindValue(":pass", pass);
//    query.exec();
//    if(query.next() > 0)
//    {
//       userFullName = query.value("fullname").toString();
//       isFind = true;
//    }
//    return isFind;
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

