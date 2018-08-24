#ifndef LOCALPRINT_H
#define LOCALPRINT_H

#include <QObject>
#include <QVariant>
#include <QPrintDialog>
#include <QPrinter>
#include <QPainter>
#include <QSize>
#include <QTextItem>
#include <QRectF>

class LocalPrint: public QObject
{
    Q_OBJECT

struct STextPaint {
    QRectF recf;    //Область вывода на печать
    QString text;   //Текст вывода
    QFont font;     //Шрифт вывода
};

public:
    explicit LocalPrint(QObject *parent = nullptr);
public slots:
    bool printOrder();
    void addToPrintList(int x, int y, int width, int height, QString, QFont );
    void clearPrintList();
private:
    QPrinter printer;
    QList<STextPaint> lsTextPaint;


};

#endif // LOCALPRINT_H
