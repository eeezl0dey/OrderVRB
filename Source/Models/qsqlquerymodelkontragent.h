#ifndef QSQLQUERYMODELKONTRAGENT_H
#define QSQLQUERYMODELKONTRAGENT_H

#include <QObject>
#include <QSqlQueryModel>
#include "qlistmodels.h"
#include "qfilterproxymodel.h"
#include <memory>

using namespace  std;

class QSqlQueryModelKontragent : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QSqlQueryModel* proxyModel READ getProxyModel)

public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IDRole = Qt::UserRole + 1,  // код
        FullnameRole,               // наименование
        IDUserCreateRole,           // пользователь создавший
        INNRole,                     // код налогоплательщика
        IDBankRole,                 // код банка
        NAccountRole,               //Номер счета в банке
        IsBeneficiaryRole,          //1 - бинефициар, 0 - нет
        CreatorNameRole,             // имя создавшего запись пользователя
        BankName                     // наименование банка
    };

    explicit QSqlQueryModelKontragent(QObject *parent = 0);


    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    QSqlQueryModel* getProxyModel();
    Q_INVOKABLE void setFilterString(QString string);
    Q_INVOKABLE void setSortOrder(bool checked);

protected:
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;

    shared_ptr<QFilterProxyModel> filterModel;


signals:

public slots:
    QVariant getData(int row, QString colName);
    bool acceptKontr(int rowId, QString fname, int idbank, QString  naccount, int is_beneficiary = 1);

};

#endif // QSQLQUERYMODELKONTRAGENT_H
