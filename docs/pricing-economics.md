# KM0 Cloud pricing economics (internal)

**Status:** Internal operator reference. Not published on the public site.  
**Last updated:** June 2026  
**Related issue:** GitHub #25

This document models KM0 Cloud storage economics for the public **500 GB / €1.99 per month** plan. Figures are planning assumptions for margin review, not audited financial statements.

## Assumptions

| Parameter | Value | Notes |
|-----------|-------|-------|
| Public plan | 500 GB quota, €1.99/month | Matches `/pricing/` copy |
| Real infrastructure cost | **€2.03 per TB per month** | All-in storage cost basis supplied by operations |
| Average quota usage | **30%** | Overselling scenario: most users use a fraction of assigned quota |
| Cost uplift scenario | **+19%** on €2.03 | Stress test when infrastructure financing or cost base rises |

**TB conversion:** 1 TB = 1024 GB (binary, consistent with quota math in this doc).

## Formulas

```text
revenue_per_tb_month   = plan_price × (1024 / plan_quota_gb)
cost_per_customer      = (plan_quota_gb / 1024) × real_tb_cost × usage_factor
gross_margin_customer  = plan_price − cost_per_customer
gross_margin_pct       = gross_margin_customer / plan_price × 100
```

Where `usage_factor` is `1.0` for full-quota usage or `0.30` for the overselling scenario.

## Scenario 1: Base margin (100% quota usage)

Each customer is assumed to use the full 500 GB quota.

| Metric | Calculation | Result |
|--------|-------------|--------|
| Revenue per TB/month | €1.99 × (1024 / 500) | **€4.08** |
| Cost per customer/month | (500 / 1024) × €2.03 | **€0.99** |
| Gross margin per customer | €1.99 − €0.99 | **€1.00** |
| Gross margin % | €1.00 / €1.99 | **~50%** |
| Margin per sold TB (full use) | €4.08 − €2.03 | **€2.05/TB/month** |

At full usage, infrastructure cost is about half of plan revenue.

## Scenario 2: Overselling (30% average quota usage)

Most customers use ~150 GB on average while retaining a 500 GB quota.

| Metric | Calculation | Result |
|--------|-------------|--------|
| Effective storage used | 500 GB × 30% | **150 GB (0.146 TB)** |
| Cost per customer/month | 0.146 × €2.03 | **€0.30** |
| Gross margin per customer | €1.99 − €0.30 | **€1.69** |
| Gross margin % | €1.69 / €1.99 | **~85%** |
| Physical TB per 100 customers | 100 × 0.146 TB | **14.6 TB** |
| Revenue per 100 customers | 100 × €1.99 | **€199/month** |
| Infrastructure cost per 100 customers | 14.6 × €2.03 | **€29.64/month** |

Overselling improves margin only if average usage stays near the assumed 30% and total sold quota does not exceed safe physical capacity.

## Scenario 3: +19% infrastructure cost uplift

Real TB cost becomes €2.03 × 1.19 = **€2.4157/TB/month**.

### 3a. Full quota usage (+19% cost)

| Metric | Calculation | Result |
|--------|-------------|--------|
| Cost per customer/month | (500 / 1024) × €2.4157 | **€1.18** |
| Gross margin per customer | €1.99 − €1.18 | **€0.81** |
| Gross margin % | €0.81 / €1.99 | **~41%** |
| Margin per sold TB | €4.08 − €2.4157 | **€1.66/TB/month** |

### 3b. 30% usage (+19% cost)

| Metric | Calculation | Result |
|--------|-------------|--------|
| Cost per customer/month | 0.146 × €2.4157 | **€0.35** |
| Gross margin per customer | €1.99 − €0.35 | **€1.64** |
| Gross margin % | €1.64 / €1.99 | **~82%** |

## Summary comparison

| Scenario | Cost/customer | Margin/customer | Margin % |
|----------|---------------|-----------------|----------|
| Base (100% usage) | €0.99 | €1.00 | ~50% |
| Overselling (30% usage) | €0.30 | €1.69 | ~85% |
| +19% cost, 100% usage | €1.18 | €0.81 | ~41% |
| +19% cost, 30% usage | €0.35 | €1.64 | ~82% |

## Operational notes

- Update `real_tb_cost` when Hetzner invoices, backup storage, or labour share changes.
- Overselling assumptions require monitoring of **actual usage percentiles** (p50, p90, p99).
- Public `/pricing/` copy uses **indicative market references**, not competitor equivalence. Economics here inform KM0 plan pricing only.
- Before changing the public €1.99 / 500 GB offer, re-run all four rows in the summary table.

## Recalculation checklist

1. Set `plan_price`, `plan_quota_gb`, `real_tb_cost`, `usage_factor`.
2. Compute revenue per TB: `plan_price × 1024 / plan_quota_gb`.
3. Compute cost per customer: `(plan_quota_gb / 1024) × real_tb_cost × usage_factor`.
4. Record margin € and %; compare against minimum acceptable margin target from operations.
