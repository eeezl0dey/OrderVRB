#ifndef QSQLQUERYMODELUSERS_H
#define QSQLQUERYMODELUSERS_H

#include <QObject>
#include <QSqlQueryModel>

class QSqlQueryModelUsers : public QSqlQueryModel
{
    Q_OBJECT
public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IDRole = Qt::UserRole + 1,  // код
        UsernameRole,               // логин
        UserpassRole,           // пароль
        FullnameRole,            // полное имя
        IsAdminRole              // Администратор ли? (1 - да, 0 - нет)
    };

    explicit QSqlQueryModelUsers(QObject *parent = 0);

    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;


protected:
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;
};

#endif // QSQLQUERYMODELUSERS_H
