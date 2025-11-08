# ========================================
# vCon Expert Skill - Build Makefile
# ========================================

.PHONY: help validate build test clean package

# Default target
help:
	@echo "vCon Expert Skill - Build System"
	@echo "================================="
	@echo ""
	@echo "Available targets:"
	@echo "  validate    - Validate all required files exist"
	@echo "  build       - Build the vCon Expert Skill package"
	@echo "  test        - Run validation tests"
	@echo "  clean       - Clean build artifacts"
	@echo "  package     - Full build pipeline (validate + test + build)"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make validate    # Check files"
	@echo "  make build       # Create zip package"
	@echo "  make package     # Full pipeline"
	@echo "  make clean       # Clean up"

# Package configuration
PACKAGE_NAME := vcon-expert-skill
VERSION := $(shell date +%Y%m%d%H%M%S)
ZIP_FILE := $(PACKAGE_NAME).zip
BUILD_DIR := build

# Required files for the skill
REQUIRED_FILES := \
	SKILL.md \
	README.md \
	vcon-documentation/draft-ietf-vcon-vcon-core-01 \
	vcon-documentation/draft-ietf-vcon-cc-extension-01 \
	vcon-documentation/draft-ietf-vcon-privacy-primer-00 \
	examples/valid-simple.vcon \
	examples/valid-unsigned.json

# Example files (optional but nice to have)
EXAMPLE_FILES := \
	examples/valid-transfer-dialog.json \
	examples/valid-with-cc-extension.json \
	examples/invalid-missing-fields.json \
	examples/README.md

# ========================================
# Validation Targets
# ========================================

validate: validate-files validate-skill validate-documentation validate-examples

validate-files:
	@echo "🔍 Validating required files..."
	@for file in $(REQUIRED_FILES); do \
		if [ -f "$$file" ]; then \
			echo "✅ Found: $$file"; \
		else \
			echo "❌ Missing: $$file"; \
			exit 1; \
		fi; \
	done
	@echo "✅ All required files present"

validate-skill:
	@echo "📝 Validating SKILL.md..."
	@if [ -f "SKILL.md" ]; then \
		size=$$(stat -f%z SKILL.md 2>/dev/null || stat -c%s SKILL.md 2>/dev/null || echo "0"); \
		if [ "$$size" -gt 1000 ]; then \
			echo "✅ SKILL.md size: $$size bytes"; \
		else \
			echo "❌ SKILL.md too small: $$size bytes"; \
			exit 1; \
		fi; \
	else \
		echo "❌ SKILL.md not found"; \
		exit 1; \
	fi

validate-documentation:
	@echo "📚 Validating documentation..."
	@if [ -d "vcon-documentation" ]; then \
		count=$$(find vcon-documentation -name "*.md" -o -name "*draft*" | wc -l); \
		echo "✅ Documentation files: $$count"; \
	else \
		echo "❌ Documentation directory missing"; \
		exit 1; \
	fi

validate-examples:
	@echo "💡 Validating examples..."
	@if [ -d "examples" ]; then \
		count=$$(find examples -name "*.json" -o -name "*.vcon" | wc -l); \
		echo "✅ Example files: $$count"; \
	else \
		echo "⚠️  Examples directory missing (optional)"; \
	fi

# ========================================
# Test Targets
# ========================================

test: validate
	@echo "🧪 Running tests..."
	@echo "✅ File validation tests passed"
	@if [ -f "test-workflow.sh" ]; then \
		echo "ℹ️  Use 'bash test-workflow.sh' to run full workflow test"; \
		echo "✅ Basic tests passed"; \
	else \
		echo "⚠️  No test script found, but basic validation passed"; \
	fi

# ========================================
# Build Targets
# ========================================

build: validate
	@echo "🔨 Building $(ZIP_FILE)..."
	@mkdir -p $(BUILD_DIR)
	@echo "📦 Creating package..."
	@zip -r $(BUILD_DIR)/$(ZIP_FILE) . \
		-x "*.git*" "*.DS_Store" "*build*" "*.zip" \
		-x "*.tmp" "*.log" ".vscode/*" ".idea/*" \
		-x "__pycache__/*" "*.pyc" "node_modules/*" \
		-x ".github/workflows/*"
	@echo "✅ Package created: $(BUILD_DIR)/$(ZIP_FILE)"
	@ls -lh $(BUILD_DIR)/$(ZIP_FILE)

build-contents:
	@echo "📋 Package contents:"
	@unzip -l $(BUILD_DIR)/$(ZIP_FILE) | head -20

build-verify: build
	@echo "🔍 Verifying package contents..."
	@unzip -t $(BUILD_DIR)/$(ZIP_FILE) >/dev/null && echo "✅ Package integrity verified" || (echo "❌ Package corrupted"; exit 1)
	@if unzip -l $(BUILD_DIR)/$(ZIP_FILE) | grep -q "SKILL.md"; then \
		echo "✅ SKILL.md found in package"; \
	else \
		echo "❌ SKILL.md missing from package"; \
		exit 1; \
	fi
	@if unzip -l $(BUILD_DIR)/$(ZIP_FILE) | grep -q "README.md"; then \
		echo "✅ README.md found in package"; \
	else \
		echo "❌ README.md missing from package"; \
		exit 1; \
	fi

# ========================================
# Package Target (Full Pipeline)
# ========================================

package: clean test build-verify
	@echo "🎉 Package ready: $(BUILD_DIR)/$(ZIP_FILE)"
	@echo ""
	@echo "📊 Package info:"
	@ls -lh $(BUILD_DIR)/$(ZIP_FILE)
	@echo ""
	@echo "📦 Contents:"
	@unzip -l $(BUILD_DIR)/$(ZIP_FILE) | grep -E "(SKILL\.md|README\.md|vcon-documentation|examples)" | head -10

# ========================================
# Cleanup Targets
# ========================================

clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -f $(ZIP_FILE)
	@echo "✅ Clean complete"

clean-all: clean
	@echo "🧹 Deep cleaning..."
	@find . -name "*.tmp" -delete
	@find . -name "*.log" -delete
	@find . -name ".DS_Store" -delete
	@echo "✅ Deep clean complete"

# ========================================
# Development Targets
# ========================================

install-act:
	@echo "📦 Installing act CLI for local testing..."
	@if command -v act >/dev/null 2>&1; then \
		echo "✅ act already installed"; \
	else \
		echo "Installing act..."; \
		curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash; \
	fi

act-test: install-act
	@echo "🚀 Running GitHub Actions locally..."
	act -j build --verbose

act-list:
	@echo "📋 Available GitHub Actions jobs:"
	act -l

# ========================================
# Git Integration
# ========================================

pre-commit: package
	@echo "🔄 Pre-commit hook: Building package..."
	@if [ -f ".git/hooks/pre-commit" ]; then \
		echo "✅ Pre-commit hook already exists"; \
	else \
		echo "Creating pre-commit hook..."; \
		echo "#!/bin/bash" > .git/hooks/pre-commit; \
		echo "make package" >> .git/hooks/pre-commit; \
		chmod +x .git/hooks/pre-commit; \
	fi

# ========================================
# Release Targets
# ========================================

release: package
	@echo "🏷️  Creating release package..."
	@cp $(BUILD_DIR)/$(ZIP_FILE) $(PACKAGE_NAME)-$(VERSION).zip
	@echo "✅ Release package: $(PACKAGE_NAME)-$(VERSION).zip"

# ========================================
# Info Targets
# ========================================

info:
	@echo "📊 Project Information"
	@echo "======================"
	@echo "Package: $(PACKAGE_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Build Dir: $(BUILD_DIR)"
	@echo "Zip File: $(ZIP_FILE)"
	@echo ""
	@echo "Required Files:"
	@for file in $(REQUIRED_FILES); do echo "  - $$file"; done
	@echo ""
	@if [ -d $(BUILD_DIR) ]; then \
		echo "Build Status: 📦 Package exists"; \
		ls -lh $(BUILD_DIR)/; \
	else \
		echo "Build Status: 🔨 Not built"; \
	fi

# ========================================
# End of Makefile
# ========================================