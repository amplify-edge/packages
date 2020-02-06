# i18n

Works with the golang tool and mage in bootstrap.

We need this to be very reusable.

Packages will need to have pre-translated dart code accoridng to the Flutter way so that Mains get to use them automatically.

Example basis of official Flutter way

https://github.com/go-flutter-desktop/examples/tree/master/stocks/lib/i18n

https://github.com/flutter/flutter/tree/master/dev/benchmarks/test_apps/stocks

---

We still need to support parameterised trans, like gender, etc as found in the google sheets.

The google sheets approach is not going away. It will likely be used for MAIN where there is LOTS of special terms and non technical users.
The new way using a gtranslate is useful for Packages.

# Flow

Unidirectional is best.

Gen the EN CSV
- From what ? Nothing i think.
- Dev has to edit this as they make GUI and keep synced.

Run the CSV trans
- this will look in the EN CSV and then gen the other language files as CSV
- We still need to support the GSHeet approach BTW. But wont be using it for a while.

Compare the CSV
- We need to be able to se what is and IS NOT translated
- Output as JSON so CI can run it too.
- Output for CLI.

Gen the ARB
- From the CSV, can then gen the ARB json which is the Offical Flutter way.

Gen the Dart
- Then from the ARB JSON, the standard flutter tools gen the Strongly typed class.




## Other

Uses a golang tools to do the trans locally without gsheets.
- https://github.com/bregydoc/gtranslate
- store overrides also.
- store as CSV
- so its all just stored in github now.

Test Harness should be here in this repo.
- Shows off how it works so hat MAIN devs can see and we can run CI and also check.

## Providence

When your looking at a GUI its hard to track back to the original CSV.

- We should try to embed the CSV and line number into the generated Dart code.
	- Not sure how to do this yet.
- In the GUI Settings we can turn this on and show for any Text where it came from.


# User GUI for Main

- already working the the current main !
- BUT needs to be broken out properly for reuse across flutter MAINS.
- that detects device locale
- in settings shows it and allows override ( good for testing ).
