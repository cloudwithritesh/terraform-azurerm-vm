#!/usr/bin/env bash
# Enables no-code provisioning for the published module and sets dropdown options.
# Needs a USER or TEAM token (organization tokens are rejected by this endpoint).
# Usage: TFC_TOKEN=xxx TFC_ORG=my-org ./enable-nocode.sh 1.0.0
set -euo pipefail
: "${TFC_TOKEN:?set TFC_TOKEN}" "${TFC_ORG:?set TFC_ORG}"
VERSION="${1:-1.0.0}"
API="https://app.terraform.io/api/v2"
H=(-H "Authorization: Bearer $TFC_TOKEN" -H "Content-Type: application/vnd.api+json")

# 1) registry module id (private/<org>/<name>/<provider>)
MOD_ID=$(curl -sf "${H[@]}" "$API/organizations/$TFC_ORG/registry-modules/private/$TFC_ORG/vm/azurerm" | jq -r .data.id)
echo "Registry module id: $MOD_ID"

# 2) enable no-code + dropdown options (keep in sync with google-form/Code.gs OPTIONS)
cat > /tmp/nocode-payload.json <<JSON
{
  "data": {
    "type": "no-code-modules",
    "attributes": { "version-pin": "$VERSION", "enabled": true },
    "relationships": {
      "registry-module": { "data": { "id": "$MOD_ID", "type": "registry-module" } },
      "variable-options": { "data": [
        { "type": "variable-options", "attributes": { "variable-name": "environment", "variable-type": "string",
          "options": ["dev", "test", "prod"] } },
        { "type": "variable-options", "attributes": { "variable-name": "location", "variable-type": "string",
          "options": ["southeastasia", "eastasia", "australiaeast"] } },
        { "type": "variable-options", "attributes": { "variable-name": "vm_size", "variable-type": "string",
          "options": ["Standard_B1s", "Standard_B2s", "Standard_B2ms"] } }
      ] }
    }
  }
}
JSON

curl -sf "${H[@]}" -X POST -d @/tmp/nocode-payload.json \
  "$API/organizations/$TFC_ORG/no-code-modules" | jq '{no_code_module_id: .data.id}'
echo "^ put this id in Apps Script property NOCODE_MODULE_ID"
