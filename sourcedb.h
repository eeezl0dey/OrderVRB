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

class SourceDB: public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString userFullName READ getUserFullName WRITE setUserFullName NOTIFY userFullNameChanged)
      Q_PROPERTY(QString userFullName READ getUserFullName)
public:
    explicit SourceDB(QObject *parent = 0);
    virtual ~SourceDB();
    bool connect();
    QString getUserFullName();
private:
    QSqlDatabase db;
    QString userFullName;
signals:
public slots:
    QString getLastError();
    bool login(QString username, QString pass);
};

#endif // SOURCEDB_H
