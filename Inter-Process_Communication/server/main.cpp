#include <QCoreApplication>
#include <QTcpServer>
#include <QTcpSocket>
#include <QDateTime>
#include <QTimer>
#include <QDebug>

int main(int argc, char *argv[]) {
    QCoreApplication app(argc, argv);

    QTcpServer server;
    if (!server.listen(QHostAddress::Any, 12345)) {
        qWarning() << "El servidor no pudo iniciarse.";
        return 1;
    }

    qDebug() << "Servidor escuchando en el puerto 12345";

    // Lista de clientes conectados
    QList<QTcpSocket *> clientSockets;

    // Función para enviar la hora al cliente
    auto sendTimeToClient = [&](QTcpSocket *clientSocket) {
        if (clientSocket && clientSocket->state() == QAbstractSocket::ConnectedState) {
            // Obtén la hora actual
            QDateTime currentDateTime = QDateTime::currentDateTime();
            QString formattedDateTime = currentDateTime.toString("yyyy-MM-dd hh:mm:ss");

            // Envía la hora al cliente
            QByteArray data = formattedDateTime.toUtf8();
            clientSocket->write(data);
            clientSocket->flush();
        }
    };

    // Crear un objeto QObject para usar como contexto
    QObject contextObject;

    // Conectar nuevos clientes
    QObject::connect(&server, &QTcpServer::newConnection, &contextObject, [&]() {
        while (server.hasPendingConnections()) {
            QTcpSocket *clientSocket = server.nextPendingConnection();
            if (clientSocket) {
                qDebug() << "Cliente conectado a las" << QDateTime::currentDateTime().toString("hh:mm:ss");

                // Agregar cliente a la lista
                clientSockets.append(clientSocket);

                // Conectar el temporizador para enviar datos periódicamente
                QTimer *timer = new QTimer(&contextObject);
                QObject::connect(timer, &QTimer::timeout, &contextObject, [clientSocket, sendTimeToClient]() {
                    sendTimeToClient(clientSocket);
                });
                timer->start(1000); // Enviar cada segundo

                // Conectar la señal de desconexión del cliente
                QObject::connect(clientSocket, &QTcpSocket::disconnected, clientSocket, [timer]() {
                    qDebug() << "Cliente desconectado a las" << QDateTime::currentDateTime().toString("hh:mm:ss");

                    // Eliminar el temporizador
                    timer->stop();
                    timer->deleteLater();
                });
            }
        }
    });


    return app.exec();
}
