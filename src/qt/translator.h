#pragma once
#include <QObject>

class Translator : public QObject {
    Q_OBJECT
public:
    explicit Translator(QObject* parent = nullptr) : QObject(parent) {}
    Q_INVOKABLE void call();
private:
    void do_call();
};
