# Dev

https://github.com/memspace/zefyr

https://medium.com/@pulyaevskiy/announcing-zefyr-a-soft-and-gentle-rich-text-editor-for-flutter-1c7c208bdf71



## examples

- https://github.com/search?o=desc&q=zefyr&s=updated&type=Repositories

- https://github.com/YashBhalodi/text_editor
	- nice
- 


## TODO's

sync

- Simple IT#s: https://github.com/pulyaevskiy/quill-delta-dart/blob/master/example/main.dart

- support quilljs and so we can run a sync server Or use it P2P as quill is designed based on OT ( operational transforms) and so the converges naturally.


- Quill implemenations in go: https://github.com/search?utf8=%E2%9C%93&q=quill+language%3AGo&type=Repositories&ref=advsearch&l=Go&l=
- https://github.com/fmpwizard/go-quilljs-delta
	- not reused
- https://github.com/dchenk/go-render-quill
	- Others using it:
	- https://github.com/dchenk/mazewire
		- looks ok.
	- https://github.com/tacusci/berrycms/blob/master/web/db_pages.go
		- Full CMS :)
		- Looks like a good basis also.
		- He uses OpenAPI to describe his types. We can convert to GRPC using https://github.com/googleapis/gnostic :)

Cursors

- Known as RTT ( Real Time Test) where you can see as the other types.

Data Store

- Images and data.
- Use Hive. Examples in Mains repo.
- See the GSheet tool in the Bootstrap repo to see how to boot push data in and out.

Printing

- Supports markdown, and so can then print via markdown to PDF.

- It allows printing via conversion to Markdown and then conversion to PDF and then sending to the PDF Plugin in the Plugin repo.



