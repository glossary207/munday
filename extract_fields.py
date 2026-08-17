import re

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/components/main_events_widget.dart"
with open(file_path, "r") as f:
    content = f.read()

# Pattern to find DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.<propertyName>
pattern = r"DataEventsStruct\.maybeFromMap\([^)]+\)\?\s*\.\s*([a-zA-Z0-9_]+)"
matches = set(re.findall(pattern, content))
print("Fields used from DataEventsStruct:")
for match in matches:
    print("- " + match)

