import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/components/main_events_widget.dart"
with open(file_path, "r") as f:
    content = f.read()

new_content = content.replace("GoogleFonts.kanit", "GoogleFonts.chakraPetch")

with open(file_path, "w") as f:
    f.write(new_content)

print("Font replaced to Chakra Petch successfully.")
