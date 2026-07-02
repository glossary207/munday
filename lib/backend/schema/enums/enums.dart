import 'package:collection/collection.dart';

extension FFEnumExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.name == value);
}

extension FFEnumSerializationExt on Enum {
  String serialize() => name;
}

enum StoryItemEnum {
  text,
  inlineImage,
  pageImage,
  pageVideo,
}

enum PositionTableLayout {
  xi,
  yi,
}

T? deserializeEnum<T>(String? value) {
  if (T == StoryItemEnum) {
    return StoryItemEnum.values.deserialize(value) as T?;
  } else if (T == PositionTableLayout) {
    return PositionTableLayout.values.deserialize(value) as T?;

  } else {
    return null;
  }
}
