import re
import sys

file_path = "ios/Runner.xcodeproj/project.pbxproj"
with open(file_path, "r") as f:
    content = f.read()

# Replace empty development team with 4FPJT6W3SJ
# But let's only do it for lines with DEVELOPMENT_TEAM = "";
new_content = content.replace('DEVELOPMENT_TEAM = "";', 'DEVELOPMENT_TEAM = 4FPJT6W3SJ;')

with open(file_path, "w") as f:
    f.write(new_content)
    
print("Updated project.pbxproj successfully")
