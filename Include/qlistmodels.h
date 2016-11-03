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


class QListModels: public QObject
{
    Q_OBJECT
public:   
    enum mtype{
        users,
        kontr
    };

    static QListModels* getInstance();
    QSqlQueryModel* getModel( mtype);
private:
    static QListModels* thisClass;
    explicit QListModels(QObject *parent = 0);
    ~QListModels();
    QHash<mtype,QSqlQueryModel*> hashlist;
    QSqlDatabase db;
    void connect();
};

#endif // QLISTMODET_H
