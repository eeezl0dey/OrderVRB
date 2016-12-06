#include "qsqlquerymodelbank.h"

QSqlQueryModelBank::QSqlQueryModelBank(QObject *parent) :
    QSqlQueryModel(parent)
{
}

// Метод для получения данных из модели
QVariant QSqlQueryModelBank::data(const QModelIndex & index, int role) const {
    // Определяем номер колонки, адрес так сказать, по номеру роли
     int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */ 

    QVariant var;

    switch (role) {
//    case IsBeneficiaryRole:
//        var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
//        var = (var == 1) ? "Да":"Нет";
//        break;
    default:
        var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        break;
    }

    return var;
}

// Значение по номеру строки и столбца таблицы
QVariant QSqlQueryModelBank::getData(int row, QString colName){
//TODO
    return record(row).value(colName);

}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> QSqlQueryModelBank::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IDRole] = "idbank";
    roles[NameBankRole] = "name";
    roles[AddressBankRole] = "address";
    roles[IDCreatorRole] = "idusers";
    roles[CreatorNameRole] = "creatorname";
    return roles;
}
