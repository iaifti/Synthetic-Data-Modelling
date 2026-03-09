# Saas Data Pipeline
---
### dbt + Snowflake Data Engineering Project

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

---

## Overview

End-to-end analytics engineering project modelling a Stripe-like payments platform. Raw synthetic data across customers, payments, products, invoices, and subscriptions is ingested into Snowflake and transformed using dbt into a fully tested, documented, and stakeholder-ready analytics layer.

The pipeline produces key SaaS business metrics including **Monthly Recurring Revenue (MRR)**, **churn rate**, **customer lifetime value (CLV)**, and **product performance** — all built with production-grade practices.

---

## Architecture

```
Raw (Snowflake)
      │
      ▼
Staging          ← Cleans and renames columns 1:1 with source tables
      │
      ▼
Intermediate     ← Joins and business logic (not exposed to stakeholders)
      │
      ▼
Marts            ← Fact and dimension tables (primary stakeholder layer)
      │
      ▼
Aggregations     ← Pre-aggregated metrics ready for dashboards
```

---

## Project Structure

```
stripe_analytics/
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── schema.yml
│   │   ├── stg_customers.sql
│   │   ├── stg_payments.sql
│   │   ├── stg_products.sql
│   │   ├── stg_invoices.sql
│   │   └── stg_subscriptions.sql
│   │
│   ├── intermediate/
│   │   ├── int_customer_subscriptions.sql
│   │   ├── int_customer_invoices.sql
│   │   ├── int_customer_payments.sql
│   │   └── int_product_revenue.sql
│   │
│   ├── marts/
│   │   ├── core/
│   │   │   ├── schema.yml
│   │   │   ├── dim_customers.sql
│   │   │   ├── dim_products.sql
│   │   │   └── fct_payments.sql
│   │   └── finance/
│   │       ├── fct_invoices.sql
│   │       └── fct_subscriptions.sql
│   │
│   └── aggregations/
│       ├── agg_monthly_revenue.sql
│       ├── agg_mrr.sql
│       ├── agg_churn_rate.sql
│       ├── agg_customer_lifetime_value.sql
│       └── agg_product_performance.sql
│
├── tests/
│   ├── assert_subscription_dates_valid.sql
│   └── assert_no_revenue_without_customer.sql
│
├── dbt_project.yml
└── README.md
```


## Tech Stack

| Tool | Purpose |
|---|---|
| **Snowflake** | Cloud data warehouse — raw ingestion and all transformed layers |
| **dbt Core** | Data transformation, testing, and documentation |
| **SQL** | All transformation logic |
| **Git / GitHub** | Version control |

---

## Data Sources

Synthetic data modelling a Stripe-like payments platform:

| Table | Description |
|---|---|
| `customers` | Customer profile and account data |
| `payments` | Individual payment transactions |
| `products` | Product catalogue with pricing and type |
| `invoices` | Invoice records per customer |
| `subscriptions` | Customer subscription lifecycle data |

---

## Key Metrics Produced

### Monthly Recurring Revenue (MRR)
Active subscription revenue aggregated by month, including cumulative MRR growth tracking.

### Churn Rate
Monthly churn and retention rates calculated from subscription status transitions.

### Customer Lifetime Value (CLV)
Total and average revenue per customer, with first/last payment dates and lifespan in days.

### Product Performance
Revenue, active and cancelled subscriptions, and churn rate broken down by product.

### Monthly Revenue
Total transaction volume, unique customers, and cumulative revenue over time.

---

## Materialisation Strategy

| Layer | Materialisation | Reason |
|---|---|---|
| Staging | View | Lightweight, always reflects source |
| Intermediate | View | Logic layer, not queried directly |
| Marts | Table | Stakeholders query these directly |
| Aggregations | Table | Heavy aggregations, saves compute |

---

## Testing

Both generic and singular tests are implemented across all layers.

**Generic tests (via schema.yml):**
- `unique` and `not_null` on all primary keys
- `relationships` to enforce referential integrity across models
- `accepted_values` on status fields (e.g. `active`, `canceled`, `succeeded`)

**Singular tests (custom SQL):**
- `assert_payment_amount_positive` — no zero or negative payment amounts
- `assert_subscription_dates_valid` — `ended_at` must not precede `started_at`
- `assert_no_revenue_without_customer` — all payments must have a valid customer

```bash
# Run all tests
dbt test

# Run tests by layer
dbt test --select staging
dbt test --select marts
```

---

## Getting Started

### Prerequisites
- Snowflake account with a `RAW` schema loaded
- dbt Core installed (`pip install dbt-snowflake`)

### Setup

1. Clone the repo
```bash
git clone https://github.com/your-username/synthetic-data-modelling.git
cd stripe-analytics
```

2. Configure your Snowflake connection in `~/.dbt/profiles.yml`
```yaml
stripe_analytics:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: your_account
      user: your_user
      password: your_password
      role: your_role
      database: your_database
      warehouse: your_warehouse
      schema: dev
```

3. Test your connection
```bash
dbt debug
```

4. Run the full pipeline
```bash
dbt run
dbt test
```

5. Generate and serve documentation
```bash
dbt docs generate
dbt docs serve
```

---

## What I Learned

- Designing a **multi-layer dbt project** (staging → intermediate → marts → aggregations) following analytics engineering best practices
- Handling **fan-out join risks** when tables share only a customer-level foreign key
- Writing **generic and singular dbt tests** to enforce data quality at every layer
- Modelling core **SaaS metrics** (MRR, churn, CLV) from raw transactional data
- Managing **Snowflake schema configuration** via `dbt_project.yml` materialisation settings: Revenue and subscription counts per product
