import os
import re

lib_dir = "/Users/munday/ProjectMunday/MundayGEN/munday/lib"
font_pattern = re.compile(r'GoogleFonts\.(inter|lexendDeca|openSans|outfit|plusJakartaSans|roboto|robotoMono|kanit|prompt)\b')

for root, dirs, files in os.walk(lib_dir):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()
            
            new_content, count = font_pattern.subn('GoogleFonts.chakraPetch', content)
            
            if count > 0:
                with open(filepath, 'w') as f:
                    f.write(new_content)
                print(f"Replaced {count} occurrences in {filepath}")

print("Font replacement complete.")
