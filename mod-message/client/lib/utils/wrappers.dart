class Message {
  String inner;
  bool self;
  bool isNew;
  int timeProcessed;

  Message(this.inner, this.self, this.isNew, this.timeProcessed);
}

class Conversation {
  List<Message> messages;
  String contact;

  Conversation(List<Message> messages, this.contact) {
    this.messages = messages;
    this.messages.sort((Message a, Message b) {
      if (a.timeProcessed < b.timeProcessed)
        return -1;
      else if (a.timeProcessed == b.timeProcessed)
        return 0;
      else
        return 1;
    });
  }
}
