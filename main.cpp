#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "RouteWriter.h"

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);

  qmlRegisterType<RouteWriter>("BackendImpls", 1, 0, "RouteWriter");

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  if (engine.rootObjects().isEmpty())
  {
      return -1;
  }

  return app.exec();
}
