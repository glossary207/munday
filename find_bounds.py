import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/components/main_events_widget.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

def get_block(start_line, match_char='('):
    stack = []
    end_line = start_line
    close_char = ')' if match_char == '(' else ('}' if match_char == '{' else ']')
    started = False
    
    for i in range(start_line, len(lines)):
        line = lines[i]
        for char in line:
            if char == match_char:
                stack.append(char)
                started = True
            elif char == close_char and stack:
                stack.pop()
        
        end_line = i
        if started and not stack:
            break
            
    return "".join(lines[start_line:end_line+1]), end_line

# Find SingleChildScrollView line
start_idx = -1
for i, line in enumerate(lines):
    if "return SingleChildScrollView(" in line:
        start_idx = i
        break

if start_idx != -1:
    block, end_idx = get_block(start_idx, '(')
    print(f"SingleChildScrollView starts at {start_idx + 1} and ends at {end_idx + 1}")
else:
    print("Not found")

