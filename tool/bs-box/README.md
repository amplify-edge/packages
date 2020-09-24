# Embed

This is a build tool to embed files to make multi-module development more sane.

At Gen Time,  it embeds assets to be used at Build Time.
At Build Time, it embeds assets to be used at Runtime

Its only uses go generator mechanisms, and so is easy to use.

Higher level modules will need to unpack assets to disk.

	1. At Build Time, like flutter lang json files that need to be on disk in maintemplate.
	2. At Runtime, like golang Data and SQL.

	So, at flutter layer, after a Flutter Module is built they Box up the lang json files.
	Then maintemplate will unpack them before it builds builds

	So then we have two phases of boxing:
	A. Gen Time. when a Flutter module gens its shared assets (like lang), it boxes them into a golang box.
		This is called by Maintemplate, and recursively its imports do their Gen.
		Then Maintemplate, unpacks them onto disk where it needs them.
	B. Build Time, when a Golang module, boxes its assets that will be used at Runtime
		This is embedded by Maintemplate, and it can use them at Runtime.


