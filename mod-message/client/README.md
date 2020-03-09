# mod_messages

### Progress Report

A module for message sending/receiving and for notification firing...

Currently, web and mobile work correctly with normal build procedures.
Desktop errors out.

### Note(s) on External Usage

If using this code in a larger application do **not** use [`lib/main.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/main.dart). [`lib/main.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/main.dart) is just for build test purposes. Instead, use the module in the [`lib/modules`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/modules) folder.

### Note(s) on Data Formatting

This module requires a Hive box to be passed. This hive box should contain all the message data from this device for the user. This data should be formatted:
```
box.get(String contactName) returns a List<Map<String, dynamic>>, representing one conversation.

    Each Map<String, dynamic> in the List represents one message in the conversation, where:
    
        {'content': String message,   // Actual message content
        'self': bool isSelf,          // Whether this message is sent by user or contact
        'isNew': bool isNew,          // Whether this message is "new" (Not been opened locally)
        'timeProcessed': int time}    // Time when message was processed (In microseconds since epoch)
```
[`lib/utils/hive_parse.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/utils/hive_parse.dart)
exports two classes (`Message` and `Conversation`, from [`lib/utils/wrappers.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/utils/wrappers.dart)) that are representative of the elements in this data structure:
* A `Conversation` is essentially a `List<Message>`, sorted by timeProcessed, with the associated contact name stored.
* `Message`s are a wrapper for one message and associated metadata (who sent it, whether it's been seen locally, when it was processed)

[`lib/utils/hive_parse.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/utils/hive_parse.dart) exports a method (`parseAll(Box hiveBox)`) that takes a box and returns a `List<Conversation>`. 

[`lib/utils/hive_parse.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/utils/hive_parse.dart) also exports a method (`persist(List<Conversation>, Box hiveBox)`) that takes a List<Conversation> and a box. It merges the list & the box: If both the box and a List have the same message, it the List version is stored instead of the Box, to preserve updates in isNew. If the Box has messages that the List doesn't have, those messages are preserved in the Box.

For an example of using these utilities, see [`lib/main.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/main.dart) and [`lib/widgets/pane.dart`](https://github.com/AKushWarrior/packages/blob/master/mod-messages/lib/widgets/pane.dart)
