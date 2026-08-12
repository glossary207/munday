import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/venues/venues_page.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

def get_block(start_line):
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

name_row, end_name = get_block(887)
info_align, end_info = get_block(end_name + 1)
logo_padding, end_logo = get_block(end_info + 1)

print(f"Name Row: 887 to {end_name}")
print(f"Info Align: {end_name + 1} to {end_info}")
print(f"Logo Padding: {end_info + 1} to {end_logo}")

print("\nLines after Logo Padding:")
for i in range(end_logo + 1, end_logo + 6):
    print(f"{i}: {lines[i].strip()}")

# Find avatar align
avatar_start = end_logo + 4  # Looks like index 1520
avatar_align, end_avatar = get_block(avatar_start)
print(f"\nAvatar Align: {avatar_start} to {end_avatar}")
for i in range(end_avatar + 1, end_avatar + 6):
    print(f"{i}: {lines[i].strip()}")

