import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/main_page.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

if "import 'package:intl/intl.dart';" not in "".join(lines):
    # insert it after the first import
    for i, line in enumerate(lines):
        if line.startswith("import "):
            lines.insert(i, "import 'package:intl/intl.dart';\n")
            break
    with open(file_path, "w") as f:
        f.writelines(lines)
    print("Import added.")
else:
    print("Import already exists.")
