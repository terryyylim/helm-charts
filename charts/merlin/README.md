# merlin

---
![Version: 0.10.16](https://img.shields.io/badge/Version-0.10.16-informational?style=flat-square)
![AppVersion: v0.27.0-rc1](https://img.shields.io/badge/AppVersion-v0.27.0--rc1-informational?style=flat-square)

Kubernetes-friendly ML model management, deployment, and serving.

## Introduction

This Helm chart installs Merlin. I can also install the dependencies it requires, such as Kserve, MLP, etc.
See `Chart.yaml` for full list of dependencies.

## Prerequisites

To use the charts here, [Helm](https://helm.sh/) must be configured for your
Kubernetes cluster. Setting up Kubernetes and Helm is outside the scope of
this README. Please refer to the Kubernetes and Helm documentation.

- **Helm 3.0+** – This chart was tested with Helm v3.9.0, but it is also expected to work with earlier Helm versions
- **Kubernetes 1.22+** – This chart was tested with Kind v1.22.7 and minikube kubernetes version 1.22.*
- When installing on minikube, please run in a separate shell:
  ```sh
  minikube tunnel
  ```
  This is to enable istio loadbalancer services to be allocated an IP address.

## Installation

### Add Helm repository

```shell
helm repo add caraml https://caraml-dev.github.io/helm-charts
```

### Installing the chart

This command will install Merlin release named `merlin` in the `default` namespace.
Default chart values will be used for the installation:
```shell
$ helm install caraml/merlin
```

You can (and most likely, should) override the default configuration with values suitable for your installation.
Refer to [Configuration](#configuration) section for the detailed description of available configuration keys.

### Uninstalling the chart

To uninstall `merlin` release:
```shell
$ helm uninstall merlin
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
This includes the dependencies that were installed by the chart. Note that, any PVCs created by the chart will have to be deleted manually.

## Configuration

The following table lists the configurable parameters of the Merlin chart and their default values.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alerts.alertBranch | string | `"master"` |  |
| alerts.alertRepository | string | `"lens/artillery/datascience"` |  |
| alerts.alertsRepoPlatform | string | `"gitlab"` | Repository platform where the created Alerts and Dashboards need to be pushed. Platforms supported as of now: Gitlab |
| alerts.baseURL | string | `"https://gitlab.com/"` |  |
| alerts.dashboardBranch | string | `"master"` |  |
| alerts.dashboardRepository | string | `"data-science/slo-specs"` |  |
| alerts.enabled | bool | `false` | To enable/disable creation/modification of the alerts and dashboards for the deployed models via merlin. |
| alerts.warden.apiHost | string | `""` |  |
| authorization.enabled | bool | `true` |  |
| authorization.serverUrl | string | `"http://mlp-authorization-keto"` |  |
| deployment.image.pullPolicy | string | `"IfNotPresent"` |  |
| deployment.image.registry | string | `"ghcr.io"` |  |
| deployment.image.repository | string | `"caraml-dev/merlin"` |  |
| deployment.image.tag | string | `"0.27.0-rc1"` |  |
| deployment.labels | object | `{}` |  |
| deployment.podLabels | object | `{}` |  |
| deployment.replicaCount | string | `"2"` |  |
| deployment.resources.limits.cpu | string | `"1"` |  |
| deployment.resources.limits.memory | string | `"1Gi"` |  |
| deployment.resources.requests.cpu | string | `"500m"` |  |
| deployment.resources.requests.memory | string | `"1Gi"` |  |
| deployment.tolerations | list | `[]` |  |
| deploymentLabelPrefix | string | `"gojek.com/"` |  |
| encryption.key | string | `"password"` |  |
| environment | string | `"dev"` |  |
| environmentConfigs[0].cluster | string | `"test"` |  |
| environmentConfigs[0].default_deployment_config.cpu_request | string | `"500m"` |  |
| environmentConfigs[0].default_deployment_config.max_replica | int | `1` |  |
| environmentConfigs[0].default_deployment_config.memory_request | string | `"500Mi"` |  |
| environmentConfigs[0].default_deployment_config.min_replica | int | `0` |  |
| environmentConfigs[0].default_prediction_job_config.driver_cpu_request | string | `"2"` |  |
| environmentConfigs[0].default_prediction_job_config.driver_memory_request | string | `"2Gi"` |  |
| environmentConfigs[0].default_prediction_job_config.executor_cpu_request | string | `"2"` |  |
| environmentConfigs[0].default_prediction_job_config.executor_memory_request | string | `"2Gi"` |  |
| environmentConfigs[0].default_prediction_job_config.executor_replica | int | `3` |  |
| environmentConfigs[0].default_transformer_config.cpu_request | string | `"500m"` |  |
| environmentConfigs[0].default_transformer_config.max_replica | int | `1` |  |
| environmentConfigs[0].default_transformer_config.memory_request | string | `"500Mi"` |  |
| environmentConfigs[0].default_transformer_config.min_replica | int | `0` |  |
| environmentConfigs[0].deployment_timeout | string | `"10m"` |  |
| environmentConfigs[0].gcp_project | string | `"gcp-project"` |  |
| environmentConfigs[0].is_default | bool | `true` |  |
| environmentConfigs[0].is_default_prediction_job | bool | `true` |  |
| environmentConfigs[0].is_prediction_job_enabled | bool | `true` |  |
| environmentConfigs[0].k8s_config | object | `{}` |  |
| environmentConfigs[0].max_cpu | string | `"8"` |  |
| environmentConfigs[0].max_memory | string | `"8Gi"` |  |
| environmentConfigs[0].name | string | `"id-dev"` |  |
| environmentConfigs[0].namespace_timeout | string | `"2m"` |  |
| environmentConfigs[0].queue_resource_percentage | string | `"20"` |  |
| environmentConfigs[0].region | string | `"id"` |  |
| feastCoreApi.apiHost | string | `"http://feast-core.mlp:8080/v1"` |  |
| global.protocol | string | `"http"` |  |
| imageBuilder.baseImages."3.7.*".buildContextURI | string | `"git://github.com/gojek/merlin.git#refs/tags/v0.1"` |  |
| imageBuilder.baseImages."3.7.*".dockerfilePath | string | `"docker/Dockerfile"` |  |
| imageBuilder.baseImages."3.7.*".imageName | string | `"pyfunc-py37:v0.1.0"` |  |
| imageBuilder.baseImages."3.7.*".mainAppPath | string | `"/merlin-spark-app/main.py"` |  |
| imageBuilder.clusterName | string | `"test"` |  |
| imageBuilder.dockerRegistry | string | `"dockerRegistry"` |  |
| imageBuilder.k8sConfig | string | `""` |  |
| imageBuilder.kanikoImage | string | `"gcr.io/kaniko-project/executor:v1.6.0"` |  |
| imageBuilder.maxRetry | int | `3` |  |
| imageBuilder.namespace | string | `"mlp"` |  |
| imageBuilder.nodeSelectors | object | `{}` |  |
| imageBuilder.predictionJobBaseImages."3.7.*".buildContextURI | string | `"git://github.com/gojek/merlin.git#refs/tags/v0.1"` |  |
| imageBuilder.predictionJobBaseImages."3.7.*".dockerfilePath | string | `"docker/app.Dockerfile"` |  |
| imageBuilder.predictionJobBaseImages."3.7.*".imageName | string | `"pyspark-py37:v0.1.0"` |  |
| imageBuilder.predictionJobBaseImages."3.7.*".mainAppPath | string | `"/merlin-spark-app/main.py"` |  |
| imageBuilder.predictionJobContextSubPath | string | `""` |  |
| imageBuilder.resources.limits.cpu | string | `"1"` |  |
| imageBuilder.resources.limits.memory | string | `"1Gi"` |  |
| imageBuilder.resources.requests.cpu | string | `"1"` |  |
| imageBuilder.resources.requests.memory | string | `"512Mi"` |  |
| imageBuilder.retention | string | `"48h"` |  |
| imageBuilder.safeToEvict | bool | `false` |  |
| imageBuilder.serviceAccount.annotations | object | `{}` |  |
| imageBuilder.serviceAccount.create | bool | `true` |  |
| imageBuilder.serviceAccount.labels | object | `{}` |  |
| imageBuilder.serviceAccount.name | string | `"kaniko"` |  |
| imageBuilder.timeout | string | `"30m"` |  |
| imageBuilder.tolerations | list | `[]` |  |
| ingress.enabled | bool | `false` |  |
| kserve.chartValues.knativeServingIstio.chartValues.istioIngressGateway.helmChart.namespace | string | `"istio-system"` |  |
| kserve.enabled | bool | `true` |  |
| kserve.helmChart.chart | string | `"kserve"` |  |
| kserve.helmChart.createNamespace | bool | `true` |  |
| kserve.helmChart.namespace | string | `"kserve"` |  |
| kserve.helmChart.release | string | `"kserve"` |  |
| kserve.helmChart.repository | string | `"https://caraml-dev.github.io/helm-charts"` |  |
| kserve.helmChart.version | string | `"0.8.20"` |  |
| kserve.hook.weight | string | `"-2"` |  |
| loggerDestinationURL | string | `"http://yourDestinationLogger"` |  |
| merlin-postgresql.enabled | bool | `true` |  |
| merlin-postgresql.persistence.size | string | `"10Gi"` |  |
| merlin-postgresql.postgresqlDatabase | string | `"merlin"` |  |
| merlin-postgresql.postgresqlUsername | string | `"merlin"` |  |
| merlin-postgresql.resources.requests.cpu | string | `"100m"` |  |
| merlin-postgresql.resources.requests.memory | string | `"512Mi"` |  |
| merlinExternalPostgresql.address | string | `"127.0.0.1"` | Host address for the External postgres |
| merlinExternalPostgresql.connMaxIdleTime | string | `"0s"` | Connection pooling settings |
| merlinExternalPostgresql.connMaxLifetime | string | `"0s"` |  |
| merlinExternalPostgresql.createSecret | bool | `false` | Enable this if you need the chart to create a secret when you provide the password above. |
| merlinExternalPostgresql.database | string | `"merlin"` | External postgres database schema |
| merlinExternalPostgresql.enableProxySidecar | bool | `false` | Enable if you want to configure a sidecar for creating a proxy for your db connections. |
| merlinExternalPostgresql.enabled | bool | `false` | If you would like to use an external postgres database, enable it here using this |
| merlinExternalPostgresql.maxIdleConns | int | `0` |  |
| merlinExternalPostgresql.maxOpenConns | int | `0` |  |
| merlinExternalPostgresql.password | string | `"password"` |  |
| merlinExternalPostgresql.proxyType | string | `"cloudSqlProxy"` | Type of sidecar to be created, mentioned type needs to have the spec below. |
| merlinExternalPostgresql.secretKey | string | `""` | If a secret is created by external systems (eg. Vault)., mention the key under which password is stored in secret (eg. postgresql-password) |
| merlinExternalPostgresql.secretName | string | `""` | If a secret is created by external systems (eg. Vault)., mention the secret name here |
| merlinExternalPostgresql.sidecarSpec | object | `{"cloudSqlProxy":{"dbConnectionName":"asia-east-1:merlin-db","dbPort":5432,"image":{"tag":"1.33.2"},"resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"spec":[{"command":["/cloud_sql_proxy","-ip_address_types=PRIVATE","-log_debug_stdout","-instances={{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.dbConnectionName }}=tcp:{{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.dbPort }}"],"image":"gcr.io/cloudsql-docker/gce-proxy:{{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.image.tag }}","name":"cloud-sql-proxy","resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"securityContext":{"runAsNonRoot":true}}]}}` | container spec for the sidecar |
| merlinExternalPostgresql.sidecarSpec.cloudSqlProxy | object | `{"dbConnectionName":"asia-east-1:merlin-db","dbPort":5432,"image":{"tag":"1.33.2"},"resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"spec":[{"command":["/cloud_sql_proxy","-ip_address_types=PRIVATE","-log_debug_stdout","-instances={{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.dbConnectionName }}=tcp:{{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.dbPort }}"],"image":"gcr.io/cloudsql-docker/gce-proxy:{{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.image.tag }}","name":"cloud-sql-proxy","resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"securityContext":{"runAsNonRoot":true}}]}` | container spec for the Google CloudSQL auth proxy sidecar, ref: https://cloud.google.com/sql/docs/postgres/connect-kubernetes-engine |
| merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.spec | list | `[{"command":["/cloud_sql_proxy","-ip_address_types=PRIVATE","-log_debug_stdout","-instances={{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.dbConnectionName }}=tcp:{{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.dbPort }}"],"image":"gcr.io/cloudsql-docker/gce-proxy:{{ .Values.merlinExternalPostgresql.sidecarSpec.cloudSqlProxy.image.tag }}","name":"cloud-sql-proxy","resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"securityContext":{"runAsNonRoot":true}}]` | Container spec for the sidecar |
| merlinExternalPostgresql.username | string | `"merlin"` | External postgres database user |
| minio.chartValues.defaultBucket.enabled | bool | `true` |  |
| minio.chartValues.defaultBucket.name | string | `"mlflow"` |  |
| minio.chartValues.ingress.annotations."kubernetes.io/ingress.class" | string | `"istio"` |  |
| minio.chartValues.ingress.enabled | bool | `false` |  |
| minio.chartValues.ingress.path | string | `"/*"` |  |
| minio.chartValues.livenessProbe.initialDelaySeconds | int | `30` |  |
| minio.chartValues.persistence.enabled | bool | `false` |  |
| minio.chartValues.replicas | int | `1` |  |
| minio.chartValues.resources.requests.cpu | string | `"25m"` |  |
| minio.chartValues.resources.requests.memory | string | `"64Mi"` |  |
| minio.enabled | bool | `true` |  |
| minio.helmChart.chart | string | `"minio"` |  |
| minio.helmChart.createNamespace | bool | `true` |  |
| minio.helmChart.namespace | string | `"minio"` |  |
| minio.helmChart.release | string | `"minio"` |  |
| minio.helmChart.repository | string | `"https://helm.min.io/"` |  |
| minio.helmChart.version | string | `"7.0.4"` |  |
| minio.hook.weight | string | `"-2"` |  |
| mlflow-postgresql.enabled | bool | `true` |  |
| mlflow-postgresql.persistence.enabled | bool | `true` |  |
| mlflow-postgresql.persistence.size | string | `"10Gi"` |  |
| mlflow-postgresql.postgresqlDatabase | string | `"mlflow"` |  |
| mlflow-postgresql.postgresqlUsername | string | `"mlflow"` |  |
| mlflow-postgresql.replicaCount | int | `1` |  |
| mlflow-postgresql.resources.requests.cpu | string | `"500m"` |  |
| mlflow-postgresql.resources.requests.memory | string | `"512Mi"` |  |
| mlflow.artifactRoot | string | `"/data/artifacts"` |  |
| mlflow.deploymentLabels | object | `{}` |  |
| mlflow.extraEnvs | object | `{}` |  |
| mlflow.host | string | `"0.0.0.0"` |  |
| mlflow.image.pullPolicy | string | `"Always"` |  |
| mlflow.image.registry | string | `"ghcr.io"` |  |
| mlflow.image.repository | string | `"gojek/mlflow"` |  |
| mlflow.image.tag | string | `"1.3.0"` |  |
| mlflow.ingress.class | string | `"nginx"` |  |
| mlflow.ingress.enabled | bool | `false` |  |
| mlflow.livenessProbe.initialDelaySeconds | int | `30` |  |
| mlflow.livenessProbe.periodSeconds | int | `10` |  |
| mlflow.livenessProbe.successThreshold | int | `1` |  |
| mlflow.livenessProbe.timeoutSeconds | int | `30` |  |
| mlflow.name | string | `"mlflow"` |  |
| mlflow.podLabels | object | `{}` |  |
| mlflow.readinessProbe.initialDelaySeconds | int | `30` |  |
| mlflow.readinessProbe.periodSeconds | int | `10` |  |
| mlflow.readinessProbe.successThreshold | int | `1` |  |
| mlflow.readinessProbe.timeoutSeconds | int | `30` |  |
| mlflow.replicaCount | int | `1` |  |
| mlflow.resources.limits.memory | string | `"2048Mi"` |  |
| mlflow.resources.requests.cpu | string | `"500m"` |  |
| mlflow.resources.requests.memory | string | `"512Mi"` |  |
| mlflow.rollingUpdate.maxSurge | int | `1` |  |
| mlflow.rollingUpdate.maxUnavailable | int | `0` |  |
| mlflow.service.externalPort | int | `80` |  |
| mlflow.service.internalPort | int | `5000` |  |
| mlflow.service.type | string | `"ClusterIP"` |  |
| mlflow.serviceAccount.annotations | object | `{}` |  |
| mlflow.serviceAccount.create | bool | `true` |  |
| mlflow.serviceAccount.name | string | `"mlflow"` |  |
| mlflow.statefulset.updateStrategy | string | `"RollingUpdate"` |  |
| mlflow.tolerations | list | `[]` |  |
| mlflow.trackingURL | string | `"http://www.example.com"` |  |
| mlflowExternalPostgresql.address | string | `"127.0.0.1"` | Host address for the External postgres |
| mlflowExternalPostgresql.createSecret | bool | `false` | Enable this if you need the chart to create a secret when you provide the password above. |
| mlflowExternalPostgresql.database | string | `"mlflow"` | External postgres database schema |
| mlflowExternalPostgresql.enableProxySidecar | bool | `false` | Enable if you want to configure a sidecar for creating a proxy for your db connections. |
| mlflowExternalPostgresql.enabled | bool | `false` | If you would like to use an external postgres database, enable it here using this |
| mlflowExternalPostgresql.password | string | `"password"` |  |
| mlflowExternalPostgresql.proxyType | string | `"cloudSqlProxy"` | Type of sidecar to be created, mentioned type needs to have the spec below. |
| mlflowExternalPostgresql.secretKey | string | `""` | If a secret is created by external systems (eg. Vault)., mention the key under which password is stored in secret (eg. postgresql-password) |
| mlflowExternalPostgresql.secretName | string | `""` | If a secret is created by external systems (eg. Vault)., mention the secret name here |
| mlflowExternalPostgresql.sidecarSpec | object | `{"cloudSqlProxy":{"dbConnectionName":"asia-east-1:mlflow-db","dbPort":5432,"image":{"tag":"1.33.2"},"resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"spec":[{"command":["/cloud_sql_proxy","-ip_address_types=PRIVATE","-log_debug_stdout","-instances={{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.dbConnectionName }}=tcp:{{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.dbPort }}"],"image":"gcr.io/cloudsql-docker/gce-proxy:{{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.image.tag }}","name":"cloud-sql-proxy","resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"securityContext":{"runAsNonRoot":true}}]}}` | container spec for the sidecar |
| mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy | object | `{"dbConnectionName":"asia-east-1:mlflow-db","dbPort":5432,"image":{"tag":"1.33.2"},"resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"spec":[{"command":["/cloud_sql_proxy","-ip_address_types=PRIVATE","-log_debug_stdout","-instances={{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.dbConnectionName }}=tcp:{{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.dbPort }}"],"image":"gcr.io/cloudsql-docker/gce-proxy:{{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.image.tag }}","name":"cloud-sql-proxy","resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"securityContext":{"runAsNonRoot":true}}]}` | container spec for the Google CloudSQL auth proxy sidecar, ref: https://cloud.google.com/sql/docs/postgres/connect-kubernetes-engine |
| mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.spec | list | `[{"command":["/cloud_sql_proxy","-ip_address_types=PRIVATE","-log_debug_stdout","-instances={{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.dbConnectionName }}=tcp:{{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.dbPort }}"],"image":"gcr.io/cloudsql-docker/gce-proxy:{{ .Values.mlflowExternalPostgresql.sidecarSpec.cloudSqlProxy.image.tag }}","name":"cloud-sql-proxy","resources":{"limits":{"cpu":"1000m","memory":"1G"},"requests":{"cpu":"200m","memory":"512Mi"}},"securityContext":{"runAsNonRoot":true}}]` | Container spec for the sidecar |
| mlflowExternalPostgresql.username | string | `"mlflow"` | External postgres database user |
| mlp.enabled | bool | `true` |  |
| mlp.environmentConfigSecret.name | string | `""` |  |
| mlpApi.apiHost | string | `"http://mlp.mlp:8080/v1"` |  |
| mlpApi.encryptionKey | string | `"secret-encryption"` |  |
| monitoring.enabled | bool | `false` |  |
| newrelic.appname | string | `"merlin-api-dev"` |  |
| newrelic.enabled | bool | `false` |  |
| newrelic.licenseSecretName | string | `"newrelic-license-secret"` |  |
| pyfuncGRPCOptions | string | `"{}"` |  |
| queue.numOfWorkers | int | `1` |  |
| sentry.dsn | string | `""` |  |
| sentry.enabled | bool | `false` |  |
| service.externalPort | int | `8080` |  |
| service.internalPort | int | `8080` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"merlin"` |  |
| swagger.apiHost | string | `"merlin.dev"` |  |
| swagger.basePath | string | `"/api/merlin/v1"` |  |
| swagger.enabled | bool | `true` |  |
| swagger.image.tag | string | `"v3.23.5"` |  |
| swagger.service.externalPort | int | `8080` |  |
| swagger.service.internalPort | int | `8081` |  |
| transformer.feast.authEnabled | bool | `false` |  |
| transformer.feast.bigtableCredential | string | `nil` |  |
| transformer.feast.coreAuthAudience | string | `"core.feast.dev"` |  |
| transformer.feast.coreURL | string | `"core.feast.dev"` |  |
| transformer.feast.defaultFeastSource | string | `"BIGTABLE"` |  |
| transformer.feast.defaultServingURL | string | `"online-serving-redis.feast.dev"` |  |
| transformer.feast.grpc.keepAliveEnabled | bool | `false` |  |
| transformer.feast.grpc.keepAliveTime | string | `"60s"` |  |
| transformer.feast.grpc.keepAliveTimeout | string | `"5s"` |  |
| transformer.feast.servingURLs[0].host | string | `"online-serving-redis.feast.dev"` |  |
| transformer.feast.servingURLs[0].icon | string | `"redis"` |  |
| transformer.feast.servingURLs[0].label | string | `"Online Serving with Redis"` |  |
| transformer.feast.servingURLs[0].source_type | string | `"REDIS"` |  |
| transformer.feast.servingURLs[1].host | string | `"online-serving-bigtable.feast.dev"` |  |
| transformer.feast.servingURLs[1].icon | string | `"bigtable"` |  |
| transformer.feast.servingURLs[1].label | string | `"Online Serving with BigTable"` |  |
| transformer.feast.servingURLs[1].source_type | string | `"BIGTABLE"` |  |
| transformer.image | string | `"merlin-transformer:1.0.0"` |  |
| transformer.jaeger.agentHost | string | `"localhost"` |  |
| transformer.jaeger.agentPort | int | `6831` |  |
| transformer.jaeger.disabled | bool | `false` |  |
| transformer.jaeger.samplerParam | int | `1` |  |
| transformer.jaeger.samplerType | string | `"const"` |  |
| transformer.kafka.brokers | string | `"kafka-brokers"` |  |
| transformer.kafka.maxMessageSize | string | `"1048588"` |  |
| transformer.model.grpc.keepAliveEnabled | bool | `false` |  |
| transformer.model.grpc.keepAliveTime | string | `"60s"` |  |
| transformer.model.grpc.keepAliveTimeout | string | `"5s"` |  |
| transformer.simulation.feastBigtableServingURL | string | `"online-serving-bt.feast.dev"` |  |
| transformer.simulation.feastRedisServingURL | string | `"online-serving-redis.feast.dev"` |  |
| ui.apiHost | string | `"/api/merlin/v1"` |  |
| ui.dockerRegistries | string | `"ghcr.io/gojek,ghcr.io/your-company"` | Comma-separated value of Docker registries that can be chosen in deployment page |
| ui.docsURL[0].href | string | `"https://github.com/gojek/merlin/blob/main/docs/getting-started/README.md"` |  |
| ui.docsURL[0].label | string | `"Getting Started with Merlin"` |  |
| ui.homepage | string | `"/merlin"` |  |
| ui.maxAllowedReplica | int | `20` |  |
| ui.mlp.apiHost | string | `"/api/v1"` |  |
| ui.oauthClientID | string | `""` |  |
| ui.upiDocURL | string | `"https://github.com/caraml-dev/universal-prediction-interface/blob/main/docs/api_markdown/caraml/upi/v1/index.md"` |  |
