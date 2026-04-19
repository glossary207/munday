import re

with open('lib/features/account/presentation/profile/profile_widget.dart', 'r') as f:
    content = f.read()

for i in range(1, 7):
    # Fix 1: Make Hero tags unique
    pattern = r'tag:\s*currentUserDocument!\s*\.photoshow\s*\.photo' + str(i) + r','
    replacement = f"tag: 'photo{i}_${{currentUserDocument!.photoshow.photo{i}}}',"
    content = re.sub(pattern, replacement, content)
    
    # Fix 2: Wrap Image.network with a check to use an empty transparent image or SizedBox if url is empty
    # In Dart, we can just do: (currentUserDocument!.photoshow.photoX.isEmpty ? 'https://empty' : currentUserDocument!.photoshow.photoX)
    # Actually, simpler: Image.network( currentUserDocument!.photoshow.photoX.isEmpty ? 'https://via.placeholder.com/1x1.png' : currentUserDocument!.photoshow.photoX, ... )
    
    # Wait, Image.network( currentUserDocument!.photoshow.photo{i}, -> 
    pattern_img = r'Image\.network\(\s*currentUserDocument!\s*\.photoshow\s*\.photo' + str(i) + r'\s*,'
    replacement_img = f"Image.network(currentUserDocument!.photoshow.photo{i}.isEmpty ? 'https://firebasestorage.googleapis.com/v0/b/munday-6thn82.appspot.com/o/transparent.png?alt=media' : currentUserDocument!.photoshow.photo{i},"
    content = re.sub(pattern_img, replacement_img, content)

    # Note: there might be missing commas or new lines, so let's be careful.
    pattern_img2 = r'Image\.network\(\s*currentUserDocument!\s*\.photoshow\.photo' + str(i) + r'\s*,'
    content = re.sub(pattern_img2, replacement_img, content)

with open('lib/features/account/presentation/profile/profile_widget.dart', 'w') as f:
    f.write(content)

print("Patch applied.")
