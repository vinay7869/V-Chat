enum MessageEnums {
  text('text'),
  audio('audio'),
  video('video'),
  image('image'),
  gif('gif');

  const MessageEnums(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageEnums toEnum() {
    switch (this) {
      case 'text':
        return MessageEnums.text;
      case 'audio':
        return MessageEnums.audio;
      case 'video':
        return MessageEnums.video;
      case 'image':
        return MessageEnums.image;
      case 'gif':
        return MessageEnums.image;

      default:
        return MessageEnums.text;
    }
  }
}
