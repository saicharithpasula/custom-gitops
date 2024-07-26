{{- define "setReplicas" -}}
{{- $containers := index . "containers" -}}
{{- $wlSpecs := index . "wlSpecs" -}}
{{- range $containerName, $containerData := $containers }}
    {{- if and ($wlSpecs) ($containerData.workload) }}
    {{- $replicaCount := index $wlSpecs $containerData.workload  "wl_units"  }}
replicas: {{ $replicaCount }}
    {{- end }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "std-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "std-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "std-helm.labels" -}}
helm.sh/chart: {{ include "std-helm.chart" . }}
{{ include "std-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "std-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "std-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}