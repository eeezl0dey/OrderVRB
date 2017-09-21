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
    case IDContragentRole:
        var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        var = (var == 1) ? "Да":"Нет";
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
    roles[CreatorNameRole] = "creatorname";
    roles[NContragentRole] = "ncontragent";

    return roles;
}

// Добавление/редактирование счета
bool QSqlQueryModelOrder::acceptOrder(int rowId, int idContragent, int summa, QString comment, short chargeInclude, int idBeneficiary)
{
    QSqlQuery query;

    QString querystr="";
    if(rowId > 0)
    {
        querystr = "UPDATE `OrderVRB`.`order`       \
                SET                                 \
                `idсontragent` = :idсontragent,     \
                `summ` = :summ,                     \
                `comment` = :comment,               \
                `chargeinclud` = :chargeinclud,   \
                `idbeneficiary` = :idbeneficiary    \
                WHERE `idorder` = :idorder; ";
        query.prepare(querystr);
        query.bindValue(":idorder", rowId);
    }
    else
    {
        querystr = "INSERT INTO `OrderVRB`.`order` \
                (`idusers`,                        \
                `idcontragent`,                    \
                `summ`,                            \
                `comment`,                         \
                `chargeinclud`,                   \
                `idbeneficiary`)                   \
                VALUES                             \
                (:idusers,                         \
                :idcontragent,                     \
                :summ,                             \
                :comment,                          \
                :chargeinclud,                    \
                :idbeneficiary);";
         query.prepare(querystr);
        query.bindValue(":idusers", QListModels::getInstance()->getUserId());
    }
    qDebug() << querystr;
    query.bindValue(":idcontragent", idContragent);
    query.bindValue(":summ", summa);
    query.bindValue(":comment", comment);
    query.bindValue(":chargeinclud", chargeInclude);
    query.bindValue(":idbeneficiary", idBeneficiary);
    if(!query.exec())
        qDebug() << query.lastError();
    else{
        QSqlQueryModelOrder *mo = static_cast<QSqlQueryModelOrder*> (QListModels::getInstance()->getModel(QListModels::order));
        mo->setQuery( mo->query().lastQuery() );
    }
    return true;
}
