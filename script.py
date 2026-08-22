import json
import os

log_file = '/Users/munday/.gemini/antigravity-ide/brain/d9c9312f-bdd3-4aae-bab8-519acb81d069/.system_generated/logs/transcript_full.jsonl'
found = False
with open(log_file, 'r') as f:
    for line in f:
        try:
            data = json.loads(line)
            if data.get('type') == 'TOOL_RESPONSE':
                content = data.get('content', '')
                if 'File Path: ' in content and 'events_page.dart' in content:
                    with open('first_view.txt', 'w') as out:
                        out.write(content)
                    print('Saved a view to first_view.txt')
                    break
        except:
            pass
