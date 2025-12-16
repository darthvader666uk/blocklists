#!/usr/bin/env python3
"""Validate the uBlock backup JSON for syntax correctness.
Exits with code 0 on success, 1 on failure.
"""
import json
import sys

path = r"C:/Users/darth/Documents/scripts/gist/my-ublock-backup_2025-11-19_12.04.39.txt"

try:
    with open(path, 'r', encoding='utf-8') as f:
        json.load(f)
    print('VALID_JSON')
    sys.exit(0)
except Exception as e:
    print('INVALID_JSON:', e)
    sys.exit(1)
