# Example vCon Files

This directory contains sample vCon files for testing the validation Skill.

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
