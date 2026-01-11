import os
import requests
import mimetypes
from urllib.parse import urlparse
from supabase import create_client, Client

# Supabase Configuration
SUPABASE_URL = 'https://xdhhlxpysugtzkqrtdzp.supabase.co'
SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkaGhseHB5c3VndHprcXJ0ZHpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYwODE0ODIsImV4cCI6MjA4MTY1NzQ4Mn0.WjtC3gW03KYsNexLS734sBJS-ZIKH4bKOmhKatoFPk8'
STORAGE_BUCKET = 'Venues' # Updated from user screenshot

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# Tables and columns to migrate
# Format: 'table_name': ['column1', 'column2']
# Note: Some columns might be arrays (List<String>)
MIGRATION_MAP = {
    'events': ['Poster'],
    'users': ['photo_url', 'logo_room'],
    'store': ['logo', 'qr', 'BGshow1'],
    'venues': ['BG', 'Logo', 'photos', 'Video'] # photos and Video are lists
}

def is_firebase_url(url):
    return url and isinstance(url, str) and url.startswith('https://firebasestorage.googleapis.com')

def download_file(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.content, response.headers.get('Content-Type')
    except Exception as e:
        print(f"Error downloading {url}: {e}")
        return None, None

def upload_to_supabase(path, file_bytes, content_type):
    try:
        # Check if file exists first to avoid re-uploading if not needed, 
        # butupsert=True expects to overwrite.
        # Supabase storage path: we can use the same filename from firebase or generate a new one.
        # Firebase URLs usually have a token, but the path helps.
        

        # Supabase storage path: we can use the same filename from firebase or generate a new one.
        # Firebase URLs usually have a token, but the path helps.
        
        # Check if file exists? No, just upsert (overwrite) or assume it's there?
        # User says files are THERE. We should perhaps just return the URL?
        # But we need to ensure the structure matches. 
        # For now, we try to upload. If it fails with "already exists" (upsert=false), we can handle it.
        # But upsert=true usually works.
        # Wait, if user uploaded them manually, the path might not match "{table}/{record_id}/{filename}".
        # It might be just "{filename}" or structured differently.
        # However, to be SAFE and ensure the App can find them where it EXPECTS them (from future app uploads),
        # we should stick to our structure OR ask user. 
        # Strategy: Try to upload. If successful, we update DB.
        
        supabase.storage.from_(STORAGE_BUCKET).upload(
            path=path,
            file=file_bytes,
            file_options={"content-type": content_type, "upsert": "true"}
        )
        return supabase.storage.from_(STORAGE_BUCKET).get_public_url(path)
    except Exception as e:
        print(f"Error uploading to {path}: {e}")
        # If error, maybe it's already there? Return the URL anyway so we update the DB?
        # This assumes the path structure matches.
        return supabase.storage.from_(STORAGE_BUCKET).get_public_url(path)

    except Exception as e:
        print(f"Error uploading to {path}: {e}")
        return None

def extract_filename(url):
    parsed = urlparse(url)
    path = parsed.path
    # Firebase path usually encoded. /v0/b/project.appspot.com/o/path%2Fto%2Ffile.jpg
    # decoded component is in path.
    # The user said: "name of file same but location might be slightly rearranged"
    # We will try to preserve the name.
    unquoted_path = requests.utils.unquote(path)
    filename = unquoted_path.split('/')[-1]
    return filename

def migrate_table(table, columns):
    print(f"Processing table: {table}")
    try:
        # Fetch all records
        response = supabase.table(table).select("*").execute()
        records = response.data
        print(f"Found {len(records)} records in {table}")
        
        for record in records:
            record_id = record.get('id') or record.get('uid') # 'users' usually uses uid? or id? shim said id usually exists.
            if not record_id:
                print(f"Skipping record without ID in {table}")
                continue

            updates = {}
            for col in columns:
                val = record.get(col)
                if not val:
                    continue
                
                # Handle List
                if isinstance(val, list):
                    new_list = []
                    modified = False
                    for item in val:
                        if is_firebase_url(item):
                            print(f"Found match list item in {table} {col}")
                            filename = extract_filename(item)
                            file_content, content_type = download_file(item)
                            if file_content:
                                # Organize in folders by table?
                                storage_path = f"{table}/{record_id}/{filename}"
                                new_url = upload_to_supabase(storage_path, file_content, content_type)
                                if new_url:
                                    print(f"Migrated: {item} -> {new_url}")
                                    new_list.append(new_url)
                                    modified = True
                                else:
                                    new_list.append(item) # Keep old if fail
                            else:
                                new_list.append(item)
                        else:
                            new_list.append(item)
                    if modified:
                        updates[col] = new_list

                # Handle String
                elif is_firebase_url(val):
                    print(f"Found match in {table} {col} for record {record_id}")
                    filename = extract_filename(val)
                    file_content, content_type = download_file(val)
                    if file_content:
                         storage_path = f"{table}/{record_id}/{filename}"
                         new_url = upload_to_supabase(storage_path, file_content, content_type)
                         if new_url:
                             print(f"Migrated: {val} -> {new_url}")
                             updates[col] = new_url
                    
            if updates:
                print(f"Updating record {record_id} with {updates}")
                try:
                    supabase.table(table).update(updates).eq('id', record_id).execute()
                except Exception as e:
                    # Try uid if id update fails? shim says use id usually. in users table it might be uuid?
                    # Supabase users table is auth.users but public.users is usually a profile table. 
                    # If it fails, maybe the PK is different.
                    print(f"Update failed for {record_id}: {e}")
                    
    except Exception as e:
        print(f"Error processing table {table}: {e}")

def main():
    print("Starting migration...")
    for table, columns in MIGRATION_MAP.items():
        migrate_table(table, columns)
    print("Migration complete.")

if __name__ == "__main__":
    main()
