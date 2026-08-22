import json
import re

log_file = "/Users/munday/.gemini/antigravity-ide/brain/d9c9312f-bdd3-4aae-bab8-519acb81d069/.system_generated/logs/transcript_full.jsonl"

all_lines = {}
max_line = 0

with open(log_file, "r") as f:
    for line in f:
        try:
            data = json.loads(line)
        except:
            continue
            
        if data.get("type") == "TOOL_RESPONSE":
            content = data.get("content", "")
            if "events_page.dart" in content and "The following code has been modified to include a line number" in content:
                # We found a view_file output for events_page.dart!
                # Let's extract only if this happened BEFORE the first git checkout.
                # Actually, wait, let's just extract EVERYTHING. The checkout might have reset things, but if we overwrite we get the latest?
                # The user's changes were before the checkout. So we should ONLY process up to the checkout!
                pass
                
        # Let's just track time.
        if data.get("type") == "RUN_COMMAND" and "git checkout" in data.get("content", ""):
            print("Found git checkout. Stopping extraction.")
            break
            
        if data.get("type") == "VIEW_FILE":
            content = data.get("content", "")
            if "events_page.dart" in content:
                lines = content.split("\n")
                for l in lines:
                    m = re.match(r'^(\d+):\s(.*)$', l)
                    if m:
                        lnum = int(m.group(1))
                        code = m.group(2)
                        # Don't overwrite if we already have it, or maybe do overwrite?
                        # The user's newest edits were present at the start of the chat.
                        # Since we stop at git checkout, the latest view is the most accurate.
                        all_lines[lnum] = code
                        if lnum > max_line:
                            max_line = lnum

if all_lines:
    with open("recovered_lines.txt", "w") as f:
        # We need to fill in gaps if possible.
        for i in range(1, max_line + 1):
            if i in all_lines:
                f.write(f"{i}: {all_lines[i]}\n")
            else:
                f.write(f"{i}: // MISSING LINE\n")
    print(f"Recovered {len(all_lines)} unique lines out of {max_line}!")
else:
    print("No lines recovered.")
