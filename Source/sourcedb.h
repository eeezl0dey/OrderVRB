#ifndef SOURCEDB_H
#define SOURCEDB_H

#include <QObject>
//#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QDebug>
#include <QApplication>
#include <QSqlDriver>
#include "qsqlquerymodelkontragent.h"
#include "qsqlquerymodelusers.h"
#include "qlistmodels.h"

class SourceDB: public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString userFullName READ getUserFullName WRITE setUserFullName NOTIFY userFullNameChanged)
      Q_PROPERTY(QString userFullName READ getUserFullName)
      Q_PROPERTY(bool isAdmin READ getUserIsAdmin)
      Q_PROPERTY(QSqlQueryModel* modelKontr READ getModelKontr NOTIFY modelKontrChanged)
      Q_PROPERTY(QSqlQueryModel* modelBank READ getModelBank NOTIFY modelBankChanged)
      Q_PROPERTY(QSqlQueryModel* modelUsers READ getModelUsers NOTIFY modelUsersChanged)
      Q_PROPERTY(QSqlQueryModel* modelOrder READ getModelOrder NOTIFY modelOrderChanged)
public:
    explicit SourceDB(QObject *parent = 0);
    virtual ~SourceDB();
    QString getUserFullName();
    bool getUserIsAdmin();
    QSqlQueryModel* getModelKontr();
    QSqlQueryModel* getModelUsers();
    QSqlQueryModel* getModelBank();
    QSqlQueryModel* getModelOrder();
signals:
    void modelKontrChanged();
    void modelKontrFilterChanged();
    void modelUsersChanged();
    void modelBankChanged();
    void modelOrderChanged();
public slots:
    bool login(QString username, QString pass);
    bool isConnected();
    QString getConnectError();
    bool setConnect(QString hostName,      // ip или имя хоста
                    QString databaseName,  // наименование базы
                    QString userName,      // имя пользователя
                    QString password);     // пароль
};

#endif // SOURCEDB_H
