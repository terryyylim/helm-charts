{{/* vim: set filetype=mustache: */}}


{{/*
Generated names
*/}}


{{/*
Expand the name of the chart.
*/}}
{{- define "mlp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mlp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mlp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mlp.resource-prefix-with-release-name" -}}
    {{- (include "mlp.fullname" .) -}}
{{- end -}}

{{- define "mlp.resource-prefix" -}}
    {{- (include "mlp.name" .) -}}
{{- end -}}

{{- define "mlp.config-cm-name" -}}
    {{- printf "%s-config" (include "mlp.resource-prefix-with-release-name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mlp.encryption-key-name" -}}
    {{- printf "%s-encryption-key" (include "mlp.resource-prefix-with-release-name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mlp.labels" -}}
app.kubernetes.io/name: {{ template "mlp.name" . }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: caraml
{{- end }}


{{- define "authorization.server.url" -}}
    {{- $protocol := (default "http" .Values.global.protocol ) }}
    {{- $globalAuthzUrl := "" }}
    {{- if and .Values.global (hasKey .Values.global "authz") }}
        {{- if .Values.global.authz.serviceName }}
            {{- $globalAuthzUrl = (printf "%s://%s" $protocol (include "common.get-component-value" (list .Values.global "authz" (list "serviceName")))) }}
        {{- end }}
    {{- end }}
    {{- printf "%s" (include "common.set-value" (list .Values.deployment.authorization.serverUrl $globalAuthzUrl)) -}}
{{- end -}}

{{- define "mlp.deployment.applications" -}}
    {{- $globFeastApi := include "common.get-component-value" (list .Values.global "feast" (list "vsPrefix" "apiPrefix")) }}
    {{- $globMerlinApi := include "common.get-component-value" (list .Values.global "merlin" (list "vsPrefix" "apiPrefix")) }}
    {{- $globTuringApi := include "common.get-component-value" (list .Values.global "turing" (list "vsPrefix" "apiPrefix")) }}
    {{- $globFeastUI := include "common.get-component-value" (list .Values.global "feast" (list "uiPrefix")) }}
    {{- $globMerlinUI := include "common.get-component-value" (list .Values.global "merlin" (list "uiPrefix")) }}
    {{- $globTuringUI := include "common.get-component-value" (list .Values.global "turing" (list "uiPrefix")) }}
    {{- $applications := default (list) .Values.deployment.applications -}}
    {{- $modifiedApps := (list) -}}
    {{- range $applications -}}
        {{- $name := .name -}}
        {{- $homepage := .homepage -}}
        {{- $api := .configuration.api -}}
        {{- if eq $name "Merlin" -}}
            {{- $homepage = include "common.set-value" (list .homepage $globMerlinUI) -}}
            {{- $api = include "common.set-value" (list $api $globMerlinApi) -}}
        {{- else if eq $name "Turing" -}}
            {{- $homepage = include "common.set-value" (list .homepage $globTuringUI) -}}
            {{- $api = include "common.set-value" (list $api $globTuringApi) -}}
        {{- else if eq $name "Feast" -}}
            {{- $homepage = include "common.set-value" (list .homepage $globFeastUI) -}}
            {{- $api = include "common.set-value" (list $api $globFeastApi) -}}
        {{- end -}}
        {{- $_ := set . "homepage" $homepage -}}
        {{- $_ := set .configuration "api" $api -}}
    {{- end -}}
    {{ toYaml $applications }}
{{- end -}}
