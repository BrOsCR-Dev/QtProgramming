#include <QCoreApplication>
#include <QTcpSocket>
#include <QDebug>

int main(int argc, char *argv[]) {
    QCoreApplication app(argc, argv);

    QTcpSocket clientSocket;

    // Conéctate al servidor
    clientSocket.connectToHost("127.0.0.1", 12345); // IP y puerto del servidor

    if (clientSocket.waitForConnected()) {
        qDebug() << "Conexión exitosa.";

            while (clientSocket.state() == QAbstractSocket::ConnectedState) {
            // Espera a recibir datos
            if (clientSocket.waitForReadyRead()) {
                QByteArray data = clientSocket.readAll();
                QString message = QString::fromUtf8(data);

                // Procesa y muestra los datos recibidos
                qDebug() << "Mensaje recibido:" << message;
            }
        }
    } else {
        qWarning() << "No se pudo conectar al servidor.";
        return 1;
    }

    return app.exec();
}
