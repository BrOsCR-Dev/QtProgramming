#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "backend.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Crear una instancia del objeto Backend
    Backend backend;

    QQmlApplicationEngine engine;

    // Exponer el objeto Backend al contexto de QML
    engine.rootContext()->setContextProperty("backend", &backend);

    const QUrl url(u"qrc:/ObjectCommunication/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
