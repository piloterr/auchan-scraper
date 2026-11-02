<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Auchan Scraper API by Piloterr – scrape Auchan data as JSON" width="100%"></a>
</p>

# Auchan Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Auchan Scraper API** lets you extract public data from Auchan as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Auchan Product API** — Effortlessly extract product details from Auchan for dynamic business insights, including nutritional information, ingredients, ratings, and reviews.
- **Auchan Search API** — Extract Auchan product listings from keyword searches for insightful market analysis and competitive edge.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Auchan Product API](#auchan-product-api) | `/v2/auchan/product` | 2 | Effortlessly extract product details from Auchan for dynamic business insights, including nutritional information, ingredients, ratings, and reviews. |
| [Auchan Search API](#auchan-search-api) | `/v2/auchan/search` | 2 | Extract Auchan product listings from keyword searches for insightful market analysis and competitive edge. |

## Table of contents

- [How it works](#how-it-works)
- [Auchan Product API](#auchan-product-api)
- [Auchan Search API](#auchan-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Auchan Product API

Effortlessly extract product details from Auchan for dynamic business insights, including nutritional information, ingredients, ratings, and reviews.

`GET | POST https://api.piloterr.com/v2/auchan/product` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | URL of the Auchan product page to extract data from. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/auchan/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.auchan.fr/charles-alice-specialite-pommes-mangues-sans-sucres-ajoutes/pr-C1177497",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type AuchanProduct = {
  id?: string;
  url?: string;
  brand?: string;
  image?: string;
  title?: string;
  rating?: number;
  features?: {
    ean?: string;
    contact?: {
      exploitant?: string;
      service_consommateur?: string;
    };
    reference?: string;
    description?: string;
    ingredients?: string;
    pays_de_fabrication?: string;
    valeurs_nutritionnelles?: {
      sel?: string;
      glucides?: string;
      proteines?: string;
      dont_sucres?: string;
      matieres_grasses?: string;
      fibres_alimentaires?: string;
      valeur_energetique_kj?: string;
      valeur_energetique_kcal?: string;
      dont_acides_gras_satures?: string;
    };
    denomination_legale_de_vente?: string;
  };
  attributes?: string[];
  reviews_count?: number;
  reviews_details?: {
    average_rating?: number;
    rating_distribution?: {
      "1"?: number;
      "2"?: number;
      "3"?: number;
      "4"?: number;
      "5"?: number;
    };
  };
};

const params = new URLSearchParams({
  "query": "https://www.auchan.fr/charles-alice-specialite-pommes-mangues-sans-sucres-ajoutes/pr-C1177497",
});

const response = await fetch(`https://api.piloterr.com/v2/auchan/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as AuchanProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/auchan/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.auchan.fr/charles-alice-specialite-pommes-mangues-sans-sucres-ajoutes/pr-C1177497"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "C1177497",
  "url": "https://www.auchan.fr/charles-alice-specialite-pommes-mangues-sans-sucres-ajoutes/pr-C1177497",
  "brand": "CHARLES & ALICE",
  "image": "https://cdn.auchan.fr/media/A0220060320000546212PRIMARY_2048x2048/B2CD/?format=rw&quality=75&width=1200&height=1200",
  "title": "Spécialité pommes mangues sans sucres ajoutés",
  "rating": 4,
  "features": {
    "ean": "3297760097143",
    "contact": {
      "exploitant": "example",
      "service_consommateur": "example"
    },
    "reference": "546212",
    "description": "Des recettes sans sucres ajoutés, sans édulcorants et sans conservateur, qui laissent s'exprimer la gourmandise naturelle des fruits.",
    "ingredients": "Purée et morceaux de mangues 50%, purée de pommes 49.8%, arôme naturel, antioxydant : acide ascorbique.",
    "pays_de_fabrication": "France",
    "valeurs_nutritionnelles": {
      "sel": "< 0,01 g",
      "glucides": "14 g",
      "proteines": "0,5 g",
      "dont_sucres": "13 g",
      "matieres_grasses": "0,5 g",
      "fibres_alimentaires": "1,5 g",
      "valeur_energetique_kj": "277 kJ",
      "valeur_energetique_kcal": "66 kcal",
      "dont_acides_gras_satures": "0,2 g"
    },
    "denomination_legale_de_vente": "Spécialité de Mangues Pommes SSA 4x100g"
  },
  "attributes": [
    "4x95g"
  ],
  "reviews_count": 13,
  "reviews_details": {
    "average_rating": 4.1,
    "rating_distribution": {
      "1": 2,
      "2": 0,
      "3": 1,
      "4": 2,
      "5": 8
    }
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `brand` | string |  |
| `image` | string |  |
| `title` | string |  |
| `rating` | integer |  |
| `features` | object |  |
| `features.ean` | string |  |
| `features.contact` | object |  |
| `features.reference` | string |  |
| `features.description` | string |  |
| `features.ingredients` | string |  |
| `features.pays_de_fabrication` | string |  |
| `features.valeurs_nutritionnelles` | object |  |
| `features.denomination_legale_de_vente` | string |  |
| `attributes` | string[] |  |
| `reviews_count` | integer |  |
| `reviews_details` | object |  |
| `reviews_details.average_rating` | number |  |
| `reviews_details.rating_distribution` | object |  |

## Auchan Search API

Extract Auchan product listings from keyword searches for insightful market analysis and competitive edge.

`GET | POST https://api.piloterr.com/v2/auchan/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Search keyword or Auchan search URL to retrieve product listings. |
| `page` | number | — | Page number for paginated search results. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/auchan/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "pomme",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type AuchanSearch = {
  results?: {
    id?: string;
    url?: string;
    brand?: unknown;
    image?: unknown;
    title?: string;
    rating?: number;
    attributes?: string[];
    reviews_count?: number;
  }[];
  pagination?: {
    next?: number;
    current?: number;
    other_pages?: number[];
    has_next_page?: boolean;
  };
};

const params = new URLSearchParams({
  "query": "pomme",
});

const response = await fetch(`https://api.piloterr.com/v2/auchan/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as AuchanSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/auchan/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "pomme"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "ebe83997-d91f-4a7e-8721-fed0fc3acf1e",
      "url": "https://www.auchan.fr/pommes-bicolores/pr-C1350678",
      "brand": null,
      "image": null,
      "title": "Pommes Bicolores",
      "rating": 3,
      "attributes": [
        "2kg"
      ],
      "reviews_count": 9
    },
    {
      "id": "e7e43bcc-6fdc-4e65-8a08-ed7fcf8fe95f",
      "url": "https://www.auchan.fr/pommes-pink-lady/pr-C1350629",
      "brand": null,
      "image": null,
      "title": "Pommes Pink Lady",
      "rating": 4.5,
      "attributes": [
        "6 pièces"
      ],
      "reviews_count": 8
    }
  ],
  "pagination": {
    "next": 2,
    "current": 1,
    "other_pages": [
      2,
      3
    ],
    "has_next_page": true
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].brand` | object |  |
| `results[].image` | object |  |
| `results[].title` | string |  |
| `results[].rating` | integer |  |
| `results[].attributes` | string[] |  |
| `results[].reviews_count` | integer |  |
| `pagination` | object |  |
| `pagination.next` | integer |  |
| `pagination.current` | integer |  |
| `pagination.other_pages` | integer[] |  |
| `pagination.has_next_page` | boolean |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Auchan plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Auchan?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/auchan/product` **2**, `/v2/auchan/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Auchan API return?

Each endpoint returns structured JSON: **Auchan Product** — `id`, `url`, `brand`, `image`, `title`, `rating`; **Auchan Search** — `results[]`, `results[].id`, `results[].url`, `results[].brand`, `results[].image`, `results[].title`.

### How do I paginate Auchan results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Auchan is a trademark of its respective owner. This repository is not affiliated with or endorsed by Auchan. Examples are released under the MIT license.</sub>
