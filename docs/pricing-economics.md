# KM0 Cloud pricing economics (internal)

**Status:** Internal operator reference. Not published on the public site.  
**Last updated:** September 2026  
**Related issue:** GitHub #25

This document models KM0 Cloud storage economics for the public **150 GB / €1.99 per month** plan. Figures are planning assumptions for margin review, not audited financial statements.

## Assumptions

| Parameter | Value | Notes |
|-----------|-------|-------|
| Public plan | 150 GB quota, €1.99/month | Matches `/pricing/` copy |
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

Each customer is assumed to use the full 150 GB quota.

| Metric | Calculation | Result |
|--------|-------------|--------|
| Revenue per TB/month | €1.99 × (1024 / 150) | **€13.58** |
| Cost per customer/month | (150 / 1024) × €2.03 | **€0.30** |
| Gross margin per customer | €1.99 − €0.30 | **€1.69** |
| Gross margin % | €1.69 / €1.99 | **~85%** |
| Margin per sold TB (full use) | €13.58 − €2.03 | **€11.55/TB/month** |

At full usage, infrastructure cost is a small share of plan revenue.

## Scenario 2: Overselling (30% average quota usage)

Most customers use a fraction of quota while retaining a 150 GB quota.

| Metric | Calculation | Result |
|--------|-------------|--------|
| Effective storage used | 150 GB × 30% | **45 GB (0.044 TB)** |
| Cost per customer/month | 0.044 × €2.03 | **€0.09** |
| Gross margin per customer | €1.99 − €0.09 | **€1.90** |
| Gross margin % | €1.90 / €1.99 | **~95%** |
| Physical TB per 100 customers | 100 × 0.044 TB | **4.4 TB** |
| Revenue per 100 customers | 100 × €1.99 | **€199/month** |
| Infrastructure cost per 100 customers | 4.4 × €2.03 | **€8.93/month** |

Overselling improves margin only if average usage stays near the assumed 30% and total sold quota does not exceed safe physical capacity.

## Scenario 3: +19% infrastructure cost uplift

Real TB cost becomes €2.03 × 1.19 = **€2.4157/TB/month**.

### 3a. Full quota usage (+19% cost)

| Metric | Calculation | Result |
|--------|-------------|--------|
| Cost per customer/month | (150 / 1024) × €2.4157 | **€0.35** |
| Gross margin per customer | €1.99 − €0.35 | **€1.64** |
| Gross margin % | €1.64 / €1.99 | **~82%** |
| Margin per sold TB | €13.58 − €2.4157 | **€11.16/TB/month** |

### 3b. 30% usage (+19% cost)

| Metric | Calculation | Result |
|--------|-------------|--------|
| Cost per customer/month | 0.044 × €2.4157 | **€0.11** |
| Gross margin per customer | €1.99 − €0.11 | **€1.88** |
| Gross margin % | €1.88 / €1.99 | **~94%** |

## Operator notes

- Public marketing comparison table uses decimal TB (150 GB ≈ 0.15 TB → ≈€13.27/TB/month). This doc uses binary TB (1024) for margin math.
- Blog day-8 / day-9 posts keep the historical **500 GB** decision as written at the time; live site copy is the source of truth for current offer.

## Quote checklist (1 TB+ / multi-TB, internal)

Do **not** publish per-TB list prices on the public site until commercial numbers are set. When quoting larger capacity, put these in writing:

| Item | What to state |
|------|----------------|
| Price per TB | Monthly (or committed) rate; currency; VAT treatment |
| Location | Hetzner / Falkenstein (or current EU region) |
| Backup / retention | What is backed up, how long, restore expectations |
| Exit | How data leaves, notice period, deletion after leave |

Public pitch (homepage + `/pricing/`): self-serve stays **150 GB / €1.99**; **1 TB+ / multi-TB on request**; same EU servers, same support.
