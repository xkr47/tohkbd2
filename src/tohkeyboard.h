/*
 * (C) 2014 Kimmo Lindholm <kimmo.lindholm@gmail.com> Kimmoli
 *
 */

#ifndef TOHKEYBOARD_H
#define TOHKEYBOARD_H

#include <QtCore/QObject>
#include <QtDBus/QtDBus>

#include <QTime>
#include <QTimer>
#include <QThread>
#include "worker.h"
#include <QList>
#include <QPair>

#include "uinputif.h"

#include "tca8424driver.h"
#include "keymapping.h"

#include <mlite5/MGConfItem>

#define SERVICE_NAME "com.kimmoli.tohkbd2"
#define EVDEV_OFFSET (8)

/* main class */

class QDBusInterface;
class Tohkbd: public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", SERVICE_NAME)

public:
    explicit Tohkbd(QObject *parent = 0);
    virtual ~Tohkbd();

    void registerDBus();

public slots:
    /* dbus signal handler slots */
    void handleDisplayStatus(const QDBusMessage& msg);

    /* keymap handler slots */
    void handleShiftChanged();
    void handleCtrlChanged();
    void handleAltChanged();
    void handleSymChanged();
    void handleKeyPressed(QList< QPair<int, int> > keyCode);

    /* timer timeouts */
    void backlightTimerTimeout();
    void presenceTimerTimeout();

    /* Interrupt */
    void handleGpioInterrupt();

    /* DBUS methods */
    void fakeInputReport(const QByteArray &data);
    QString getVersion();
    void quit();

signals:

    void keyboardConnectedChanged(bool);

private:

    QString readOneLineFromFile(QString name);
    void checkDoWeNeedBacklight();
    QList<unsigned int> readEepromConfig();
    void changeActiveLayout(bool justGetIt = false);
    bool setVddState(bool state);
    bool setInterruptEnable(bool);
    void emitKeypadSlideEvent(bool openKeypad);
    bool checkKeypadPresence();
    void reloadSettings();
    void writeSettings();

    int gpio_fd;

    QThread *thread;
    Worker *worker;
    UinputIf *uinputif;
    tca8424driver *tca8424;
    keymapping *keymap;

    int capsLockSeq;

    QMutex mutex;

    QTimer *backlightTimer;
    QTimer *presenceTimer;

    QString currentActiveLayout;

    bool keypadIsPresent;
    bool vkbLayoutIsTohkbd;
    bool dbusRegistered;
    bool stickyCtrl;
    bool displayIsOn;
    bool vddEnabled;
    bool interruptsEnabled;

};



#endif // TOHKEYBOARD_H