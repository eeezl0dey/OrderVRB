#ifndef SOURCEDB_H
#define SOURCEDB_H

#include <QObject>
#include <QSql>
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
      Q_PROPERTY(QSqlQueryModel* modelKontr READ getModelKontr NOTIFY modelKontrChanged)
      Q_PROPERTY(QSqlQueryModel* modelBank READ getModelBank NOTIFY modelBankChanged)
      Q_PROPERTY(QSqlQueryModel* modelUsers READ getModelUsers NOTIFY modelUsersChanged)
public:
    explicit SourceDB(QObject *parent = 0);
    virtual ~SourceDB();
    QString getUserFullName();
    QSqlQueryModel* getModelKontr();
    QSqlQueryModel* getModelUsers();
    QSqlQueryModel* getModelBank();
signals:
    void modelKontrChanged();
    void modelUsersChanged();
    void modelBankChanged();
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
