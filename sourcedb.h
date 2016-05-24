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

class SourceDB: public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString userFullName READ getUserFullName WRITE setUserFullName NOTIFY userFullNameChanged)
      Q_PROPERTY(QString userFullName READ getUserFullName)
      Q_PROPERTY(QSqlQueryModel* modelKontr READ getModelKontr NOTIFY modelKontrChanged)
public:
    explicit SourceDB(QObject *parent = 0);
    virtual ~SourceDB();
    bool connect();
    QString getUserFullName();
    QSqlQueryModel* getModelKontr();
private:
    QSqlDatabase db;
    QString userFullName;
    QSqlQueryModelKontragent *mKontr;
    QSqlQueryModelUsers *mUsers;

signals:
    void modelKontrChanged();
    void modelUsersChanged();
public slots:
    QString getLastError();
    bool login(QString username, QString pass);
    void loadMKontragent();
    void loadMUsers();
};

#endif // SOURCEDB_H
