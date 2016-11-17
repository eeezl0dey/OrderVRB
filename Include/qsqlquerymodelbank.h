#ifndef QSQLQUERYMODELBANK_H
#define QSQLQUERYMODELBANK_H

#include <QObject>
#include <QSqlQueryModel>
#include "qlistmodels.h"

class QSqlQueryModelBank : public QSqlQueryModel
{
    Q_OBJECT
public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IDRole = Qt::UserRole + 1,  // код
        NameBankRole,               // наименование
        AddressBankRole,           // адрес банка
        IDCreatorRole,             // id пользователя создавшего
        CreatorNameRole            // имя создавшего запись пользователя
    };

    explicit QSqlQueryModelBank(QObject *parent = 0);


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

};

#endif // QSQLQUERYMODELBANK_H
