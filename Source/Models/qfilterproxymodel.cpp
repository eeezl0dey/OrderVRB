#include "qfilterproxymodel.h"

QFilterProxyModel::QFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    setSortOrder(false);
}


QFilterProxyModel::~QFilterProxyModel()
{

}

void QFilterProxyModel::setFilterString(QString string)
{
 this->setFilterCaseSensitivity(Qt::CaseInsensitive);
 this->setFilterFixedString(string);
}

void QFilterProxyModel::setSortOrder(bool checked)
{
 if(checked)
 {
 this->sort(0, Qt::DescendingOrder);
 }
 else
 {
 this->sort(0, Qt::AscendingOrder);
 }
}
