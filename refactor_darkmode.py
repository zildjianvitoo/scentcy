import os
import re

directory = "/Users/zildjianvito/Documents/apple-academy/challenge-3/scentcy/scentcy"

replacements = [
    (r'\.foregroundColor\(\.black\)', r'.foregroundColor(.primary)'),
    (r'\.foregroundStyle\(\.black\)', r'.foregroundStyle(.primary)'),
    (r'\.foregroundColor\(Color\.black\)', r'.foregroundColor(.primary)'),
    (r'\.foregroundStyle\(Color\.black\)', r'.foregroundStyle(.primary)'),
    (r'Color\.black\.opacity', r'Color.primary.opacity'),
    
    (r'\.background\(Color\.white\)', r'.background(Color.appCardBackground)'),
    (r'\.background\(\.white\)', r'.background(Color.appCardBackground)'),
    (r'\.fill\(Color\.white\)', r'.fill(Color.appCardBackground)'),
    (r'\.fill\(\.white\)', r'.fill(Color.appCardBackground)'),
    
    # Text in DiscoverEmpty and JourneyEmpty
    (r'Color\(hex:\s*"333333"\)', r'Color.primary'),
    (r'Color\(hex:\s*"F8F7F4"\)', r'Color.appCardBackground'),
]

modified_files = 0
for root, _, files in os.walk(directory):
    for filename in files:
        if filename.endswith(".swift") and filename != "Color+Extension.swift":
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

print(f"Modified {modified_files} files for Dark Mode.")
