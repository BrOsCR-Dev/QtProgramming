#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include "QString"
#include "QMessageBox"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QString nombre = ui->lineEdit->text();
    QMessageBox::information(this, tr("Bienvenido"), tr("Hola %1 desde el QMessage").arg(nombre));
}

