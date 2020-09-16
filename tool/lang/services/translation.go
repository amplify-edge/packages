package services

import (
	"log"
	"strings"
	"time"

	"github.com/bregydoc/gtranslate"
	"github.com/emirpasic/gods/maps/linkedhashmap"
)

// TranslatedMaps struct
type TranslatedMaps struct {
	Langs []string
	Maps  []*linkedhashmap.Map
}

// Translate struct
type Translate struct {
	Lang string
	// Words string
	Words []string
}

// ArbAttr struct
type ArbAttr struct {
	Description  string            `json:"description"`
	Type         string            `json:"type"`
	Placeholders map[string]string `json:"placeholders"`
}

// translate a string from languages to language
func getTemplateWords(m *linkedhashmap.Map, delay time.Duration, tries int, fromLang string, languages []string) ([]Translate, error) {
	words := getTranslateWords(m)
	var wordsTranslated []Translate
	for _, lang := range languages {
		t := Translate{}
		for _, w := range words {
			out, err := gtranslate.TranslateWithParams(w,
				gtranslate.TranslationParams{
					From:  fromLang,
					To:    lang,
					Tries: tries,
					Delay: delay,
				})
			if err != nil {
				log.Printf("Error to translate from %s to %s\n", fromLang, lang)
			}
			t.Words = append(t.Words, out)
		}
		t.Lang = lang
		wordsTranslated = append(wordsTranslated, t)
	}
	return wordsTranslated, nil
}

func getTranslatedMaps(WordsTranslated []Translate, m *linkedhashmap.Map, full bool) (*TranslatedMaps, error) {

	translatedMaps := &TranslatedMaps{}
	for _, tr := range WordsTranslated {
		mapLang := linkedhashmap.New()
		it := m.Iterator()
		i := 0
		for it.Next() {
			if !strings.HasPrefix(it.Key().(string), "@") {
				if len(tr.Words) > i {
					mapLang.Put(it.Key(), strings.TrimSpace(tr.Words[i]))
					i++
				}
			} else if full {
				mapLang.Put(it.Key(), it.Value())
			}
		}

		translatedMaps.Maps = append(translatedMaps.Maps, mapLang)
		translatedMaps.Langs = append(translatedMaps.Langs, tr.Lang)

	}
	return translatedMaps, nil
}

func getTranslateWords(m *linkedhashmap.Map) []string {
	it := m.Iterator()
	var out []string
	for it.Next() {
		if !strings.HasPrefix(it.Key().(string), "@") {
			v, ok := it.Value().(string)
			if ok {
				out = append(out, v)
			}
		}
	}
	return out
}
