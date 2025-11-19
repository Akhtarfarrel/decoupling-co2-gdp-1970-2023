############################################################
# Decoupling CO₂ Emissions and World GDP (1970–2023)
# Full analysis script: correlations, regressions, elasticity,
# split-sample correlations, and visualizations.
############################################################

## 1. PREPARE DATA ----
## Assumes World_data already exists with at least:
##   - Year
##   - `GDP per Capita`
##   - `GDP (IN $)`
##   - `Annual CO₂ emissions (per capita)`
##   - `Annual CO₂ emissions` (total CO₂)

# Create split samples
data1970 <- subset(World_data, Year <= 1997)
data1998 <- subset(World_data, Year >= 1998)


## 2. CORRELATIONS (FULL SAMPLE) ----

# Correlation: GDP per Capita vs CO₂ per Capita
cor_gdppc_co2pc <- cor(
  World_data$`GDP per Capita`,
  World_data$`Annual CO₂ emissions (per capita)`,
  use = "complete.obs"
)

# Correlation: total GDP vs total CO₂ emissions
cor_gdp_co2tot <- cor(
  World_data$`GDP (IN $)`,
  World_data$`Annual CO₂ emissions`,
  use = "complete.obs"
)

cat("Correlation (GDP per Capita, CO2 per Capita):", cor_gdppc_co2pc, "\n")
cat("Correlation (GDP (IN $), CO2 total):", cor_gdp_co2tot, "\n\n")


## 3. LINEAR REGRESSIONS IN LEVELS ----

# 3.1 GDP per Capita ~ CO₂ per Capita
GDPC02Capitafit <- lm(`GDP per Capita` ~ `Annual CO₂ emissions (per capita)`,
                      data = World_data)
cat("=== Linear model: GDP per Capita ~ CO2 per Capita ===\n")
print(summary(GDPC02Capitafit))
cat("\n")

# 3.2 GDP (IN $) ~ CO₂ per Capita
GDPC02fit <- lm(`GDP (IN $)` ~ `Annual CO₂ emissions (per capita)`,
                data = World_data)
cat("=== Linear model: GDP (IN $) ~ CO2 per Capita ===\n")
print(summary(GDPC02fit))
cat("\n")


## 4. LOG–LOG ELASTICITY MODEL ----
## Elasticity of GDP per Capita w.r.t CO₂ per Capita

# Create logged variables
World_data$lgdpcap <- log(World_data$`GDP per Capita`)
World_data$lc02cap <- log(World_data$`Annual CO₂ emissions (per capita)`)

elasticity_fit <- lm(lgdpcap ~ lc02cap, data = World_data)

cat("=== Log–log model: log(GDP per Capita) ~ log(CO2 per Capita) ===\n")
print(summary(elasticity_fit))
cat("\n")
cat("Interpretation: Coefficient on log(CO2 per Capita) is the elasticity\n",
    "→ A 1% increase in CO2 per capita is associated with an approx. ",
    round(coef(elasticity_fit)["lc02cap"], 3),
    "% increase in GDP per capita.\n\n", sep = "")


## 5. SPLIT-SAMPLE CORRELATIONS ----

cat("=== Split-sample correlations ===\n")

# 5.1 Period 1970–1997
cor_1970_gdppc_co2pc <- cor(
  data1970$`GDP per Capita`,
  data1970$`Annual CO₂ emissions (per capita)`,
  use = "complete.obs"
)

cor_1970_gdp_co2tot <- cor(
  data1970$`Annual CO₂ emissions`,
  data1970$`GDP (IN $)`,
  use = "complete.obs"
)

cat("1970–1997:\n")
cat("  Cor(GDP per Capita, CO2 per Capita):", cor_1970_gdppc_co2pc, "\n")
cat("  Cor(GDP (IN $), CO2 total):", cor_1970_gdp_co2tot, "\n\n")

# 5.2 Period 1998–2023
cor_1998_gdppc_co2pc <- cor(
  data1998$`Annual CO₂ emissions (per capita)`,
  data1998$`GDP per Capita`,
  use = "complete.obs"
)

cor_1998_gdp_co2tot <- cor(
  data1998$`GDP (IN $)`,
  data1998$`Annual CO₂ emissions`,
  use = "complete.obs"
)

cat("1998–2023:\n")
cat("  Cor(GDP per Capita, CO2 per Capita):", cor_1998_gdppc_co2pc, "\n")
cat("  Cor(GDP (IN $), CO2 total):", cor_1998_gdp_co2tot, "\n\n")


## 6. VISUALIZATIONS ----

# 3-panel layout: full period, 1970–1997, 1998–2023
par(mfrow = c(3, 1))

# 6.1 Full period: 1970–2023
plot(
  World_data$Year,
  World_data$`Annual CO₂ emissions (per capita)`,
  xlab = "Year",
  ylab = "CO₂ emissions per capita",
  main = "Global CO₂ per Capita (1970–2023)",
  type = "l"
)

# 6.2 1970–1997
plot(
  data1970$Year,
  data1970$`Annual CO₂ emissions (per capita)`,
  xlab = "Year",
  ylab = "CO₂ emissions per capita",
  main = "Global CO₂ per Capita (1970–1997)",
  type = "l"
)

# 6.3 1998–2023
plot(
  data1998$Year,
  data1998$`Annual CO₂ emissions (per capita)`,
  xlab = "Year",
  ylab = "CO₂ emissions per capita",
  main = "Global CO₂ per Capita (1998–2023)",
  type = "l"
)

# Reset plotting layout
par(mfrow = c(1, 1))


## 7. MAXIMUM AND MINIMUM CO₂ PER CAPITA ----

max_full_idx <- which.max(World_data$`Annual CO₂ emissions (per capita)`)
min_full_idx <- which.min(World_data$`Annual CO₂ emissions (per capita)`)

max_1970_idx <- which.max(data1970$`Annual CO₂ emissions (per capita)`)
min_1970_idx <- which.min(data1970$`Annual CO₂ emissions (per capita)`)

max_1998_idx <- which.max(data1998$`Annual CO₂ emissions (per capita)`)
min_1998_idx <- which.min(data1998$`Annual CO₂ emissions (per capita)`)

cat("=== Max/Min CO2 per Capita ===\n")
cat("Full period (1970–2023):\n")
cat("  Max at index:", max_full_idx,
    " Year:", World_data$Year[max_full_idx], "\n")
cat("  Min at index:", min_full_idx,
    " Year:", World_data$Year[min_full_idx], "\n\n")

cat("1970–1997:\n")
cat("  Max at index:", max_1970_idx,
    " Year:", data1970$Year[max_1970_idx], "\n")
cat("  Min at index:", min_1970_idx,
    " Year:", data1970$Year[min_1970_idx], "\n\n")

cat("1998–2023:\n")
cat("  Max at index:", max_1998_idx,
    " Year:", data1998$Year[max_1998_idx], "\n")
cat("  Min at index:", min_1998_idx,
    " Year:", data1998$Year[min_1998_idx], "\n")
