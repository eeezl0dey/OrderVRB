#include "qsqlquerymodelorder.h"

QSqlQueryModelOrder::QSqlQueryModelOrder(QObject *parent) :
    QSqlQueryModel(parent)
{
}

// Метод для получения данных из модели
QVariant QSqlQueryModelOrder::data(const QModelIndex & index, int role) const {
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
QVariant QSqlQueryModelOrder::getData(int row, QString colName){
    QVariant var;
    int role = roleNames().key(colName.toUtf8());
    int numColumn = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(row , numColumn);
    var = data(modelIndex,role);
    return var;

}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> QSqlQueryModelOrder::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IDRole] = "idorder";
    roles[IDCreatorRole] = "idusers";
    roles[IDContragentRole] = "idcontragent";
    roles[SummRole] = "summ";
    roles[CommentRole] = "comment";
    roles[ChargeIncludRole] = "chargeinclud";
    roles[CreateDateRole] = "createdate";
    roles[IDBeneficiaryRole] = "idbeneficiary";

    return roles;
}

// Добавление/редактирование счета
bool QSqlQueryModelOrder::acceptOrder(int rowId, int idContragent, int summa, QString comment, short chargeInclude, int idBeneficiary)
{
    QSqlQuery query;
    QString script;

    QString querystr;
    if(rowId > 0)
    {
//        TODO
//        querystr = "UPDATE `OrderVRB`.`bank`  \
//                SET                                 \
//                `name` = :name,                   \
//                `address` = :address            \
//                WHERE `idba1nk` = :idbank; ";
//        query.prepare(querystr);
//        query.bindValue(":idbank", rowId);
    }
    else
    {
//        TODO
//        querystr = "INSERT INTO `OrderVRB`.`bank` \
//                (`name`,                               \
//                `idusers`,                               \
//                `address`)                              \
//                VALUES                                  \
//                (:name,                                \
//                :idusers,                               \
//                :address);";
//        query.prepare(querystr);
//        query.bindValue(":idusers", QListModels::getInstance()->getUserId());
    }
    qDebug() << querystr;
//        TODO
//    query.bindValue(":name", name);
//    query.bindValue(":address", address);
    if(!query.exec())
        qDebug() << query.lastError();
    return true;
}
