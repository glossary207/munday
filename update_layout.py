import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/venues/venues_page.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

def get_block(start_line):
    # simple brace/bracket matcher
    stack = []
    end_line = start_line
    for i in range(start_line, len(lines)):
        line = lines[i]
        for char in line:
            if char in "({[":
                stack.append(char)
            elif char in ")}]":
                if stack:
                    stack.pop()
        end_line = i
        if not stack:
            break
    return "".join(lines[start_line:end_line+1]), end_line

# Find the start of Name Row, Info Row, Logo Padding, and Avatar Align
# By line numbers we found:
# Name Row: 888 "Row("
# Info Align: 1100 "Align("
# Logo Padding: 1471 "Padding("
# Avatar Align: 1521 "Align("

name_row, end_name = get_block(887)
info_align, end_info = get_block(end_name + 1)
logo_padding, end_logo = get_block(end_info + 1)
avatar_align, end_avatar = get_block(end_logo + 1)

print(f"Name row ends at {end_name}")
print(f"Info align ends at {end_info}")
print(f"Logo padding ends at {end_logo}")
print(f"Avatar align ends at {end_avatar}")

# Create the new structure
new_structure = f"""                                                                        Expanded(
                                                                          child: SizedBox(),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                                          child: Row(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                            children: [
{logo_padding}                                                                              Expanded(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
{name_row}{info_align}                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
"""

# Replace in lines
new_lines = lines[:887] + [new_structure] + lines[end_avatar+1:]

with open(file_path, "w") as f:
    f.writelines(new_lines)
print("Updated successfully")
