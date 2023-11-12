#include <QApplication>
#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsTextItem>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    // Crea una escena y agrega elementos gráficos
    QGraphicsScene scene;
    scene.addEllipse(50, 50, 100, 100);
    scene.addRect(200, 50, 100, 100);
    QGraphicsTextItem *text = scene.addText("Hola, Graphics View!");
    text->setPos(50, 200);

    // Crea una vista de gráficos y configura la escena
    QGraphicsView view(&scene);

    // Configura la vista
    view.setWindowTitle("Ejemplo de Graphics View");
    view.resize(400, 300);
    view.show();

    return app.exec();
}
