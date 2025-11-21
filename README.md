# vCon Expert Skill

**The Complete Conversational Data Container Expert System**

This skill transforms Claude into the foremost expert on vCons (Virtualized Conversations), the IETF standard for exchanging conversational data. It combines validation, deep Q&A, and multi-language code generation capabilities.

## What's New in This Enhanced Version

This skill builds upon the existing vCon validator by adding:

1. **Deep Q&A Capabilities** - Answer any question about vCons, their structure, use cases, and best practices
2. **Multi-Language Code Generation** - Generate production-ready code in Go, JavaScript, and Python
3. **Latest IETF Updates** - Incorporates information from the July 2025 draft specifications
4. **Extension Expertise** - Deep knowledge of CC, MIMI, WTF, and other extensions
5. **Architecture Guidance** - Provides system design advice for vCon integration

## Features

### 1. Validation & Compliance
- Validates vCon JSON files against IETF draft-ietf-vcon-vcon-core-00
- Checks all three forms: unsigned, signed (JWS), and encrypted (JWE)
- Validates extensions: CC (Contact Center), MIMI (Messaging), WTF (Transcription)
- Generates detailed validation reports with specific fix recommendations
- Verifies content hashes for external references

### 2. Expert Q&A System
Ask Claude anything about vCons:
- "How do vCon redactions work?"
- "What's the difference between must_support and extensions?"
- "When should I use inline vs external references?"
- "How do I implement a custom extension?"
- "What are best practices for contact center integration?"

### 3. Multi-Language Code Generation

#### Go
- Complete type definitions
- Validation functions
- UUID v8 generation
- Content hash verification
- JWS signing/verification
- Production-ready, zero-dependency code

#### JavaScript/TypeScript
- TypeScript interfaces
- Fluent builder API
- Validation methods
- Async/await patterns
- Browser and Node.js compatible

#### Python
- Pydantic models with validation
- Parser and analyzer classes
- Data extraction utilities
- Statistical analysis
- Export in multiple formats

### 4. Extension Support

#### Contact Center (CC) Extension
- Queue time, ring time, disposition
- DNIS, ANI, customer ID
- Contact list, skill routing

#### MIMI Extension
- Modern messaging platforms
- Group conversations
- Rich media attachments

#### WTF (World Transcription Format)
- Standardized transcript format
- Multi-vendor interoperability
- Confidence scores, speaker identification

### 5. vCon ZIP Bundle Support (.vconz)

#### Package & Distribution
- Create self-contained archives with all media files
- Bundle multiple vCons with automatic deduplication
- Hash-based file naming for integrity verification
- Supports all vCon security forms (unsigned, signed, encrypted)
- Offline processing capability
- Simplified distribution and archival

#### Bundle Features
- Flat file structure with manifest
- Multi-vCon support with relationship tracking
- Extension support for future vCon features
- Platform-independent ZIP format
- Media type: `application/vcon+zip`

## Latest Specification Updates (July 2025)

This skill incorporates the latest changes from draft-ietf-vcon-vcon-core-00:

- **Version**: 0.3.0 (moving toward v1.0)
- **New Fields**: `must_support`, `did`, `product`, `timezone`
- **Extension Framework**: Compatible vs. Incompatible classification
- **Media Types**: Registered `application/vcon+json`, `application/vcon+gzip`, and `application/vcon+zip`
- **UUID**: Preference for UUID v8 with FQHN-based generation
- **vCon ZIP Bundle (.vconz)**: New packaging format for self-contained archives with media files

## File Structure

```
vcon-expert-skill/
├── SKILL.md                    # Main skill file (use this with Claude)
├── README.md                   # This file
├── vcon-documentation/         # IETF specifications
│   ├── draft-ietf-vcon-vcon-core-01
│   ├── draft-ietf-vcon-cc-extension-01
│   ├── draft-ietf-vcon-privacy-primer-00
│   ├── draft-miller-vcon-zip-bundle-00
│   ├── _draft-ietf-vcon-mimi-messages-00
│   └── _draft-ietf-vcon-overview-00
└── examples/                   # Example vCon files
    ├── valid-simple.vcon
    ├── valid-unsigned.json
    ├── valid-transfer-dialog.json
    ├── valid-with-cc-extension.json
    └── invalid-missing-fields.json
```

## Installation & Setup

### Quick Start (5 minutes)
1. Upload `SKILL.md` to Claude
2. Start with: "What is a vCon?"
3. Upload vCon files for validation
4. Request code generation

### Option 1: Direct Upload to Claude (Recommended)
1. Start a new conversation with Claude
2. Click the attachment icon (📎) or drag & drop
3. Upload `SKILL.md`
4. Claude will automatically recognize it as a skill
5. Start asking questions or request code generation

**First Command After Upload:**
```
Hi Claude! I just uploaded the vCon Expert skill.
Can you give me a quick overview of what you can help me with?
```

### Option 2: Add to Claude Project (Best for Ongoing Work)
1. Go to Claude Projects
2. Create new project or open existing one
3. Name it something like "vCon Development"
4. In Project settings, go to "Project Knowledge"
5. Click "Add content" and upload `SKILL.md`
6. Optionally upload entire `vcon-documentation/` folder for complete specs

**Benefits:**
- Any conversation in this project has vCon expertise automatically
- Persistent access across sessions
- Share with team members

### Option 3: Claude for Work/Enterprise
1. Go to your organization's resources
2. Create a new shared resource
3. Upload `SKILL.md` and documentation files
4. Set access permissions
5. Share resource link with team members

### Option 4: Claude API Integration
```python
# Read the skill file
with open('SKILL.md', 'r') as f:
    vcon_skill = f.read()

# Include in API calls
message = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4096,
    system=[{
        "type": "text",
        "text": vcon_skill,
        "cache_control": {"type": "ephemeral"}
    }],
    messages=[{
        "role": "user",
        "content": "Generate Python code to validate vCons"
    }]
)
```

### File Organization
```
vcon-expert-skill/
├── SKILL.md                    # 📌 Main skill file (upload this)
├── README.md                   # This file
├── vcon-documentation/        # IETF specifications (optional)
│   ├── draft-ietf-vcon-vcon-core-01
│   ├── draft-ietf-vcon-cc-extension-01
│   └── ...
└── examples/                  # Example vCon files (optional)
    └── valid-simple.vcon
```

### Verification
**Test Basic Functionality:**
```
You: What is a vCon?

Claude: A vCon (Virtualized Conversation) is an IETF standard...
[Detailed explanation follows]
```

**Test Validation:**
```
You: Validate this vCon
[Upload vCon JSON]

Claude: I'll validate your vCon against the IETF specification...
[Detailed validation report follows]
```

## Quick Reference Guide

### Common Commands

#### Validation
```
"Validate this vCon file"
"Check if my vCon is compliant with IETF standards"
"What's wrong with this vCon?"
```

#### Code Generation
```
"Generate Go code to parse vCons"
"Create a Python vCon validator"
"Write JavaScript code to build vCons"
"Generate TypeScript interfaces for vCons"
```

#### Q&A
```
"How do vCon extensions work?"
"What's the difference between inline and external content?"
"Explain vCon signing and encryption"
"How do I create a custom extension?"
"How do I create vCon ZIP bundles?"
"What are the best practices for bundling multiple vCons?"
```

#### Analysis
```
"Analyze this vCon and give me statistics"
"Extract all transcripts from this vCon"
"Calculate total conversation duration"
"List all participants with their contact info"
```

### Quick Validation Checklist
- [ ] `"vcon": "0.3.0"` present
- [ ] Valid UUID (v4 or v8 format)
- [ ] RFC 3339 timestamps (`YYYY-MM-DDTHH:MM:SS.sssZ`)
- [ ] At least one party in `parties` array
- [ ] Party indices in bounds (0-based)
- [ ] External URLs use HTTPS
- [ ] External files have SHA-512 content_hash
- [ ] Extensions declared in `extensions` array

### vCon Structure Quick Reference
```json
{
  "vcon": "0.3.0",
  "uuid": "018c8a7e-5f3d-8000-9a2b-3c4d5e6f7a8b",
  "created_at": "2025-10-20T14:30:00.000Z",
  "parties": [{"tel": "+1-555-0100", "name": "Alice"}],
  "dialog": [{"type": "recording", "parties": [0]}]
}
```

## Usage Examples

### Example 1: Validate a vCon
```
You: Can you validate this vCon file?
[Upload vCon JSON]

Claude: [Reads SKILL.md and vcon-documentation]
I'll validate your vCon against the IETF specification...

# vCon Validation Report
**File**: customer-call.json
**vCon Version**: 0.3.0
**Form**: unsigned

## Compliance Status
✅ COMPLIANT

[Detailed validation results...]
```

### Example 2: Generate Code
```
You: Generate Python code to parse and analyze vCons with full validation

Claude: I'll create a complete Python vCon parser with Pydantic validation...

[Generates 200+ lines of production-ready Python code with:
- Complete type definitions
- Validation functions
- Analysis utilities
- Usage examples]
```

### Example 3: Answer Complex Questions
```
You: How should I handle vCon versioning when creating redacted versions?

Claude: [Reads relevant sections from SKILL.md and specifications]

Great question! vCon versioning with redactions follows a specific pattern...

When creating a redacted vCon:
1. The redacted vCon maintains the same vCon version (0.3.0)
2. It gets a NEW uuid (different from the original)
3. The `redacted` object references the original vCon's uuid
4. The `created_at` reflects when the redacted version was created
5. The original (unredacted) vCon should be encrypted if containing PII

[Provides detailed explanation with code examples...]
```

### Example 4: Extension Development
```
You: I need to create a custom extension for healthcare conversations. Help me design it.

Claude: I'll help you design a healthcare vCon extension following IETF guidelines...

Let's start by defining your extension:

1. Extension Name: "HEALTHCARE" or "HC"
2. Classification: This will likely be a Compatible Extension
3. New Parameters needed:
   - Party Object: patient_id, provider_id, mrn
   - Dialog Object: consultation_type, hipaa_compliance
   - Analysis Object: diagnosis_codes, treatment_plan

[Provides complete extension specification, registration template, 
and implementation code in all three languages]
```

## Use Cases

### Contact Center
- Call recording management
- Quality management integration
- Agent performance analytics
- Compliance and audit trails
- PCI-DSS redaction workflows

### Messaging Platforms
- Multi-platform conversation aggregation
- Chat history export/import
- Cross-platform analytics
- Message threading and grouping

### Emergency Services (ECRIT)
- 911 call documentation
- Location capture (gmlpos/civicaddress)
- Incident report attachment
- Legal admissibility (signed vCons)

### Healthcare
- HIPAA-compliant conversation storage
- Telemedicine consultation records
- Patient consent documentation
- Clinical note attachments

### Legal & Compliance
- Deposition recordings
- Evidence chain of custody
- Privileged communication protection
- Audit trail maintenance

## Technical Capabilities

### Validation
- JSON syntax validation
- Schema compliance checking
- UUID format validation (v4, v8)
- RFC 3339 timestamp verification
- Tel/SIP/mailto URL validation
- Content hash integrity (SHA-512)
- Party index bounds checking
- Extension compatibility verification

### Code Generation
- Type-safe structures (Go structs, TS interfaces, Pydantic models)
- Validation functions with detailed error messages
- Serialization/deserialization
- Builder patterns and fluent APIs
- Content hash generation
- UUID v8 generation
- JWS signing/verification
- JWE encryption/decryption

### Analysis & Extraction
- Conversation duration calculation
- Participant information extraction
- Transcript aggregation
- Statistical summaries
- Multi-format export (JSON, CSV, XML)

### vCon ZIP Bundle Operations
- Bundle creation with automatic file resolution
- Multi-vCon bundling with deduplication
- Bundle extraction and validation
- File integrity verification (SHA-512)
- Security form preservation (JWS/JWE)
- Extension support for custom data

## Key Concepts Explained

### Three Forms of vCon

1. **Unsigned** - Mutable, for in-progress conversations
   ```json
   {
     "vcon": "0.3.0",
     "uuid": "...",
     "parties": [...],
     "dialog": [...]
   }
   ```

2. **Signed (JWS)** - Immutable, integrity-protected
   ```json
   {
     "vcon": "0.3.0",
     "uuid": "...",
     "payload": "base64url_encoded_unsigned_vcon",
     "signatures": [...]
   }
   ```

3. **Encrypted (JWE)** - Confidential, privacy-protected
   ```json
   {
     "vcon": "0.3.0",
     "uuid": "...",
     "ciphertext": "encrypted_signed_vcon",
     "recipients": [...]
   }
   ```

### Redaction Workflow

```
Original vCon (unredacted)
    ↓ [Sign with JWS]
Signed Original
    ↓ [Encrypt with JWE]
Encrypted Signed Original
    ↓ [Create redacted version]
Redacted vCon (unsigned)
    ↓ [Sign]
Signed Redacted vCon
    ↓
    └→ redacted.uuid = original UUID
    └→ redacted.url = URL to encrypted original (optional)
```

### Extension Classification

**Compatible Extensions:**
- Add new fields without changing existing semantics
- Can be safely ignored by implementations that don't support them
- Don't require listing in `must_support`
- Example: CC extension adds contact center fields

**Incompatible Extensions:**
- Change existing field meanings or structure
- Require explicit support for correct interpretation
- MUST be listed in `must_support` array
- Example: Extension that changes `parties` array semantics

## Troubleshooting

### "Can't find skill documentation"
- Ensure SKILL.md is uploaded or in Project Knowledge
- Check that vcon-documentation/ folder is accessible
- Try re-uploading the skill file

### "Generated code doesn't compile"
- Specify your exact language version (Go 1.21, Python 3.11, etc.)
- Request specific framework if needed (FastAPI, Express, etc.)
- Ask for dependency list if using external packages

### "Validation failing unexpectedly"
- Verify vCon version matches (0.3.0)
- Check that all required fields are present
- Ensure party indices don't exceed array bounds
- Validate timestamp format (RFC 3339)

### "Extension not recognized"
- Check if extension is declared in `extensions` array
- Verify extension spelling and case
- Confirm extension-specific fields are correctly formatted
- Check if it needs to be in `must_support`

## Best Practices

### Security
1. Always sign vCons before encryption (JWS → JWE)
2. Use HTTPS exclusively for external URLs
3. Generate SHA-512 hashes for all external files
4. Include certificate chain (x5c) in signatures
5. Redact PII before sharing across trust boundaries

### Performance
1. Use external references for large media files (>1MB)
2. Compress with gzip for transmission
3. Cache parsed vCons in memory
4. Index vCons by UUID for fast lookups
5. Batch process analysis operations

### Privacy
1. Create redacted versions for limited access
2. Encrypt original vCons containing PII
3. Minimize data collection from the start
4. Document consent in attachments
5. Use `validation` field for identity verification

### Code Quality
1. Use type-safe languages (Go, TypeScript)
2. Validate all inputs at API boundaries
3. Handle errors gracefully with specific messages
4. Log vCon operations for audit trails
5. Test with all three vCon forms

## Comparison with Original Validator Skill

| Feature | Original Validator | vCon Expert |
|---------|-------------------|-------------|
| Validation | ✅ Yes | ✅ Yes (Enhanced) |
| Go Code Gen | ✅ Yes | ✅ Yes (Enhanced) |
| JavaScript Code Gen | ❌ No | ✅ Yes |
| Python Code Gen | ❌ No | ✅ Yes |
| Q&A Capabilities | ❌ Limited | ✅ Comprehensive |
| Extension Expertise | ✅ CC only | ✅ CC, MIMI, WTF, Custom |
| Architecture Guidance | ❌ No | ✅ Yes |
| Use Case Examples | ✅ Basic | ✅ Extensive |
| Latest IETF Updates | ❌ 0.4.0 | ✅ 0.3.0 (July 2025) |

## Support & Resources

### IETF Resources
- Working Group: https://datatracker.ietf.org/wg/vcon/
- Mailing List: vcon@ietf.org
- GitHub: https://github.com/ietf-wg-vcon/

### Getting Help
1. Ask Claude directly (that's what this skill is for!)
2. Reference the bundled IETF specifications
3. Check the examples/ directory for valid vCons
4. Review the troubleshooting section above

### Contributing
This skill is based on IETF drafts which are continuously evolving. To update:
1. Download latest drafts from datatracker.ietf.org
2. Update vcon-documentation/ folder
3. Modify SKILL.md to reflect any schema changes
4. Test validation with new examples

## Version History

### v1.0 (October 2025)
- Initial release of enhanced vCon Expert skill
- Multi-language code generation (Go, JavaScript, Python)
- Comprehensive Q&A capabilities
- Latest IETF specifications (draft-ietf-vcon-vcon-core-00)
- Extension framework expertise
- Architecture guidance

### Based on
- vcon-validator-go-code-generator (original validator skill)
- IETF vCon Working Group specifications (July 2025)
- Real-world use cases from contact centers, messaging platforms, and emergency services

## License

This skill is based on IETF specifications which are public domain. The skill itself and generated code examples are provided as-is for educational and development purposes.

## Development & Contributing

### GitHub Actions Workflow

This repository includes automated build workflows for testing and packaging:

#### Automated Builds
The workflow automatically triggers on:
- Push to main/master
- Pull requests
- Tags (v*)
- Manual trigger from GitHub UI

#### Local Testing
Test the build workflow locally:
```bash
cd /path/to/vcon-expert-skill
bash test-workflow.sh
```

#### Using act CLI (Advanced)
For full workflow testing with Docker:
```bash
# Install act CLI
brew install act  # macOS

# Run build workflow
act -j build

# Run with verbose output
act -j build -v
```

### Package Information

This vCon Expert skill represents a comprehensive upgrade from basic validators:

**Key Enhancements:**
- ✅ Multi-language code generation (Go, JavaScript, Python)
- ✅ Comprehensive Q&A capabilities
- ✅ Latest IETF specifications (draft-ietf-vcon-vcon-core-00)
- ✅ Extension framework expertise (CC, MIMI, WTF, Custom)
- ✅ Architecture guidance and best practices
- ✅ Real-world use case examples

**Original Validator vs. vCon Expert:**
| Feature | Original | vCon Expert |
|---------|----------|-------------|
| Validation | ✅ Yes | ✅ Enhanced |
| Go Code Gen | ✅ Yes | ✅ Enhanced |
| JS/TS Code Gen | ❌ No | ✅ Yes |
| Python Code Gen | ❌ No | ✅ Yes |
| Q&A Capabilities | ❌ Limited | ✅ Comprehensive |
| Extension Expertise | ✅ CC only | ✅ All extensions |
| Architecture Guidance | ❌ No | ✅ Yes |

### File Structure
```
vcon-expert-skill/
├── SKILL.md                    # Main skill file (upload to Claude)
├── README.md                   # This documentation
├── vcon-documentation/         # IETF specifications
│   ├── draft-ietf-vcon-vcon-core-01
│   ├── draft-ietf-vcon-cc-extension-01
│   └── ...
├── examples/                   # Example vCon files
│   ├── valid-simple.vcon
│   └── invalid-missing-fields.json
└── test-workflow.sh           # Local testing script
```

---

**Ready to become a vCon expert? Upload SKILL.md to Claude and start asking questions!**
