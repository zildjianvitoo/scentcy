import os
import re

directory = "/Users/zildjianvito/Documents/apple-academy/challenge-3/scentcy/scentcy"

replacements = [
    (r'\.padding\(16\)', r'.padding(Constants.UI.defaultPadding)'),
    (r'\.padding\(\.horizontal,\s*16\)', r'.padding(.horizontal, Constants.UI.defaultPadding)'),
    (r'\.padding\(\.vertical,\s*16\)', r'.padding(.vertical, Constants.UI.defaultPadding)'),
    (r'\.padding\(\.top,\s*16\)', r'.padding(.top, Constants.UI.defaultPadding)'),
    (r'\.padding\(\.bottom,\s*16\)', r'.padding(.bottom, Constants.UI.defaultPadding)'),
    (r'\.padding\(\.leading,\s*16\)', r'.padding(.leading, Constants.UI.defaultPadding)'),
    (r'\.padding\(\.trailing,\s*16\)', r'.padding(.trailing, Constants.UI.defaultPadding)'),
    
    (r'\.padding\(20\)', r'.padding(Constants.UI.screenPadding)'),
    (r'\.padding\(\.horizontal,\s*20\)', r'.padding(.horizontal, Constants.UI.screenPadding)'),
    (r'\.padding\(\.vertical,\s*20\)', r'.padding(.vertical, Constants.UI.screenPadding)'),
    (r'\.padding\(\.top,\s*20\)', r'.padding(.top, Constants.UI.screenPadding)'),
    (r'\.padding\(\.bottom,\s*20\)', r'.padding(.bottom, Constants.UI.screenPadding)'),
    (r'\.padding\(\.leading,\s*20\)', r'.padding(.leading, Constants.UI.screenPadding)'),
    (r'\.padding\(\.trailing,\s*20\)', r'.padding(.trailing, Constants.UI.screenPadding)'),
    
    (r'\.padding\(24\)', r'.padding(Constants.UI.largePadding)'),
    (r'\.padding\(\.horizontal,\s*24\)', r'.padding(.horizontal, Constants.UI.largePadding)'),
    (r'\.padding\(\.vertical,\s*24\)', r'.padding(.vertical, Constants.UI.largePadding)'),
    (r'\.padding\(\.top,\s*24\)', r'.padding(.top, Constants.UI.largePadding)'),
    (r'\.padding\(\.bottom,\s*24\)', r'.padding(.bottom, Constants.UI.largePadding)'),
    (r'\.padding\(\.leading,\s*24\)', r'.padding(.leading, Constants.UI.largePadding)'),
    (r'\.padding\(\.trailing,\s*24\)', r'.padding(.trailing, Constants.UI.largePadding)'),
    
    (r'\.cornerRadius\(24\)', r'.cornerRadius(Constants.UI.cornerRadius)'),
    (r'\.cornerRadius\(12\)', r'.cornerRadius(Constants.UI.smallCornerRadius)'),
]

modified_files = 0
for root, _, files in os.walk(directory):
    for filename in files:
        if filename.endswith(".swift") and filename != "Constants.swift":
            filepath = os.path.join(root, filename)
            with open(filepath, 'r') as file:
                content = file.read()
            
            original_content = content
            for pattern, repl in replacements:
                content = re.sub(pattern, repl, content)
            
            if content != original_content:
                with open(filepath, 'w') as file:
                    file.write(content)
                modified_files += 1

print(f"Modified {modified_files} files.")
