package main

import ("github.com/dchenk/go-render-quill")

func main() {

	var delta = `[{"insert":"This "},{"attributes":{"italic":true},"insert":"is"},
{"insert":" "},{"attributes":{"bold":true},"insert":"great!"},{"insert":"\n"}]`

	html, err := quill.Render(delta)
	if err != nil {
		panic(err)
	}
	fmt.Println(string(html))
	// Output: <p>This <em>is</em> <strong>great!</strong></p>
}
