#include "RouteWriter.h"

#include <QDir>
#include <QFile>
#include <QDebug>

RouteWriter::RouteWriter(QObject* parent) : QObject(parent)
{

}

QVariantList const& RouteWriter::routeCounts() const
{
    return m_routeCounts;
}

QString const& RouteWriter::folder() const
{
    return m_folder;
}

void RouteWriter::createRoute(qreal startX, qreal startY)
{
    m_routes << Route();
    m_routeCounts << 0;

    addPointToLastRoute(startX, startY);
}

void RouteWriter::addPointToLastRoute(qreal x, qreal y)
{
    m_routes.last() << QPointF(x, y);
    m_routeCounts.last() =  m_routes.last().size();

    emit routeCountsChanged(routeCounts());
}

void RouteWriter::writeToFiles()
{
    static QString S_FORMAT_FILE = "%1.csv";

    auto dir = QDir::current();
    if (!dir.cd(folder()))
    {
        dir.mkdir(folder());
        dir.cd(folder());
    }

    for (int i = 0; i < m_routes.size(); i++)
    {
        QString fileName = dir.filePath(S_FORMAT_FILE.arg(i));
        QFile file(fileName);

        bool opened = file.open(QIODevice::WriteOnly | QIODevice::Text);
        if (!opened)
        {
            qFatal("Cannot open file for write");
        }

        QTextStream out(&file);

        for (auto const& point : m_routes[i])
        {
            out << point.x() << ", " << point.y() << endl;
        }
    }
}

void RouteWriter::clear()
{
    m_routes.clear();
    m_routeCounts.clear();

    emit routeCountsChanged(routeCounts());
}

void RouteWriter::setFolder(QString const& folder)
{
    if (m_folder == folder)
    {
        return;
    }

    m_folder = folder;
    emit folderChanged(m_folder);
}
