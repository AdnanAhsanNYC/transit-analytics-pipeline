# NYC MTA Transit Performance Analytics Pipeline

An end-to-end analytics engineering project analyzing NYC subway and transit ridership patterns using Python, Snowflake, dbt, and Tableau Public.

## Live Dashboard
[View on Tableau Public](https://public.tableau.com/app/profile/adnan.ahsan/viz/MTAPerformanceAnalysis2024/Story?publish=yes)

## Problem Statement
The MTA serves millions of riders daily across NYC's five boroughs. This project builds a production-style analytics pipeline to identify ridership patterns by station, borough, and transit mode — giving transit planners and analysts a data-driven view of system performance.

## Stack
| Layer            | Tool                          |
|------------------|-------------------------------|
| Ingestion        | Python (requests, pandas)     |
| Data Warehouse   | Snowflake                     |
| Transformation   | dbt (staging → intermediate → marts) |
| Visualization    | Tableau Public                |
| Version Control  | Git / GitHub                  |

## Pipeline Architecture
MTA API → Python → Snowflake (RAW) → dbt → Snowflake (DBT_DEV) → Tableau Public

## Project Structure
transit-analytics/
├── data/
│   ├── raw/          ← raw API pull (not tracked in git)
│   └── clean/        ← mart CSVs exported for Tableau
├── ingestion/        ← Python ingestion scripts
└── notebooks/        ← exploration and loading notebooks
transit_dbt/
├── models/
│   ├── staging/      ← stg_mta_ridership (clean + type cast)
│   ├── intermediate/ ← int_daily_ridership (hourly → daily)
│   └── marts/        ← station performance, borough trends, transit mode
├── tests/            ← dbt schema tests
└── dbt_project.yml

## dbt Models
| Model | Layer | Description |
|-------|-------|-------------|
| stg_mta_ridership | Staging | Cleans raw MTA data, casts types, filters nulls |
| int_daily_ridership | Intermediate | Aggregates hourly records to daily by station |
| mart_station_performance | Mart | Total and avg daily ridership per station |
| mart_borough_trends | Mart | Daily ridership trends by borough |
| mart_transit_mode | Mart | Ridership breakdown by transit mode |

## dbt Tests
- 10/10 tests passing
- not_null, unique, and accepted_values tests across all mart models

## Key Findings
1. **Times Square is the busiest station by 2x** — handling over 700k riders vs ~350k for Grand Central in second place
2. **Subway accounts for the vast majority of MTA ridership** — tram and Staten Island Railway represent a small fraction
3. **Manhattan dominates borough ridership** — but Brooklyn shows the strongest weekday consistency
4. **Ridership dips are visible on weekends** across all boroughs, validating the data quality

## Data Source
- **Provider:** MTA via NYC Open Data (Socrata API)
- **Dataset:** MTA Subway Hourly Ridership — Beginning February 2022
- **Link:** https://data.ny.gov/Transportation/MTA-Subway-Hourly-Ridership-Beginning-February-2022/wujg-7c2s
- **Period:** 2024 full year (pre-aggregated daily totals)
