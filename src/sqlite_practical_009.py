
"""Practical 9: Pythin SQL Database Integration
Student Name:
Date:

This script demonstrates SQLite database operations in Python
"""

import sqlite3
import sys
from pathlib import Path 

# Use this SQLite database
SQLITE_DB = '../runtime/db/starwars.db'

#Base Practice: Use context managers for database connections
def query_characters():
    """ 
    Query characters using cintext manager
    Context managers automatically handle connection closing and commits
    """
    try:
        with sqlite3.connect(SQLITE_DB) as conn:
            print(f"✔ Connected to database")
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM characters LIMIT 5")
            results = cursor.fetchall()
            for row in results:
                print(row)
            # Connection automatically closes here
    except sqlite3.Error as e:
        print(f"✘ Error: {e}")
        #Rollback happens automatically with context manager

# Test the connection
def test_connection():
    """ Test database connection using context manager"""
    try:
        with sqlite3.connect(SQLITE_DB) as conn:
            print("✔ Connection successful!")
            print(f"✔ SQLite version: {sqlite3.sqlite_version}")
        print("✔ Connection automatically closed")
    except sqlite3.Error as e:
        print(f"✘ Connection failed: {e}")

#Run the test
if __name__ == "__main__":
    test_connection()



