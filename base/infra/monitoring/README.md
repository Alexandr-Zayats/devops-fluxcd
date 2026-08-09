Requirements
 Use an existing data source:
 VictoriaMetrics / Prometheus

Architecture Overview:

[Exporter or Native /metrics] 
        ↓
[VMServiceScrape / VMPodScrape] 
        ↓
[vmagent] 
        ↓
[vmcluster] 
        ↓
[Grafana Dashboard]

Documentation Links
VictoriaMetrics

vmagent scraping:
https://docs.victoriametrics.com/vmagent/

VMServiceScrape (scrape by service):
https://docs.victoriametrics.com/operator/resources/vmservicescrape/

VMPodScrape (scrape by pods):
https://docs.victoriametrics.com/operator/resources/vmpodscrape/

CloudWatch integration (RDS, ElastiCache, etc.):
https://docs.victoriametrics.com/scrape/cloudwatch/


RDS Monitoring
CloudWatch → vmagent
CloudWatch Metrics List (RDS):
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MonitoringOverview.html

vmagent CloudWatch Scraping:
https://docs.victoriametrics.com/victoriametrics-cloud/integrations/cloudwatch/


Redis Monitoring
Redis Exporter:
https://github.com/oliver006/redis_exporter

Redis metrics reference:
https://redis.io/docs/latest/operate/monitor/metrics/

Helm chart:
https://artifacthub.io/packages/helm/prometheus-community/prometheus-redis-exporter

Memcached Monitoring
Memcached Exporter:
https://github.com/prometheus/memcached_exporter

Helm chart:
https://artifacthub.io/packages/helm/prometheus-community/prometheus-memcached-exporter

RabbitMQ Monitoring
builtin Prometheus plugin

RabbitMQ Prometheus metrics:
https://www.rabbitmq.com/docs/prometheus

RabbitMQ Exporter:
https://github.com/kbudde/rabbitmq_exporter

Создать VMServiceScrape для каждого сервиса
