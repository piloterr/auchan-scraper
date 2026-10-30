#!/usr/bin/env bash
# Auchan Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/auchan/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.auchan.fr/charles-alice-specialite-pommes-mangues-sans-sucres-ajoutes/pr-C1177497
