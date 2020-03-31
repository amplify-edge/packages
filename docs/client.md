Client side cache / Persistence

- https://github.com/hivedb/hive/pull/264
  - adds migrations
  - We will need this. Just like the Server does migrations, we will also need to do the same on the clients.

- https://github.com/marchdev-tk/flinq
 - makes it easy to use HIve as a KV store.

---

Plugins that work on Mobile and web:

- Connectivity: https://github.com/marchdev-tk/cross_connectivity
- File Selector: https://github.com/marchdev-tk/file_selector
- Share: https://github.com/marchdev-tk/cross_share
- Shared Preferences: https://github.com/marchdev-tk/cross_local_storage
  - Example: https://github.com/bitrise-io/sample-apps-flutter-veggieseasons
  - Shared preferences are different from HIVE in that on app update shared preferences are retained !
- Maps: https://github.com/marchdev-tk/flutter_google_maps
  - Polylne: https://github.com/marchdev-tk/google_polyline_algorithm
  - Directions: https://github.com/marchdev-tk/google_directions_api
- Notifications: I emailed them to ask about Notifications.