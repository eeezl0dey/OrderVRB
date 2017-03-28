#ifndef QSQLQUERYMODELORDER_H
#define QSQLQUERYMODELORDER_H

#include <QObject>
#include <QSqlQueryModel>
#include "qlistmodels.h"
#include <QSqlRecord>


class QSqlQueryModelOrder : public QSqlQueryModel
{
    Q_OBJECT
public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IDRole = Qt::UserRole + 1,  // код
        IDCreatorRole,             // id пользователя создавшего
        IDContragentRole,               // контрагент
        SummRole,           // сумма счета * 100 (без копеек)
        CommentRole,           // коментарий
        ChargeIncludRole,           // включена ли комиссия
        CreateDateRole,           // момент создания
        IDBeneficiaryRole            // id контрагента бенефециара (плательщика)
    };

    explicit QSqlQueryModelOrder(QObject *parent = 0);


    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    QVariant getData(int row, QString colName);
    bool acceptOrder(int rowId, int idContragent, int summa, QString comment, short chargeInclude, int idBeneficiary);

};

#endif // QSQLQUERYMODELORDER_H
