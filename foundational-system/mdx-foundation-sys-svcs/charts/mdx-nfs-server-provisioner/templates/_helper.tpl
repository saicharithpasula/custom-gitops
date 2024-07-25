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