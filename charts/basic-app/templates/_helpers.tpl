{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "basic-deployment.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "basic-deployment.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "basic-deployment.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "basic-deployment.labels" -}}
helm.sh/chart: {{ include "basic-deployment.chart" . }}
{{ include "basic-deployment.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "basic-deployment.selectorLabels" -}}
app: {{ include "basic-deployment.name" . }}
orleans/serviceId: {{ include "basic-deployment.name" . }}
orleans/clusterId: {{ include "basic-deployment.name" . }}
app.kubernetes.io/name: {{ include "basic-deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/instrumentation: "instrumentation-newrelic"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "basic-deployment.serviceAccountName" -}}
  {{- if .Values.serviceAccount }}
    {{- if .Values.serviceAccount.create }}
      {{- default (include "basic-deployment.fullname" .) .Values.serviceAccount.name }}
    {{- else }}
      {{- default "default" .Values.serviceAccount.name }}
    {{- end }}
  {{- else -}}
    "default"
  {{- end }}
{{- end }}
