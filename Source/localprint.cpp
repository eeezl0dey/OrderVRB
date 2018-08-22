#include "localprint.h"

LocalPrint::LocalPrint(QObject *parent)
{
    this->setParent(parent);
}

bool LocalPrint::printOrder(){

    QPrinter printer;
    QPrintDialog* printDialog =  new QPrintDialog(&printer,nullptr);
    if (printDialog->exec() == QDialog::Accepted) {
        QPainter painter(&printer);
        for(STextPaint stp: lsTextPaint){
            painter.setFont(stp.font);
            painter.drawText(stp.recf, Qt::TextWordWrap, stp.text);
        }
        painter.end();
        lsTextPaint.clear();
    }

    return true;
}

void LocalPrint::addToPrintList(int x, int y, int width, int height, QString text, QFont font){
    QRectF rectf(x,y,width, height);
    lsTextPaint.append(STextPaint{rectf, text, font});
}

void LocalPrint::clearPrintList(){
    lsTextPaint.clear();
}
