# Synthetic-Data-Modelling

## Layers
- **Staging**: 1:1 with raw source, column renaming and light cleaning only
- **Intermediate**: Joins and business logic, not exposed to stakeholders
- **Marts**: Fact and dimension tables, primary stakeholder layer
- **Aggregations**: Pre-aggregated metrics for dashboards

## Key Metrics
- **MRR**: Monthly recurring revenue from active subscriptions
- **Churn Rate**: % of subscriptions cancelled per month
- **CLV**: Total revenue attributed to each customer
- **Product Performance**: Revenue and subscription counts per product