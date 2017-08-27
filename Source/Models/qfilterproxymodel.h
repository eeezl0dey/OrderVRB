#ifndef QFILTERPROXYMODEL_H
#define QFILTERPROXYMODEL_H

#include <QSortFilterProxyModel>


class QFilterProxyModel : public QSortFilterProxyModel
{  
    Q_OBJECT
    public:
    QFilterProxyModel(QObject* parent = 0);
    ~QFilterProxyModel();

    Q_INVOKABLE void setFilterString(QString string);

    Q_INVOKABLE void setSortOrder(bool checked);
};

#endif // QFILTERPROXYMODEL_H
