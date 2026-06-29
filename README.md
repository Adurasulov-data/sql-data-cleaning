# SQL Data Cleaning Project — Customer Database

**Tool:** SQL (MS SQL Server)  
**Dataset:** 25 customer records with real-world data quality issues  
**Goal:** Clean and standardize a messy customer database

---

## Problem

The raw customer database contained multiple data quality issues commonly found in real-world scenarios:

| Issue | Example |
|---|---|
| Duplicate records | John Doe appeared twice (ID 1 & 21) |
| Invalid emails | `johndoe@gmailcom`, `@em@il.com`, `email,com` |
| NULL names | Row 7 and 12 had `NULL` as full_name |
| Inconsistent phone formats | `987654321`, `444*555*6666`, `321.654.0987` |
| NULL addresses/phones | String `'NULL'` instead of actual NULL |
| Special characters in names | `Michael! White`, `Daniel! Clark`, `David "Owen"` |
| Inconsistent date formats | `1990/12/05` vs `1985-04-23` |
| Inconsistent text case | Mixed uppercase/lowercase |

---

## Before & After

### Before Cleaning
| customer_id | full_name | email | phone |
|---|---|---|---|
| 1 | John Doe | johndoe@gmailcom | 123-456-7890 |
| 7 | NULL | charles.miller@email.com | 555-888-0000 |
| 10 | Daniel! Clark | danielclark@email,com | 444*555*6666 |
| 21 | John Doe | johndoe@gmailcom | 123-456-7890 |
| 22 | Jane, Smith | jane.smith@email.com | 987654321 |

### After Cleaning
| customer_id | full_name | email | phone |
|---|---|---|---|
| 1 | john doe | johndoe@gmail.com | 123-456-7890 |
| 7 | charles miller | charles.miller@email.com | 555-888-0000 |
| 10 | daniel clark | danielclark@email.com | 444-555-6666 |
| ~~21~~ | ~~duplicate removed~~ | | |
| 22 | jane smith | jane.smith@email.com | 987-765-321 |

---

## Cleaning Steps

### 1. Remove Duplicates
Used `ROW_NUMBER()` window function with `PARTITION BY` to identify and delete duplicate rows based on `full_name` and `email`.

### 2. Fix Full Names
- Removed special characters (`,`, `!`, `"`) using `REPLACE()`
- Fixed NULL names by extracting from email using `PARSENAME()`
- Standardized to lowercase

### 3. Fix Emails
- Fixed missing dots: `@gmailcom` → `@gmail.com`
- Fixed double `@`: `@em@il.com` → `@email.com`
- Fixed commas in domain: `email,com` → `email.com`
- Fixed double dots: `email..com` → `email.com`
- Set empty emails to `'unknown'`

### 4. Standardize Phone Numbers
- Replaced `.` and `*` separators with `-` using `TRANSLATE()`
- Formatted unformatted numbers to `XXX-XXX-XXXX`
- Set NULL/string 'NULL' phones to `'unknown'`

### 5. Fix Addresses
- Replaced string `'NULL'` with `'unknown'`
- Standardized to lowercase

### 6. Standardize Dates
- Replaced `/` with `-`: `1990/12/05` → `1990-12-05`
- Changed column data type to `DATE`

### 7. Standardize Gender
- Converted to lowercase: `M` → `m`, `F` → `f`

---

## Key SQL Techniques Used

- `ROW_NUMBER()` window function — duplicate detection
- `WITH CTE` — Common Table Expressions
- `REPLACE()` / `TRANSLATE()` — string manipulation
- `PARSENAME()` — extracting name parts from email
- `CONCAT()` / `LEFT()` / `RIGHT()` / `SUBSTRING()` — string formatting
- `ALTER TABLE ALTER COLUMN` — data type changes
- `INFORMATION_SCHEMA.COLUMNS` — schema inspection

---

## Files

```
sql-data-cleaning/
├── cleaning.sql       # Full cleaning script with comments
└── README.md
```

---

## Skills Demonstrated

This project demonstrates ability to handle real-world dirty data — a critical skill for any data analyst role. Data cleaning typically takes 60-80% of a data analyst's time in practice.
