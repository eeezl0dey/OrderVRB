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
    QModelIndex modelIndex =
            this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    QVariant var;

    switch (role) {
    case IsAdminRole:
        var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        var = (var == 1) ? "Да":"Нет";
        break;
    default:
        var = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        break;
    }

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
    roles[IsAdminRole] = "isadmin";
    return roles;
}

// Значение по номеру строки и столбца таблицы
QVariant QSqlQueryModelUsers::getData(int row, QString colName){
    QVariant var;
    int role = roleNames().key(colName.toUtf8());
    int numColumn = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(row , numColumn);
    var = data(modelIndex,role);
    return var;

}

// Добавление/редактирование пользователя
bool QSqlQueryModelUsers::acceptUser(int rowId, QString username, QString  userpass, QString fullname, bool isadmin)
{
    QSqlQuery query;
    QString script;

    QString querystr;
    if(rowId > 0)
    {
        querystr = "UPDATE `OrderVRB`.`users`  \
                SET                                 \
                `username` = :username,                   \
                `userpass` = :userpass,            \
                `fullname` = :fullname            \
                WHERE `idusers` = :idusers; ";
        query.prepare(querystr);
        query.bindValue(":idusers", rowId);
    }
    else
    {
        querystr = "INSERT INTO `OrderVRB`.`users` \
                (`username`,                               \
                `userpass`,                               \
                `fullname`,                              \
                `isadmin`)                              \
                VALUES                                  \
                (:username,                                \
                :userpass,                               \
                :fullname,                               \
                :isadmin);";
        query.prepare(querystr);
    }
    qDebug() << querystr;
    query.bindValue(":username", username);
    query.bindValue(":userpass", userpass);
    query.bindValue(":fullname", fullname);
    query.bindValue(":isadmin", isadmin);
    if(!query.exec())
        qDebug() << query.lastError();
    return true;
}
