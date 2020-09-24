package main

import (
	"fmt"
	"log"
	"net/http"
	"text/template"

	man "github.com/getcouragenow/packages/tool/bs-box/mod01/internal"
	"github.com/getcouragenow/packages/tool/bs-box/mod01/internal/box"
)

// PageData structure
type PageData struct {
	Title       string
	Heading     string
	Description string
}

func main() {

	// Embed
	fmt.Print("index: ", man.CONST_index_html)
	index := string(box.Get(man.CONST_index_html))

	// Template
	tmpl := template.Must(template.New("").Parse(index))

	// Handle function
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := PageData{
			Title:       "The easiest way to embed static files into a binary file",
			Heading:     "This is easiest way",
			Description: "My life credo is 'If you can not use N, do not use N'.",
		}

		// Execute template with data
		if err := tmpl.Execute(w, data); err != nil {
			log.Fatal(err)
		}
	})

	// Start server
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
