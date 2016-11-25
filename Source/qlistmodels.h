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
protected:
    static QListModels* thisClass;
    explicit QListModels(QObject *parent = 0);
    ~QListModels();
    QHash<mtype,QSqlQueryModel*> hashlist;
    QSqlDatabase db;
    void connect();
    bool connectdb;
    QString connectError="";
};

#endif // QLISTMODET_H
