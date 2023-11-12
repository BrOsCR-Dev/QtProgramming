#include <QCoreApplication>
#include <QDebug>
#include <QString>
#include <QList>
#include <QVector>
#include <QMap>
#include <QVariant>
#include <QFileInfo>
#include <QDir>
#include <QFile>
#include <QIODevice>
#include <QDate>
#include <QTime>
#include <QDateTime>
#include <QPoint>
#include <QSize>
#include <QRect>
#include <QColor>
#include <QUrl>
#include <QPixmap>
#include <QImage>
#include <QByteArray>
#include <QProcess>

int main(int argc, char *argv[]) {
    QCoreApplication app(argc, argv);

    // QString
    QString cadena = "¡Hola mundo desde Qt!";
    qDebug() << "QString: " << cadena;

    // QList
    QList<int> listaEnteros;
    listaEnteros << 1 << 2 << 3 << 4 << 5;
    qDebug() << "QList: " << listaEnteros;

    // QVector
    QVector<double> vectorDoubles;
    vectorDoubles << 3.14 << 2.71;
    qDebug() << "QVector: " << vectorDoubles;

    // QMap
    QMap<QString, int> mapa;
    mapa["uno"] = 1;
    mapa["dos"] = 2;
    qDebug() << "QMap: " << mapa;

    // QVariant
    QVariant valorEntero = 42;
    QVariant valorTexto = "Texto de ejemplo";
    qDebug() << "QVariant (entero): " << valorEntero.toInt();
    qDebug() << "QVariant (cadena): " << valorTexto.toString();

    // QFileInfo
    QFileInfo infoArchivo("./archivo.txt");
    qDebug() << "QFileInfo (nombre del archivo): " << infoArchivo.filePath();

    // QDir
    QDir directorio("./");
    qDebug() << "QDir (listado de archivos en el directorio): " << directorio.entryList();

    // QFile
    QFile archivo("archivo.txt");
    if (archivo.open(QIODevice::WriteOnly)) {
        archivo.write("Contenido del archivo.");
        archivo.close();
    }

    // QDate
    QDate fecha = QDate::currentDate();
    qDebug() << "QDate: " << fecha.toString("dd.MM.yyyy");

    // QTime
    QTime hora = QTime::currentTime();
    qDebug() << "QTime: " << hora.toString("hh:mm:ss");

    // QDateTime
    QDateTime fechaHora = QDateTime::currentDateTime();
    qDebug() << "QDateTime: " << fechaHora.toString("dd.MM.yyyy hh:mm:ss");

    // QPoint
    QPoint punto(10, 20);
    qDebug() << "QPoint: " << punto;

    // QSize
    QSize tamaño(100, 200);
        qDebug() << "QSize: " << tamaño;

    // QRect
    QRect rectangulo(10, 20, 100, 200);
    qDebug() << "QRect: " << rectangulo;

    // QColor
    QColor color(255, 0, 0); // Rojo
    qDebug() << "QColor (nombre): " << color.name();

    // QUrl
    QUrl url("https://www.ejemplo.com");
    qDebug() << "QUrl: " << url.toString();

    // QImage
    QImage imagen(200, 200, QImage::Format_RGB32);
    imagen.fill(Qt::blue);
    qDebug() << "QImage: " << imagen.size();

    // QByteArray
    QByteArray datos;
    datos.append("H");
    datos.append("o");
    datos.append("l");
    datos.append("a");
    datos.append(" ");
    datos.append("m");
    datos.append("u");
    datos.append("n");
    datos.append("d");
    datos.append("o");

    qDebug() << "QByteArray: ";
    for (int i = 0; i < datos.size(); i++) {
        qDebug() << i << ":" << datos.at(i);
    }

    // QProcess
    QProcess proceso;
    proceso.start("ipconfig");

    if (proceso.waitForFinished()) {
        QByteArray salida = proceso.readAllStandardOutput();
        QTextStream stream(stdout);
        stream << QString::fromUtf8(salida);
    } else {
        qDebug() << "Error al ejecutar el comando.";
    }

    return app.exec();
}
