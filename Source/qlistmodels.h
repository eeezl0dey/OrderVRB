#ifndef QLISTMODET_H
#define QLISTMODET_H

#include <QObject>
//#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QDebug>
#include <QHash>
#include <QSqlQueryModel>
#include <QApplication>
#include <QSortFilterProxyModel>
#include "qsqlquerymodelkontragent.h"
#include "qsqlquerymodelusers.h"
#include "qsqlquerymodelbank.h"
#include "qsqlquerymodelorder.h"


class QListModels: public QObject
{
    Q_OBJECT
public:   
    enum  mtype {
        users,
        kontr,
        banks,
        order,
        proxyKontr
    };

    static QListModels* getInstance();
    QAbstractItemModel* getModel( mtype);
    bool isConnected();
    QString getConnectError();
    void setUser(int id, QString fname, bool isadmin);
    QString getUserFullName();
    int getUserId();
    bool getUserIsAdmin();


    /*Коннект с базой*/
    bool setConnect(QString hostName,      // ip или имя хоста
                    QString databaseName,  // наименование базы
                    QString userName,      // имя пользователя
                    QString password);     // пароль
protected:
    static QListModels* thisClass;
    explicit QListModels(QObject *parent = 0);
    ~QListModels();
    QHash<mtype,QAbstractItemModel*> hashlist;
    QSqlDatabase db;
    bool connectdb;
    QString connectError="";

private:
    QString userFullName;
    bool isAdmin;
    int idUser;
};

#endif // QLISTMODET_H
