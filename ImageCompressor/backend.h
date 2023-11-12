#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QVariant>
#include <QProcess>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool generating READ generating WRITE setGenerating NOTIFY generatingChanged)

public:
    explicit Backend(QObject *parent = nullptr);
    ~Backend();
    Q_INVOKABLE void compress(QVariant urls);

    bool generating() const;

signals:
    void generatingChanged(bool generating);

public slots:
    void updateStatus(QProcess::ProcessState s);

private slots:
    void setGenerating(bool generating);

private:
    QProcess mProcess;
    bool m_generating;

};

#endif // BACKEND_H
