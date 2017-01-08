#ifndef QLISTMODET_H
#define QLISTMODET_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QDebug>
#include <QHash>
#include <QSqlQueryModel>
#include <QApplication>
#include "qsqlquerymodelkontragent.h"
#include "qsqlquerymodelusers.h"
#include "qsqlquerymodelbank.h"


class QListModels: public QObject
{
    Q_OBJECT
public:   
    enum mtype{
        users,
        kontr,
        banks
    };

    static QListModels* getInstance();
    QSqlQueryModel* getModel( mtype);
    bool isConnected();
    QString getConnectError();
    void setUserFullName(int id, QString fname);
    QString getUserFullName();
    int getUserId();


    /*Коннект с базой*/
    bool setConnect(QString hostName,      // ip или имя хоста
                    QString databaseName,  // наименование базы
                    QString userName,      // имя пользователя
                    QString password);     // пароль
protected:
    static QListModels* thisClass;
    explicit QListModels(QObject *parent = 0);
    ~QListModels();
    QHash<mtype,QSqlQueryModel*> hashlist;
    QSqlDatabase db;
    bool connectdb;
    QString connectError="";

private:
    QString userFullName;
    int idUser;
};

#endif // QLISTMODET_H
