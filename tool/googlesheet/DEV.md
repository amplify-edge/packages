# dev


## Libs

Flutter: https://github.com/aloisdeniel/flutter_sheet_localization

https://github.com/bratan/flutter_translate
- uses https://github.com/bratan/flutter_device_locale
https://github.com/bratan/flutter_translate_gen

Golang Gsheets: https://github.com/Iwark/spreadsheet/blob/v2/service.go




## Ops - Cloud run

Set it up to deploy on git commit.
https://cloud.google.com/run/docs/continuous-deployment-with-cloud-build



## Ops

ToDO

proper logging
"go.uber.org/zap"
https://github.com/knative/serving/blob/master/pkg/reconciler/autoscaling/hpa/hpa.go
- uses knative.dev/pkg/logging
https://github.com/knative/pkg/tree/master/metrics
https://github.com/knative/pkg/tree/master/logging


propper logging, tracing and metrics
https://github.com/jaegertracing/jaeger/tree/master/examples/hotrod
- this looks strong
- Here is how to setup the entry point: https://github.com/jaegertracing/jaeger/blob/master/examples/hotrod/cmd/root.go#L77