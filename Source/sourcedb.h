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
#include <QSortFilterProxyModel>
#include "qsqlquerymodelkontragent.h"
#include "qsqlquerymodelusers.h"
#include "qlistmodels.h"

class SourceDB: public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString userFullName READ getUserFullName WRITE setUserFullName NOTIFY userFullNameChanged)
      Q_PROPERTY(QString userFullName READ getUserFullName)
      Q_PROPERTY(bool isAdmin READ getUserIsAdmin NOTIFY modelUsersChanged)
      Q_PROPERTY(QAbstractItemModel* modelKontr READ getModelKontr NOTIFY modelKontrChanged)
      Q_PROPERTY(QAbstractItemModel* modelBank READ getModelBank NOTIFY modelBankChanged)
      Q_PROPERTY(QAbstractItemModel* modelUsers READ getModelUsers NOTIFY modelUsersChanged)
      Q_PROPERTY(QAbstractItemModel* modelOrder READ getModelOrder NOTIFY modelOrderChanged)
      Q_PROPERTY(QAbstractItemModel* modelOrderRetrieve READ getModelOrderRetrieve NOTIFY modelOrderChanged)
      Q_PROPERTY(QAbstractItemModel* modelProxyKontr READ getModelProxyKontr NOTIFY modelProxyKontrChanged)
public:
    explicit SourceDB(QObject *parent = nullptr);
    virtual ~SourceDB();
    QString getUserFullName();
    bool getUserIsAdmin();
    QAbstractItemModel* getModelKontr();
    QAbstractItemModel* getModelUsers();
    QAbstractItemModel* getModelBank();
    QAbstractItemModel* getModelOrder();
    QAbstractItemModel* getModelOrderRetrieve();
    QAbstractItemModel* getModelProxyKontr();
signals:
    void modelKontrChanged();
    void modelKontrFilterChanged();
    void modelUsersChanged();
    void modelBankChanged();
    void modelOrderChanged();
    void modelProxyKontrChanged();
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
