# vCon ZIP Bundle Examples

This document provides examples and guidance for creating and working with vCon ZIP Bundles (.vconz files).

## What is a vCon ZIP Bundle?

A vCon ZIP Bundle is a self-contained archive that packages one or more vCons with their associated media files. It uses the `.vconz` file extension and the `application/vcon+zip` media type.

## Bundle Structure

```
example.vconz
├── manifest.json                    # Bundle format identifiers
├── files/                          # All media files (flat, deduplicated)
│   ├── sha512-GLy6IPa...UQ.wav    # Hash-named with extensions
│   ├── sha512-Def456...XYZ.pdf
│   └── sha512-Transcript...ABC.json
├── vcons/                          # All vCon JSON files
│   ├── 0195544a-b9b1-8ee4-b9a2-279e0d16bc46.json
│   └── 01955450-1234-5678-9abc-def012345678.json
└── extensions/                     # Future vCon extensions (optional)
    └── [extension-name]/
        ├── metadata.json
        └── files/
```

## Example 1: Single vCon Bundle

### manifest.json
```json
{
  "format": "vcon-bundle",
  "version": "1.0"
}
```

### File: vcons/0195544a-b9b1-8ee4-b9a2-279e0d16bc46.json
```json
{
  "vcon": "0.4.0",
  "uuid": "0195544a-b9b1-8ee4-b9a2-279e0d16bc46",
  "created_at": "2025-11-21T10:30:00.000Z",
  "subject": "Customer support call",
  "parties": [
    {
      "tel": "+1-555-0100",
      "name": "Alice Smith"
    },
    {
      "tel": "+1-555-0200",
      "name": "Support Agent"
    }
  ],
  "dialog": [
    {
      "type": "recording",
      "start": "2025-11-21T10:30:00.000Z",
      "duration": 180.5,
      "parties": [0, 1],
      "mediatype": "audio/x-wav",
      "url": "https://example.com/recordings/call123.wav",
      "content_hash": "sha512-GLy6IPaIUM1GqzZqfIPZlWjaDsNgNvZM0iCONNThnH0a75fhUM6cYzLZ5GynSURREv..."
    }
  ],
  "analysis": [
    {
      "type": "transcript",
      "dialog": [0],
      "mediatype": "application/json",
      "vendor": "Deepgram",
      "url": "https://example.com/transcripts/call123.json",
      "content_hash": "sha512-Transcript123AbcDefGhi456JklMno789PqrStuVwxYz..."
    }
  ]
}
```

### Files included:
- `files/sha512-GLy6IPa...UQ.wav` - Audio recording
- `files/sha512-Transcript...ABC.json` - Transcript

## Example 2: Multi-vCon Bundle with Deduplication

When bundling multiple vCons that reference the same files (e.g., a shared document), the bundle automatically deduplicates based on content hash.

### Scenario
Two support calls referencing the same product manual:

**vCon 1** (Call about Feature A):
- Audio: call1.wav (hash: sha512-Call1...)
- Manual: product-manual.pdf (hash: sha512-SharedDoc...)
- Transcript: transcript1.json (hash: sha512-Trans1...)

**vCon 2** (Call about Feature B):
- Audio: call2.wav (hash: sha512-Call2...)
- Manual: product-manual.pdf (hash: sha512-SharedDoc...) ← **Same file!**
- Transcript: transcript2.json (hash: sha512-Trans2...)

### Bundle structure:
```
support-case.vconz
├── manifest.json
├── files/
│   ├── sha512-Call1Audio...ABC.wav
│   ├── sha512-Call2Audio...DEF.wav
│   ├── sha512-SharedDoc...GHI.pdf        # Stored only once!
│   ├── sha512-Transcript1...JKL.json
│   └── sha512-Transcript2...MNO.json
└── vcons/
    ├── 0195544a-b9b1-8ee4-b9a2-279e0d16bc46.json
    └── 0195544b-c2d3-4e5f-6a7b-8c9d0e1f2a3b.json
```

**Space savings**: The product manual PDF is stored once instead of twice.

## Example 3: Signed vCon in Bundle

### File: vcons/0195544c-1234-5678-9abc-def012345678.json
```json
{
  "vcon": "0.4.0",
  "uuid": "0195544c-1234-5678-9abc-def012345678",
  "payload": "eyJ2Y29uIjoiMC40LjAiLCJ1dWlkIjoiMDE5NTU0NGMtMTIzNC01Njc4LTlhYmMtZGVmMDEyMzQ1Njc4IiwiY3JlYXRlZF9hdCI6IjIwMjUtMTEtMjFUMTA6MzA6MDAuMDAwWiIsInBhcnRpZXMiOlt7InRlbCI6IisxLTU1NS0wMTAwIiwibmFtZSI6IkFsaWNlIn1dLCJkaWFsb2ciOlt7InR5cGUiOiJyZWNvcmRpbmciLCJzdGFydCI6IjIwMjUtMTEtMjFUMTA6MzA6MDAuMDAwWiIsImR1cmF0aW9uIjoxODAuNSwicGFydGllcyI6WzAsMV0sIm1lZGlhdHlwZSI6ImF1ZGlvL3gtd2F2IiwidXJsIjoiaHR0cHM6Ly9leGFtcGxlLmNvbS9yZWNvcmRpbmdzL2NhbGwxMjMud2F2IiwiY29udGVudF9oYXNoIjoic2hhNTEyLUdMeTZJUGEuLi4ifV19",
  "signatures": [
    {
      "protected": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsIng1YyI6WyJNSUlELi4uIl19",
      "signature": "ZXlKaGJHY2lPaUpTVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0lzSW5nMVl5STZXeUpOU..."
    }
  ]
}
```

**Note**: The bundle preserves the complete JWS structure. Files are extracted from the base64url-encoded payload before bundling.

## Example 4: Redacted vCon Bundle

### Use Case
Store both original and redacted versions together for compliance.

```
redacted-support-call.vconz
├── manifest.json
├── files/
│   ├── sha512-RedactedAudio...ABC.wav      # PII redacted
│   ├── sha512-OriginalAudio...DEF.wav      # Original with PII
│   └── sha512-RedactedTranscript...GHI.json
└── vcons/
    ├── 01955460-aaaa-bbbb-cccc-ddddeeeeeeee.json  # Original (encrypted)
    └── 01955461-ffff-gggg-hhhh-iiiijjjjkkkk.json  # Redacted (signed)
```

### Redacted vCon references original:
```json
{
  "vcon": "0.4.0",
  "uuid": "01955461-ffff-gggg-hhhh-iiiijjjjkkkk",
  "created_at": "2025-11-21T11:00:00.000Z",
  "redacted": {
    "uuid": "01955460-aaaa-bbbb-cccc-ddddeeeeeeee",
    "url": "https://secure-storage.example.com/originals/01955460.jwe",
    "content_hash": "sha512-OriginalVCon..."
  },
  "parties": [
    {
      "name": "[REDACTED]"
    }
  ],
  "dialog": [
    {
      "type": "recording",
      "start": "2025-11-21T10:30:00.000Z",
      "duration": 180.5,
      "parties": [0, 1],
      "mediatype": "audio/x-wav",
      "url": "https://example.com/recordings/redacted-call.wav",
      "content_hash": "sha512-RedactedAudio..."
    }
  ]
}
```

## Creating a Bundle

### Pseudo-code workflow:

```python
def create_vcon_bundle(vcons: List[VCon], output_path: str):
    """Create a vCon ZIP bundle"""
    bundle = ZipFile(output_path, 'w')
    files_added = set()
    
    # 1. Add manifest
    manifest = {"format": "vcon-bundle", "version": "1.0"}
    bundle.writestr("manifest.json", json.dumps(manifest))
    
    # 2. Process each vCon
    for vcon in vcons:
        # Add vCon file
        vcon_path = f"vcons/{vcon.uuid}.json"
        bundle.writestr(vcon_path, json.dumps(vcon))
        
        # 3. Extract and add referenced files
        for dialog in vcon.dialog:
            if dialog.url and dialog.content_hash:
                # Download file
                file_content = download_file(dialog.url)
                
                # Verify hash
                actual_hash = compute_hash(file_content)
                if actual_hash != dialog.content_hash:
                    raise ValueError("Hash mismatch!")
                
                # Determine extension
                ext = get_extension(dialog.mediatype)
                
                # Add to bundle (only once if already added)
                file_path = f"files/{dialog.content_hash}.{ext}"
                if file_path not in files_added:
                    bundle.writestr(file_path, file_content)
                    files_added.add(file_path)
    
    bundle.close()
```

## Extracting a Bundle

### Pseudo-code workflow:

```python
def extract_vcon_bundle(bundle_path: str, output_dir: str):
    """Extract and validate a vCon ZIP bundle"""
    bundle = ZipFile(bundle_path, 'r')
    
    # 1. Extract all files
    bundle.extractall(output_dir)
    
    # 2. Validate manifest
    with open(f"{output_dir}/manifest.json") as f:
        manifest = json.load(f)
        if manifest["format"] != "vcon-bundle":
            raise ValueError("Invalid bundle format")
    
    # 3. Discover and validate vCons
    vcons_dir = f"{output_dir}/vcons"
    for vcon_file in os.listdir(vcons_dir):
        vcon = json.load(open(f"{vcons_dir}/{vcon_file}"))
        
        # 4. Verify referenced files exist
        for dialog in vcon.get("dialog", []):
            if "content_hash" in dialog:
                file_path = find_file_by_hash(
                    output_dir, 
                    dialog["content_hash"]
                )
                if not file_path:
                    raise ValueError(f"Missing file: {dialog['content_hash']}")
                
                # 5. Verify file integrity
                actual_hash = compute_file_hash(file_path)
                if actual_hash != dialog["content_hash"]:
                    raise ValueError("File integrity check failed")
    
    return True
```

## Best Practices

### 1. Bundle Creation
- ✅ Always verify content hashes before adding files
- ✅ Use HTTPS exclusively for external URLs
- ✅ Preserve original vCon security forms (don't decrypt/unsign)
- ✅ Document bundle purpose and contents
- ✅ Test bundle extraction before distribution

### 2. Bundle Distribution
- ✅ Use descriptive filenames (e.g., `case-12345-2025-11-21.vconz`)
- ✅ Consider ZIP-level encryption for sensitive bundles
- ✅ Verify bundle integrity before sending
- ✅ Provide validation tools to recipients
- ✅ Document required decryption keys separately

### 3. Bundle Storage
- ✅ Index bundles by vCon UUIDs for fast lookup
- ✅ Maintain bundle metadata (creation date, source, purpose)
- ✅ Implement retention policies
- ✅ Regular integrity verification
- ✅ Backup original vCons separately

## Common Use Cases

### Archival
Package completed cases with all recordings and documents:
```
archive-2025-Q4.vconz
├── All vCons from Q4 2025
├── All referenced media files
└── Quarterly compliance report
```

### Legal Discovery
Bundle related conversations for legal proceedings:
```
discovery-case-789.vconz
├── All conversations related to case
├── Redacted versions for opposing counsel
├── Original encrypted versions for court
└── Chain of custody documentation
```

### Data Migration
Transfer vCons between systems:
```
migration-batch-001.vconz
├── 100 vCons from legacy system
├── All media files
└── Migration metadata
```

## Troubleshooting

### "Hash mismatch error"
- **Cause**: Downloaded file doesn't match expected hash
- **Fix**: Re-download file, check network connection, verify URL accessibility

### "Missing files in bundle"
- **Cause**: File not downloaded during bundle creation
- **Fix**: Check URL accessibility, verify network connection, ensure proper permissions

### "Invalid bundle format"
- **Cause**: Missing or incorrect manifest.json
- **Fix**: Ensure manifest.json exists with correct format and version

### "vCon not found"
- **Cause**: vCon UUID doesn't match filename
- **Fix**: Ensure vCon files are named as `{uuid}.json`

## Validation Checklist

Before distributing a bundle, verify:
- [ ] Manifest.json present with correct format
- [ ] All vCons in vcons/ directory
- [ ] All referenced files in files/ directory
- [ ] All content hashes verified
- [ ] No duplicate vCon UUIDs
- [ ] All files referenced by at least one vCon
- [ ] Security forms preserved (no downgrades)
- [ ] Bundle extracts without errors

## Additional Resources

- **Specification**: draft-miller-vcon-zip-bundle-00
- **Media Type**: application/vcon+zip
- **File Extension**: .vconz
- **Bundle Format Version**: 1.0

For more information, see the main SKILL.md documentation.