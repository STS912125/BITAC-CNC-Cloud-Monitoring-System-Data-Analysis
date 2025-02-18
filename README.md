# CNC Cloud Monitoring System Analysis

## Overview
This is an ongoing project where I analyze the CNC Cloud Monitoring System at BITAC. The goal is to understand how the system tracks machine availability, performance, and quality, and identify any issues or inconsistencies in the data.

## What I'm Doing
This project started as me just observing the website, writing down any problems I saw, and taking relevant screenshots. Over time, I started playing around with the logs that get generated every few seconds, writing scripts to explore the data.

My main goal is to do something interesting with this data. Since I'm also learning data analysis on the side, this is a way to apply what I'm learning in a real-world scenario. I am hoping the insights from my code will be useful in some way.

Honestly, I don’t know exactly where this project is going, but that’s part of the fun!

Since my findings and notes on the CNC Cloud Monitoring System are not directly related to the code, I am keeping them as a separate live document on Google Docs. You can access and follow my latest updates here:

[Findings & Notes on the CNC Cloud Monitoring System](https://docs.google.com/document/d/1CJULp8SM4bix6GLSg86VqD7ajgxGSvh5zD6q1L6QrDg/edit?usp=sharing)


## Data Collection
The data comes from daily machining reports, which I had to manually download. Each file represents a single day’s report in Excel format. Since there is no automatic API access (at least for now), I wrote a script to merge all reports for a given month into a single dataset.
The website doesn't let you download large amounts of data at once, which is pretty frustrating.
This means I have to download reports manually and stitch them together, making automation harder than it should be.

## Methodology

### **1. Merging and Cleaning the Data**
- Read all daily machining reports (`Machining Report 1.xlsx` to `Machining Report 31.xlsx`).
- Combined them into one large dataset (`MachiningReportJanuary.csv`).
- Formatted timestamps (`Produced At`) and calculated time differences between consecutive entries.
- Extracted hourly and daily values for further analysis.

### **2. Analyzing Machine Availability**
- **Availability Calculation:**
  - Filtered data to remove large time gaps (`Time.Difference < 7200` seconds) to avoid skewing results.
  - Grouped data by `Day`, `Station Name`, and `Hour`.
  - Computed total active and stopped time per hour.
  - Used cumulative sums to track machine uptime across the day.
  - Calculated **Availability** as:  
    \[\frac{\text{Sum of Active Time} \times 100}{\text{Total Elapsed Time}}\]
  - Extracted the last availability value for each day to get the **daily availability**.

### **3. Analyzing Machine Performance**
- **Performance Calculation:**
  - Tracked `M30.Counter.1` to count the number of completed operations.
  - Calculated `Produced Counter` as the difference between consecutive M30 counts.
  - Aggregated total produced items per hour.
  - Used cumulative sums to track production trends.

## Next Steps
- Add **Product-Wise Availability Analysis** (currently missing).

## Contributions & Contact
This is an ongoing project. If you're working on CNC monitoring, OEE optimization, or industrial data analytics, feel free to contribute! You can reach me via LinkedIn or open an issue on this repo.

---

I'll keep updating this as I go!

