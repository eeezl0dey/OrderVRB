#include "qsqlquerymodelusers.h"

QSqlQueryModelUsers::QSqlQueryModelUsers(QObject *parent):
    QSqlQueryModel(parent)
{

}

// Метод для получения данных из модели
QVariant QSqlQueryModelUsers::data(const QModelIndex & index, int role) const {
    // Определяем номер колонки, адрес так сказать, по номеру роли
     int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
//    QModelIndex modelIndex =
            this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
//    QVariant var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    QVariant var = QSqlQueryModel::data(index, role);
    return var;
}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> QSqlQueryModelUsers::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IDRole] = "idusers";
    roles[UsernameRole] = "username";
    roles[UserpassRole] = "userpass";
    roles[FullnameRole] = "fullname";
    return roles;
}
