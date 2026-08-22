import json
import re

log_file = "/Users/munday/.gemini/antigravity-ide/brain/d9c9312f-bdd3-4aae-bab8-519acb81d069/.system_generated/logs/transcript_full.jsonl"

all_lines = {} # line_num -> code

with open(log_file, "r") as f:
    for line in f:
        try:
            data = json.loads(line)
        except:
            continue
            
        if data.get("type") == "TOOL_RESPONSE":
            content = data.get("content", "")
            if "events_page.dart" in content and ":" in content:
                # view_file outputs lines like "10756:class _EventDetailSheet {"
                # grep_search also outputs lines like "events_page.dart:10756:class _EventDetailSheet {"
                lines = content.split("\n")
                for l in lines:
                    m = re.search(r'(?:events_page\.dart:)?(\d+):\s(.*)', l)
                    if m:
                        lnum = int(m.group(1))
                        code = m.group(2)
                        all_lines[lnum] = code

if all_lines:
    with open("recovered_lines.txt", "w") as f:
        for i in sorted(all_lines.keys()):
            f.write(f"{i}: {all_lines[i]}\n")
    print(f"Recovered {len(all_lines)} unique lines!")
else:
    print("No lines recovered.")
