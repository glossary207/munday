import os
from supabase import create_client, Client

# Supabase Configuration
SUPABASE_URL = 'https://xdhhlxpysugtzkqrtdzp.supabase.co'
SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkaGhseHB5c3VndHprcXJ0ZHpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYwODE0ODIsImV4cCI6MjA4MTY1NzQ4Mn0.WjtC3gW03KYsNexLS734sBJS-ZIKH4bKOmhKatoFPk8'

def list_buckets():
    try:
        supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
        buckets = supabase.storage.list_buckets()
        
        print("\n--- Listing Buckets ---")
        if not buckets:
            print("No buckets found.")
        else:
            for b in buckets:
                print(f"Name: {b.name}, Public: {b.public}")
        print("-----------------------\n")
            


    except Exception as e:
        print(f"Error listing buckets: {e}")

    # Blind probe for likely names based on screenshot
    for name in ['Venues', 'venues', 'public', 'uploads']:
        try:
            print(f"Probing '{name}'...")
            # Try to list files in root to see if it exists/accessible
            supabase.storage.from_(name).list()
            print(f"✅ FOUND: Bucket '{name}' exists and is accessible!")
        except Exception as e:
            print(f"❌ '{name}': {e}")


