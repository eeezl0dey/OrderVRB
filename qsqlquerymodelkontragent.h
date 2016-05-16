#ifndef QSQLQUERYMODELKONTRAGENT_H
#define QSQLQUERYMODELKONTRAGENT_H

#include <QObject>
#include <QSqlQueryModel>

class QSqlQueryModelKontragent : public QSqlQueryModel
{
    Q_OBJECT
public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IDRole = Qt::UserRole + 1,  // код
        FullnameRole,               // наименование
        IDUserCreateRole,           // пользователь создавший
        INNRole                     // код налогоплательщика
    };

    explicit QSqlQueryModelKontragent(QObject *parent = 0);

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

#endif // QSQLQUERYMODELKONTRAGENT_H
