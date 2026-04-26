import os

file_path = '/Users/bewsunattha/MundayGEN/munday/lib/features/social/presentation/home_page/home_page_widget.dart'
new_file_path = '/Users/bewsunattha/MundayGEN/munday/lib/features/social/presentation/home_page/home_page_widget_new.dart'

with open(file_path, 'r') as f:
    text = f.read()

# We want to replace everything inside AuthUserStreamWidget(builder: (context) { ... })

# Let's extract the part that builds the stack
stack_start = text.find('return Stack(')
stack_end = text.rfind('              );') # end of AuthUserStreamWidget

if stack_start != -1 and stack_end != -1:
    stack_content = text[stack_start:stack_end]
    
    # We will restructure this. 
    # But it's easier if I just output exactly what I want in Dart.

