class Message {
  final int id;
  final String type;
  final String name;
  final String text;
  final String time;

  const Message({
    required this.id,
    required this.type,
    required this.name,
    required this.text,
    required this.time,
  });
}

class MessageList {
  static List<Message> list() {
    const data = <Message>[
      Message(
        id: 1,
        text: 'hi',
        type: 'sender',
        name: 'Harison Max',
        time: '5.10 pm',
      ),
      Message(
        id: 2,
        text: 'hello',
        name: 'Harison Max',
        type: 'receiver',
        time: '5.10 pm',
      ),
      Message(
        id: 3,
        text: 'How can we help you ?.',
        type: 'sender',
        name: 'Harison Max',
        time: '5.20 pm',
      ),
      Message(
        id: 4,
        text: 'Thanks',
        type: 'receiver',
        name: 'Harison Max',
        time: '5.20 pm',
      ),
      Message(
        id: 5,
        text: 'What are you facing problem.',
        type: 'sender',
        name: 'Harison Max',
        time: '5.30 pm',
      ),
      Message(
        id: 6,
        text: 'Thanks sir you have a good day ',
        name: 'Harison Max',
        type: 'receiver',
        time: '5.33 pm',
      ),
      Message(
        id: 7,
        text: 'Come to here Again',
        type: 'sender',
        name: 'Harison Max',
        time: '5.45 pm',
      ),
      Message(
        id: 8,
        name: 'Harison Max',
        text: 'Sure',
        type: 'receiver',
        time: '5.47 pm',
      ),
    ];
    return data;
  }
}
