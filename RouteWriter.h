#ifndef ROUTEWRITER_H
#define ROUTEWRITER_H

#include <QObject>
#include <QPointF>
#include <QVariantList>

class RouteWriter : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList routeCounts READ routeCounts NOTIFY routeCountsChanged)
    Q_PROPERTY(QString folder READ folder WRITE setFolder NOTIFY folderChanged)

public:
    explicit RouteWriter(QObject* parent = nullptr);

    QVariantList const& routeCounts() const;
    QString const& folder() const;

public slots:
    void createRoute(qreal startX, qreal startY);
    void addPointToLastRoute(qreal x, qreal y);

    void writeToFiles();
    void clear();
    void setFolder(QString const& folder);

signals:
    void routeCountsChanged(QVariantList const& routeCounts);
    void folderChanged(QString folder);

private:
    using Route = QList<QPointF>;

    QList<Route> m_routes{};

    QVariantList m_routeCounts{};
    QString m_folder;
};

#endif // ROUTEWRITER_H
