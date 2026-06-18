import os
import re

directory = "/Users/zildjianvito/Documents/apple-academy/challenge-3/scentcy/scentcy"

def size_to_style(size):
    size = int(size)
    if size >= 34: return ".largeTitle"
    if size >= 28: return ".title"
    if size >= 22: return ".title2"
    if size >= 20: return ".title3"
    if size >= 17: return ".body"
    if size >= 16: return ".callout"
    if size >= 15: return ".subheadline"
    if size >= 13: return ".footnote"
    if size >= 12: return ".caption"
    return ".caption2"

def replacer(match):
    size = match.group(1)
    rest = match.group(2) if match.group(2) else ""
    style = size_to_style(size)
    
    # Reconstruct the arguments. rest contains e.g. ", weight: .bold"
    return f".font(.system({style}{rest}))"

pattern = re.compile(r'\.font\(\.system\(size:\s*(\d+)([^)]*)\)\)')

count = 0
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith(".swift"):
            path = os.path.join(root, file)
            with open(path, "r") as f:
                content = f.read()
            
            new_content, n = pattern.subn(replacer, content)
            if n > 0:
                count += n
                with open(path, "w") as f:
                    f.write(new_content)
                print(f"Replaced {n} occurrences in {file}")

print(f"Total replacements: {count}")
