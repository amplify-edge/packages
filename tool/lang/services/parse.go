package services

import (
	"github.com/emirpasic/gods/maps/linkedhashmap"
)

// JSONMap convert json to arb
func JSONMap(data []byte) (*linkedhashmap.Map, error) {
	m := linkedhashmap.New()

	err := m.FromJSON(data)

	if err != nil {
		return nil, err
	}

	it := m.Iterator()
	out := linkedhashmap.New()

	for it.Next() {
		key := it.Key().(string)
		keyExists := "@" + key

		_, ok := m.Get(keyExists)
		if !ok {
			item := ArbAttr{
				Description:  "",
				Type:         "text",
				Placeholders: make(map[string]string),
			}
			out.Put(it.Key(), it.Value())
			out.Put(keyExists, item)
		} else {
			out.Put(it.Key(), it.Value())
		}
	}
	return out, nil
}
