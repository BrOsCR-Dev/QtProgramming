#include "backend.h"
#include <QDebug>
#include <QVariant>
#include <QProcess>

Backend::Backend(QObject *parent) : QObject(parent)
{
    m_generating = false;
    connect(&mProcess, SIGNAL(stateChanged(QProcess::ProcessState)),
            this, SLOT(updateStatus(QProcess::ProcessState)));
}

Backend::~Backend()
{

}

void Backend::updateStatus(QProcess::ProcessState status)
{
    emit setGenerating(status != QProcess::NotRunning);
}

//This function runs the script that reduces the images
void Backend::compress(QVariant urls)
{
    QStringList args;
    args << "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process;";

    for (int i = 0; i < urls.toList().size(); i++) {
        QString url = urls.toList()[i].toString();

        if (url.contains(".png", Qt::CaseInsensitive)) {
            args << "./image.ps1" << urls.toList()[i].toString() << ";";
        } else {
            args << "./folder.ps1" << urls.toList()[i].toString() << ";";
        }
    }

    args << "exit";
    mProcess.setProgram("C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe");
    mProcess.setArguments(args);
    mProcess.start();
    //mProcess.startDetached(); //startDetached para mostrar en consola
}

bool Backend::generating() const
{
    return m_generating;
}

void Backend::setGenerating(bool generating)
{
    if (m_generating == generating) return;

    m_generating = generating;
    emit generatingChanged(m_generating);
}
