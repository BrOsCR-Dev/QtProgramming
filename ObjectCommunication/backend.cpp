// backend.cpp
#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent), m_message("Hello from C++") {}

QString Backend::message() const {
    return m_message;
}

void Backend::setMessage(const QString &message) {
    if (message != m_message) {
        m_message = message;
        emit messageChanged();
    }
}
