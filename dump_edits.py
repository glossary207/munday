import json

log_file = "/Users/munday/.gemini/antigravity-ide/brain/d9c9312f-bdd3-4aae-bab8-519acb81d069/.system_generated/logs/transcript.jsonl"
edits = []
with open(log_file, "r") as f:
    for line in f:
        try:
            data = json.loads(line)
        except:
            continue
            
        if data.get("type") == "USER_INPUT" and "ช่วยปรับให้เมื่อกด events นั้น แล้วขึ้น popup นั้น ให้เชื่อมเป็น hero animation" in data.get("content", ""):
            break
            
        if "tool_calls" in data:
            for call in data["tool_calls"]:
                name = call.get("function", {}).get("name") or call.get("name")
                if "replace_file_content" in name:
                    args = call.get("args", {})
                    # Some versions of antigravity store args as a dict with string values
                    if isinstance(args, str):
                        try:
                            args = json.loads(args)
                        except:
                            pass
                    
                    if not isinstance(args, dict): continue
                    
                    if "events_page.dart" in args.get("TargetFile", ""):
                        chunks_str = args.get("ReplacementChunks", "[]")
                        if isinstance(chunks_str, str):
                            try:
                                chunks = json.loads(chunks_str)
                            except:
                                chunks = []
                        else:
                            chunks = chunks_str
                            
                        if not chunks and "TargetContent" in args:
                            target = args.get("TargetContent", "")
                            if isinstance(target, str) and target.startswith('"') and target.endswith('"'):
                                try: target = json.loads(target)
                                except: pass
                            repl = args.get("ReplacementContent", "")
                            if isinstance(repl, str) and repl.startswith('"') and repl.endswith('"'):
                                try: repl = json.loads(repl)
                                except: pass
                            chunks = [{"TargetContent": target, "ReplacementContent": repl, "Description": args.get("Description", "")}]
                            
                        for chunk in chunks:
                            target = chunk.get("TargetContent", "")
                            if isinstance(target, str) and target.startswith('"') and target.endswith('"'):
                                try: target = json.loads(target)
                                except: pass
                            repl = chunk.get("ReplacementContent", "")
                            if isinstance(repl, str) and repl.startswith('"') and repl.endswith('"'):
                                try: repl = json.loads(repl)
                                except: pass
                            desc = chunk.get("Description", "")
                            edits.append({"target": target, "repl": repl, "desc": desc})

print(f"Found {len(edits)} edits:")
for i, edit in enumerate(edits):
    print(f"\n--- EDIT {i+1}: {edit['desc'][:100]} ---")
    print("TARGET:")
    print(edit['target'])
    print("\nREPLACEMENT:")
    print(edit['repl'])
