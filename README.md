🚚 Textile-logistics-Dispatch-dashboard
 
 📌Project Overview
    This entire project has been designed to analyse the process within the company’s logistics and dispatch operations.the         company procures Raw yarn from the market, processes it into fabric, and supplies it to textile manufacturers throughout        Gujarat. the primary objective of the project is to enhance business performance by analysing order delivery and dispatch       performance, transportation efficiency and overall supply chain operations.

   The project covers the full data pipeline:  Data Cleaning in Excel → Analysis in My SQL → Dashboard in Power BI

🏭About the Business
   The company works on B2B Model in textile supplychain
   They purchase raw POY (particle oriented yarn) and FDY (fully drawn yarn)
   Processes it into finished fabric on yarn
   Delivers to textile manufacturers across cities like Surat Ahmedabad Silvassa Vapi Navsari and Pune and loads of cities

❗Problems the Company was facing
   The company did not have clear visibility into which cities were facing the highest number of delivery issues
   It was difficult to identify underperforming delivery vendors and evaluate their performance
   Delay reasons were entered inconsistently across records
   Customer unavailability was incorrectly counted as failed deliveries 
   Transportation costs were not tracked on a monthly basis
   Many records had missing delivery dates
   Some records were missing customer details 
   Vehicle information was incomplete or inconsistent

🎯Project Objectives
   Clean and normalize 10,050 rows of logistics dispatch data
   Understand the patterns in delivery failures and delays
   Analyse vendor and customer performance
   Monitor transportation costs across different months, cities, and yarn categories
   Developed a user-friendly Power BI dashboard to support data-driven decision-making

🛠️Tools Used                                 Tool	Purpose
   Microsoft Excel                            Data cleaning and standardization
   MySQL                                      Data storage and SQL analysis
   Power BI                                   Interactive dashboard and visualization

🧹Data Cleaning & Preparation (Excel)
   The dataset contained 10,050 logistics dispatch records across 18 columns
   Before starting the analysis, several data quality issues were identified and resolved to improve accuracy and consistency 
  
Key Data Cleaning Activities:
 	Standardized delivery statuses into three clear categories: On Time, Delayed, and Failed. 
	Reclassified 873 "Customer Unavailable" deliveries as Alternate Contact Delivery and updated their status to Delayed, since     deliveries in this B2B business are made to factory locations rather than individual customers. 
	Cleaned and standardized delay reasons by correcting spelling mistakes and removing duplicate variations. 
	Formatted vehicle numbers into a consistent structure (Ex. GJ-91-X-2824) for easier tracking and reporting. 
	Filled 288 missing customer names with "Unknown" to maintain data completeness. 
	Filled 182 missing vendor names with "Unknown" where vendor information was unavailable. 
	Left 100 missing transportation cost records unchanged, as there was no reliable basis for estimating those values.
Reviewed missing delivery dates: 
  761 blank dates were associated with failed deliveries and considered valid. 
  256 records had delayed deliveries with missing dates and were flagged for further review.

🗄️SQL Analysis (MySQL) - Database: logistics_dB
   Queries Performed: Basic Analysis
   Total row count and check nulls across all columns
	 Delivery Status distribution with percentage
	 Delay Reason breakdown
  
 Delivery Performance
	Failed deliveries city-wise (top 5)
	Month-wise total orders, on-time, and failed count
  
 Vendor Analysis
	Vendor-wise fail rate ranking using DENSE_RANK + CTE
	Vendor-wise total weight dispatched and avg.cost
  
 Customer Analysis
	Customer-wise order frequency and fail rate
	Top customers by total weight
  
 Cost Analysis
	Yarn type (POY vs FDY) avg./min/max cost
	City-wise average cost
	Monthly total cost with running total using Window Functions
  
 Advanced SQL Concepts Used:
	CTEs (Common Table Expressions)
	DENSE_RANK () window function
	CASE WHEN statements
	GROUP BY with HAVING
	Subqueries

📊Power BI Dashboard Pages:
 Overview
	KPI Cards: Total Orders, On Time %, Delayed %, Failed %
	Donut Chart: Delivery Status Distribution
	Bar Chart: Total Orders by Month
	Area Chart: Total Cost Trend by Month
	Slicers: Yarn Type, Delivery Status, Destination City

 Delivery Performance
	KPI Cards: On Time Orders, Delayed Orders, Failed Orders
	Stacked Bar: City-wise On Time vs Delayed vs Failed
	Donut: Delay Reason Breakdown
	Bar Chart: Failed Orders by City (Top 6)

 Vendor Analysis
	KPI Cards: Total Vendors, Avg. Cost, Total Weight
	Table: Vendor-wise performance summary
	Bar Chart: Failed Orders by Vendor
	Scatter Plot: Avg. Cost vs Failed Orders by Vendor

 Customer Analysis
	KPI Cards: Total Customers, Avg. Orders per Customer, Total Weight
	Table: Customer-wise performance summary
	Bar Chart: Top 10 Customers by Orders

 Cost Analysis
	KPI Card: Total Cost (148.92M)
	Line/Area Chart: Total Cost Trend by Month
	Bar Chart: Avg. Cost by City
	Bar Chart: Avg Cost by Yarn Type (POY vs FDY)

 DAX Measures Created:
	Total Orders, On Time %, Delayed %, Failed %
	On Time Orders, Delayed Orders, Failed Orders
	Total Cost, Avg Cost, Total Weight
	Total Customers, Total Vendors
	Avg Orders per Customer, Avg Orders per Vendor


📈Key Insights
  Most deliveries were completed successfully, with 65% delivered on time. However, the 27% delay rate highlights an              opportunity to improve delivery operations

  Weather conditions and vehicle breakdowns emerged as the most common reasons behind delivery delays

  A detailed review revealed that 873 deliveries had been incorrectly classified as failed. In reality, these orders were         delivered through alternate contacts, resulting in more accurate delivery performance metrics

  Delivery issues were observed across all cities at a similar rate, suggesting that the challenge is related to the overall      process rather than any specific location

  Vendor performance was largely consistent, with all vendors showing a similar failure rate of around 8–9%, indicating that no   single vendor was responsible for the delivery challenges

  Transportation costs showed a noticeable decline during the October–December period, indicating a seasonal trend that may       require further business investigation

  FDY shipments were slightly more expensive than POY shipments, which aligns with expectations given the additional processing   involved in FDY production

  Screenshots
  <img width="1505" height="844" alt="image" src="https://github.com/user-attachments/assets/529efa19-e5ca-49e5-8a75-304e80ebb2be" />
  <img width="1509" height="844" alt="image" src="https://github.com/user-attachments/assets/a71b11f4-d855-453d-9858-6c5a8b6e02a1" />
  <img width="1507" height="847" alt="image" src="https://github.com/user-attachments/assets/3625d471-2a4a-48b8-9d61-38a150333d11" />
  <img width="1506" height="851" alt="image" src="https://github.com/user-attachments/assets/94f98850-1bcc-4548-b473-d14db0ab9f14" />
  <img width="1499" height="874" alt="image" src="https://github.com/user-attachments/assets/8ab31975-4230-4865-b4ae-46186ec21e2e" />












