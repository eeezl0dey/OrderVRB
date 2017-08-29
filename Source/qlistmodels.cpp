#include "qlistmodels.h"

QListModels* QListModels::thisClass = nullptr;

QListModels::QListModels(QObject *parent)
{
    this->setParent(parent);
    db = QSqlDatabase::addDatabase("QMYSQL");
//    db.setHostName("localhost");
//    db.setDatabaseName("OrderVRB");
//    db.setUserName("root");
//    db.setPassword("kadet");
}

QListModels::~QListModels()
{
    if(db.isOpen())
        db.close();
}

bool QListModels::setConnect(QString hostName, QString databaseName, QString userName, QString password)
{
//    db.setHostName("localhost");
//    db.setDatabaseName("OrderVRB");
//    db.setUserName("root");
//    db.setPassword("kadet");

    db.setHostName(hostName);
    db.setDatabaseName(databaseName);
    db.setUserName(userName);
    db.setPassword(password);

    qDebug() << QSqlDatabase::drivers();
    qDebug() << QApplication::libraryPaths();


    connectdb = db.open();
    qDebug()<< QString("Connect is ") + QString((bool)connectdb?"accept":"error");
    if(!connectdb)
    {
        connectError = db.lastError().text();
        qDebug() << connectError;
    }
    return connectdb;
}

QListModels* QListModels::getInstance()
{
    if(thisClass == nullptr)
    {
        thisClass = new QListModels();
    }
    return thisClass;
}

bool QListModels::isConnected()
{
    return connectdb;
}

QString QListModels::getConnectError()
{
    return connectError;
}


QString QListModels::getUserFullName()
{
    return userFullName;
}

int QListModels::getUserId()
{
    return idUser;
}

bool QListModels::getUserIsAdmin()
{
    return isAdmin;
}


void QListModels::setUser(int id, QString fname, bool isadmin)
{
    idUser = id;
    userFullName = fname;
    isAdmin = isadmin;
    return ;
}

QAbstractItemModel* QListModels::getModel ( mtype mt)
{
    //позаботимся о однократном выделении
    auto it = hashlist.find(mt);
    if(it != hashlist.end()){
        return it.value();
    }


    //утечки памяти не будет, удалятся при удалении этого класса.
    QSqlQueryModel*  sqlmodel;
    QSortFilterProxyModel* filtermodel;
    switch (mt) {
    case mtype::kontr:
    {
        sqlmodel = new QSqlQueryModelKontragent(this);
        sqlmodel->setQuery("SELECT c.*, u.fullname as creatorname, b.name as bankname \
                            FROM OrderVRB.сontragent AS c JOIN OrderVRB.users as u ON c.idusers = u.idusers \
                                                          JOIN OrderVRB.bank as b ON b.idbank = c.idbank \
                            ORDER BY c.idсontragent DESC");
        auto it = hashlist.find(mtype::proxyKontr);
        if(it!=hashlist.end()){
            QSortFilterProxyModel *pm = (QSortFilterProxyModel*)it.value();
            pm->setSourceModel(sqlmodel);
        }
        break;
    }

    case mtype::users:
        sqlmodel = new QSqlQueryModelUsers(this);
        sqlmodel->setQuery("SELECT * FROM OrderVRB.users;");
        break;
    case mtype::banks:
        sqlmodel = new QSqlQueryModelBank(this);
        sqlmodel->setQuery("SELECT b.*, u.fullname AS creatorname FROM OrderVRB.bank as b LEFT OUTER JOIN OrderVRB.users as u ON u.idusers = b.idusers");
        break;
    case mtype::order:
        sqlmodel = new QSqlQueryModelOrder(this);
        sqlmodel->setQuery("SELECT o.*, u.fullname AS creatorname, ct.fname AS ncontragent  \
                           FROM OrderVRB.order o \
                           LEFT OUTER JOIN OrderVRB.users u \
                           ON (u.idusers = o.idusers) \
                           LEFT OUTER JOIN OrderVRB.сontragent ct   \
                           ON (ct.`idсontragent` = o.`idсontragent`)");
        break;
    case mtype::proxyKontr:
        {
            filtermodel = new QSortFilterProxyModel(this);
            filtermodel->setDynamicSortFilter(true);
            filtermodel->setFilterRole(QSqlQueryModelKontragent::IsBeneficiaryRole);
            filtermodel->setFilterFixedString("0");
            auto it = hashlist.find(mtype::kontr);
            if(it!=hashlist.end()){
                filtermodel->setSourceModel(it.value());
            }
            break;
        }

    default:
        sqlmodel = NULL;
        break;
    }
    hashlist[mt] = (mt==mtype::proxyKontr)?filtermodel:(QAbstractItemModel*)sqlmodel;
    return (QAbstractItemModel*)hashlist[mt];
}
