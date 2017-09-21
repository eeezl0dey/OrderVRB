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
    QVariant var;
    int role = roleNames().key(colName.toUtf8());
    int numColumn = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(row , numColumn);
    var = data(modelIndex,role);
    return var;

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

// Добавление/редактирование банка
bool QSqlQueryModelBank::acceptBank(int rowId, QString name, QString  address)
{
    QSqlQuery query;
    QString script;

    QString querystr;
    if(rowId > 0)
    {
        querystr = "UPDATE `OrderVRB`.`bank`  \
                SET                                 \
                `name` = :name,                   \
                `address` = :address            \
                WHERE `idbank` = :idbank; ";
        query.prepare(querystr);
        query.bindValue(":idbank", rowId);
    }
    else
    {
        querystr = "INSERT INTO `OrderVRB`.`bank` \
                (`name`,                               \
                `idusers`,                               \
                `address`)                              \
                VALUES                                  \
                (:name,                                \
                :idusers,                               \
                :address);";
        query.prepare(querystr);
        query.bindValue(":idusers", QListModels::getInstance()->getUserId());
    }
    qDebug() << querystr;
    query.bindValue(":name", name);
    query.bindValue(":address", address);
    if(!query.exec())
        qDebug() << query.lastError();
    else{
        QSqlQueryModelBank *mb = static_cast<QSqlQueryModelBank*> (QListModels::getInstance()->getModel(QListModels::banks));
        mb->setQuery( mb->query().lastQuery() );
    }
    return true;
}
