#!/bin/bash

curl -X POST http://localhost:4567/scrape \
-H "Content-Type: application/json" \
-d '{
  "n": 10,
  "filters": {
    "batch": "W21",
    "industry": "Healthcare",
    "region": "United States",
    "tag": "Top Companies",
    "company_size": "1-10",
    "is_hiring": true,
    "nonprofit": false,
    "black_founded": true,
    "hispanic_latino_founded": false,
    "women_founded": true
  }
}'
