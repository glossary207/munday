import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/components/main_venues_spotlight_widget.dart"
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

block, end_idx = get_block(105, '(')
print(f"SingleChildScrollView starts at 106 and ends at {end_idx + 1}")

