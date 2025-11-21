# Example vCon Files

This directory contains sample vCon files for testing the validation Skill.

## Available Examples

### vCon JSON Files

## Files

### valid-simple.vcon
✅ **Valid, compliant vCon**
- Contains all required fields
- Proper UUID format
- Valid RFC3339 timestamps
- Correct dialog structure
- Use this to test successful validation

### invalid-missing-fields.vcon
❌ **Invalid vCon with multiple errors**
- Missing required `vcon` field
- Missing required `created_at` field
- Invalid UUID format
- Party index out of range (references party 5, only 1 party exists)
- Missing dialog `start` field
- Use this to test error detection and reporting

## Usage

Upload these files to Claude with validation requests:

```
"Can you validate this vCon file?"
[Upload valid-simple.vcon]
```

Expected result: Detailed validation report showing compliance status.

## Creating Your Own Test Cases

Follow the vCon structure:
```json
{
  "vcon": "0.4.0",
  "uuid": "UUID-HERE",
  "created_at": "RFC3339-TIMESTAMP",
  "parties": [...],
  "dialog": [...],
  "analysis": [],
  "attachments": []
}
```

See Skill.md for complete field specifications.

## vCon ZIP Bundle Examples

For examples and guidance on creating and working with vCon ZIP Bundles (.vconz files), see:

📦 **[README-BUNDLES.md](./README-BUNDLES.md)** - Comprehensive guide including:
- Bundle structure and format
- Single and multi-vCon bundles
- Deduplication examples
- Signed and encrypted vCon bundles
- Redacted vCon bundles
- Creation and extraction workflows
- Best practices and troubleshooting

### Quick Bundle Reference

A vCon ZIP Bundle packages one or more vCons with their media files:

```
example.vconz
├── manifest.json           # Bundle metadata
├── files/                 # Media files (hash-named)
│   ├── sha512-GLy6...wav
│   └── sha512-Abc...pdf
└── vcons/                 # vCon JSON files
    └── {uuid}.json
```

**Media Type**: `application/vcon+zip`
**File Extension**: `.vconz`
**Specification**: draft-miller-vcon-zip-bundle-00
