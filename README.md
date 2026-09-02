# Telco_Customer_Churn_Analysis

End-to-end churn analysis on a telecom customer base — from raw data cleaning to an interactive Power BI dashboard — surfacing where revenue is leaking and why.

**Tools:** Python (pandas) · PostgreSQL · Power BI

---

## 🔍 Overview

Customer churn is one of the costliest problems for subscription-based businesses. This project analyzes **7,043 telecom customers** to answer three questions:

1. **Who** is churning, and what do they have in common?
2. **How much revenue** is at risk because of it?
3. **What actions** would actually move the needle?

The workflow: raw CSV → Python cleaning → PostgreSQL for segmentation and cohort analysis → Power BI for a four-page interactive dashboard.

---

## 🧾 Key Insights

### Overall Churn
- **26.54% churn rate** (1.87K of 7,043 customers), with an average customer tenure of **32.37 months**.
- Churn is heavily front-loaded: **784 customers churn in months 0-6 alone**, dropping to 325 (7-12mo), 294 (13-24mo), 253 (25-48mo), and just 213 beyond 49 months — the first six months are the highest-risk window by far.

### Who Churns
- **Gender is not a driver** — churn splits almost evenly (49.76% female vs. 50.24% male).
- **Senior citizens churn disproportionately**: they're only 16.21% of the base but account for 476 of the churned customers vs. 1,393 non-seniors — a much higher churn *rate* relative to their population share.
- **Customers without dependents churn far more** (1,543 vs. 326 with dependents), and **customers without a partner churn more** than those with one (vs. 669 partnered churners) — single-account holders are more flight-risk.
- **Paperless billing customers churn at a much higher rate** (1,400 vs. 469 for paper billing) — worth investigating whether this reflects a more price-sensitive, digital-first segment.

### Contract, Payment & Internet Service
- **Month-to-month contracts dominate churn**: 1,655 churned customers vs. just 166 (one-year) and 48 (two-year) — contract length is the single strongest retention lever visible in the data.
- **Fiber optic customers churn most** (1,297) vs. DSL (459) and no internet service (113) — despite being a premium product, suggesting a service quality, pricing, or expectations gap.
- **Electronic check users churn most by far** (1,071) vs. mailed check (308), bank transfer (258), and credit card (232) — manual payment methods correlate strongly with churn.

### Tenure × Spend Risk Segments
| Segment | Churn Rate |
|---|---|
| Low Tenure – High Charges | **41.18%** |
| Low Tenure – Low Charges | **38.51%** |
| High Tenure – High Charges | **15.68%** |
| High Tenure – Low Charges | **3.62%** |

New, high-paying customers are the single riskiest group — tenure matters more than price sensitivity once a customer is established.

### Service Adoption
- Customers average **4 services** each; **2K are "high adoption"** vs. **3K "low adoption"**, with high-adoption customers churning at only **20.30%** vs. much higher for low-adoption customers.
- Churn rate falls steadily as services added increase — from **~44% at low service counts to ~6% at the highest** — one of the clearest protective effects in the whole dataset.
- Specific add-ons show the same pattern: churners are disproportionately customers **without** tech support (1,559 vs. 310 with it) and **without** online security (1.57K vs. 0.30K with it) — these are high-leverage, underused retention tools.

### Revenue at Risk
- **$456.12K in monthly recurring revenue**, of which **$139.13K (30.5%) is tied to churned customers** — nearly a third of revenue walks out the door.
- **Revenue loss mirrors the churn drivers**: month-to-month contracts ($121K), fiber optic ($114K), and electronic check ($84K) account for the bulk of the loss.
- Churned customers carry an **average monthly charge of $74.44** — meaningfully high-value customers, making retention efforts financially worthwhile.

---

## 🗂️ Dashboard Structure

The Power BI report is organized into four pages:

| Page | Focus |
|---|---|
| **Executive Overview** | Headline KPIs — total customers, churn count/rate, avg. tenure, churn by tenure group, internet service, payment method, and contract type |
| **Customer Profile Analysis** | Demographic and account cuts — gender, senior citizen status, dependents, partner status, paperless billing, tenure trend |
| **Service Adoption Analysis** | Churn vs. number of services subscribed, and churn by individual add-ons (streaming, tech support, online security) |
| **Revenue and Risk Analysis** | Monthly revenue at risk by contract/internet service/payment method, churned vs. retained revenue split, and churn rate by tenure–spend customer segment |

---

## 🛠️ Methodology

**1. Data Cleaning (Python)**
- Handled missing values
- Standardized categorical fields for consistent grouping
- Prepared the cleaned dataset for loading into PostgreSQL

**2. Analysis (PostgreSQL)**
SQL was used to compute churn rates and build customer segments beyond what's directly queryable in Power BI:
- Churn rate breakdowns by gender, senior citizen status, partner/dependent status, contract, and payment method
- **Monthly charge segmentation** — churn among above-average vs. below-average spenders
- **Tenure × total spend segmentation** — a 2×2 customer-segment matrix (Low/High Tenure × Low/High Charges) with churn rate per segment
- **Service adoption scoring** — a composite count of subscribed services per customer, correlated with churn
- **Cohort analysis** — customers grouped into tenure bands (0-6mo, 6-12mo, 1-2yr, 2-3yr, 3+yr) with revenue and churn metrics per cohort


**3. Visualization (Power BI)**
- Built a 4-page interactive report with drill-through-ready KPI cards, donut/bar/line visuals, and an insights panel
- Modeled revenue-at-risk by segment to make the dashboard directly actionable for retention teams

---

## 💡 Recommendations

- **Contract incentives:** Push month-to-month customers toward 1–2 year contracts (churn drops sharply with contract length) via loyalty discounts or bundled perks.
- **Fiber optic experience:** Investigate service-quality or pricing complaints driving fiber optic's outsized share of revenue loss.
- **Payment method migration:** Encourage electronic check users toward autopay (credit card/bank transfer), which shows meaningfully lower churn.
- **Early-tenure intervention:** Target the "Low Tenure – High Charges" segment (41% churn) with proactive onboarding and check-ins in the first 6 months.
- **Bundle promotion:** Actively upsell add-on services (security, backup, tech support) — adoption is strongly tied to retention.

---

## 📬 Contact

**Anwesha Abantika** 
