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
public:
    explicit SourceDB(QObject *parent = 0);
    virtual ~SourceDB();
    QString getUserFullName();
    QSqlQueryModel* getModelKontr();
    QSqlQueryModel* getModelUsers();
private:
    QString userFullName;
signals:
    void modelKontrChanged();
    void modelUsersChanged();
public slots:
    bool login(QString username, QString pass);
};

#endif // SOURCEDB_H
