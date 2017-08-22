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
QVariant QSqlQueryModelKontragent::getData(int row, QString colName){
    QVariant var;
    int role = roleNames().key(colName.toUtf8());
    int numColumn = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(row , numColumn);
    var = data(modelIndex,role);
    return var;

}

bool QSqlQueryModelKontragent::acceptKontr(int rowId, QString fname, int idbank, QString  naccount, int is_beneficiary){
    QSqlQuery query;
    QString script;

    qDebug() << idbank;
    QString querystr;
    if(rowId > 0)
    {
        querystr = "UPDATE `OrderVRB`.`сontragent`  \
                SET                                 \
                `fname` = :fname,                   \
                `idbank` = :idbank,                 \
                `naccount` = :naccount,              \
                `is_beneficiary` = :is_beneficiary    \
                WHERE `idсontragent` = :idcontragent; ";
        query.prepare(querystr);
        query.bindValue(":idcontragent", rowId);
    }
    else
    {
        querystr = "INSERT INTO `OrderVRB`.`сontragent` \
                (`fname`,                               \
                `idusers`,                              \
                `idbank`,                               \
                `naccount`,                             \
                `is_beneficiary`)                       \
                VALUES                                  \
                (:fname,                                \
                :idusers,                               \
                :idbank,                                \
                :naccount,                              \
                :is_beneficiary);";
        query.prepare(querystr);
        query.bindValue(":idusers", QListModels::getInstance()->getUserId());
    }
    qDebug() << querystr;
    query.bindValue(":fname", fname);
    query.bindValue(":idbank", idbank);
    query.bindValue(":naccount", naccount);
    query.bindValue(":is_beneficiary", is_beneficiary?1:0);
    if(!query.exec())
        qDebug() << query.lastError();
    return true;
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
    roles[IDBankRole] = "idbank";
    roles[NAccountRole] = "naccount";
    roles[IsBeneficiaryRole] = "is_beneficiary";
    roles[CreatorNameRole] = "creatorname";
    roles[BankName] = "bankname";
    return roles;
}
