#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "backend.h"
#include "QIcon"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Backend>("Backend", 1, 0, "Backend");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ImageCompressor/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
