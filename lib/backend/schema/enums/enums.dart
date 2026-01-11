import "package:f_f_story_view_live_zhm3f3/backend/schema/enums/enums.dart"
    as f_f_story_view_live_zhm3f3_enums;
import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

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
  switch (T) {
    case (StoryItemEnum):
      return StoryItemEnum.values.deserialize(value) as T?;
    case (PositionTableLayout):
      return PositionTableLayout.values.deserialize(value) as T?;
    case (f_f_story_view_live_zhm3f3_enums.StoryItemEnum):
      return f_f_story_view_live_zhm3f3_enums.StoryItemEnum.values
          .deserialize(value) as T?;
    default:
      return null;
  }
}
