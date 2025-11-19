## Decoupling CO₂ Emissions and GDP (1970–2023)

This project uses R to explore whether global economic growth has begun to decouple from carbon emissions between 1970 and 2023. Using a panel of global GDP, GDP per capita, and CO₂ emissions (total and per capita), it examines how tightly economic output and emissions have moved together over time.

### What this repo does

- **Computes key correlations**
  - Global **GDP per capita vs CO₂ per capita**: *r* ≈ 0.78  
  - Global **GDP (total) vs CO₂ (total)**: *r* ≈ 0.99  

- **Fits simple linear regression models**
  - `GDP per capita ~ CO₂ per capita`  
    - Very low explanatory power: R² ≈ 0.10, p ≈ 0.33  
  - `GDP (IN $) ~ Annual CO₂ emissions (per capita)`  
    - Strong fit: R² ≈ 0.63, p < 0.001  

- **Splits the sample into two eras to look for structural change**
  - **1970–1997**
    - `GDP per Capita` vs `CO₂ per capita`: *r* ≈ −0.30  
    - `GDP (IN $)` vs `CO₂ (total)`: *r* ≈ 0.97  
  - **1998–2023**
    - `GDP per Capita` vs `CO₂ per capita`: *r* ≈ 0.84  
    - `GDP (IN $)` vs `CO₂ (total)`: *r* ≈ 0.97  

- **Visualizes emissions trajectories**
  - Global CO₂ per capita over 1970–2023  
  - Sub-plots for 1970–1997 and 1998–2023  
  - Identifies the years with **maximum** and **minimum** CO₂ per capita  
