# Telemetry

Its vital to hav this in place because otherwise you will have no idea that your app is crashing ( except bad reviews on the app stores) and you will have no way to fix the crashes or performance issues.

Crash reporting

Logging

Metrics

Sentry

- https://github.com/flutter/sentry
	- by google team !!
	- examples:
		- https://pub.dev/packages/sentry_lumberdash
			- https://pub.dev/packages/lumberdash
				- Can log to many different sinks which is exactly what we need. 
					- https://pub.dev/packages?q=dependency%3Alumberdash
					- DOES NOT log to local file system, so i suggested HIVE: https://github.com/bmw-tech/lumberdash/issues/24
				


- self hosting: https://github.com/getsentry/onpremise
	- pything and docker. run on google cloud

- logging: https://github.com/wrike/logging_service
	- flutter works on web !

- crash reporting: 
	- https://github.com/jhomlala/catcher
		- NOPE has native dependencies
	-