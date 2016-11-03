#include "qsqlquerymodelkontragent.h"

QSqlQueryModelKontragent::QSqlQueryModelKontragent(QObject *parent) :
    QSqlQueryModel(parent)
{
}

// Метод для получения данных из модели
QVariant QSqlQueryModelKontragent::data(const QModelIndex & index, int role) const {
    // Определяем номер колонки, адрес так сказать, по номеру роли
     int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    QVariant var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);

    if (role == IDUserCreateRole)
    {
        int id = var.toInt();
        QSqlQuery query = QListModels::getInstance()->getModel(QListModels::users)->query();
        if(query.first())
        {
            do{
                if(query.value("idusers").toInt() == id)
                {
                 var = query.value("fullname").toString();
                 break;
                }

            }
            while(query.next());
        }
    }

    return var;
}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> QSqlQueryModelKontragent::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IDRole] = "idcontragent";
    roles[FullnameRole] = "fname";
    roles[IDUserCreateRole] = "idusers";
    roles[INNRole] = "inn";
    return roles;
}
