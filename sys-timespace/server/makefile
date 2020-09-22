DATA_TMP_FSPATH=$(PWD)/data-tmp

mledoze_countries_FSPATH=$(DATA_TMP_FSPATH)/mledoze_countries
dr5hn_countries_states_cities_database_FSPATH=$(DATA_TMP_FSPATH)/dr5hn_countries-states-cities-database

print:
	@echo
	@echo DATA_TMP_FSPATH: $(DATA_TMP_FSPATH)
	@echo mledoze_countries_FSPATH: $(mledoze_countries_FSPATH)
	@echo dr5hn_countries_states_cities_database_FSPATH: $(dr5hn_countries_states_cities_database_FSPATH)
	@echo
	@echo
	@echo
	@echo
	@echo


batch:
	# pull code and hence data
	git clone https://github.com/mledoze/countries $(mledoze_countries_FSPATH)

	git clone https://github.com/dr5hn/countries-states-cities-database $(dr5hn_countries_states_cities_database_FSPATH)

	# put into our format

	# pump into db

	# what about deltas ? There ID's should be static. SO as long as Modules use onyl the ID we can delete the data and put new in and not break anyone.

	# Lang. We can use our LANG tool. Will just need a New API specific for this dataset.

batch-clean:
	rm -rf $(mledoze_countries_FSPATH)
	rm -rf $(dr5hn_countries_states_cities_database_FSPATH)

go-sync-run:
	cd cmd/sync && go run .
	# 1. Use go-getter, NOT git clone
	# 2. Transform data to Our data model
	# 3. 