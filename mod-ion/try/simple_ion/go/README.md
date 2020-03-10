# simple_ion

This Go package implements the host-side of the Flutter [simple_ion](https://github.com/winwisely100/simple_ion) plugin.

## Usage

Import as:

```go
import simple_ion "github.com/winwisely100/simple_ion/go"
```

Then add the following option to your go-flutter [application options](https://github.com/go-flutter-desktop/go-flutter/wiki/Plugin-info):

```go
flutter.AddPlugin(&simple_ion.SimpleIonPlugin{}),
```
