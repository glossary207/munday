import json

log_file = "/Users/munday/.gemini/antigravity-ide/brain/d9c9312f-bdd3-4aae-bab8-519acb81d069/.system_generated/logs/transcript_full.jsonl"

first_view = ""

with open(log_file, "r") as f:
    for line in f:
        try:
            data = json.loads(line)
        except:
            continue
            
        if data.get("type") == "TOOL_RESPONSE":
            content = data.get("content", "")
            if "events_page.dart" in content and "class _EventsPageState" in content:
                first_view = content
                break

if first_view:
    print("Found a view, trying to extract it")
    lines = first_view.split("\n")
    code_lines = []
    import re
    for line in lines:
        m = re.match(r"^(\d+):\s(.*)$", line)
        if m:
            code_lines.append(m.group(2))
    
    with open("recovered_from_view.dart", "w") as f:
        f.write("\n".join(code_lines))
    print(f"Saved {len(code_lines)} lines to recovered_from_view.dart")
else:
    print("Did not find a suitable view")
