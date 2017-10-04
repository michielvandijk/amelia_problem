### PACKAGES
if(!require(pacman)) install.packages("pacman")
# Key packages
p_load("tidyverse", "Amelia")

# Load data
amelia_input_raw <- readRDS("amelia_input_raw.rds") %>%
  as.data.frame()
summary(amelia_input_raw)

# amelia_run 1: removing countries with less than 40 observations - does work
input1 <- amelia_input_raw %>%
  filter(n>=40) %>%
  select(-n)

am1 <- amelia(input1, m = 1, ts = "year", cs = "iso3c", p2s=2, 
                    intercs = TRUE, 
                    lags = c("rd", "hr"),
                    leads = c("rd", "hr"),
                    splinetime = 5, empri = 0.01*nrow(input1),
                    logs = c("rd", "hr", "ag_gdp", "gdp_pc", "gdp"))


# amelia run 2: full dataset - does not work
input2 <- amelia_input_raw %>%
  select(-n)

am2 <- amelia(input2, m = 1, ts = "year", cs = "iso3c", p2s=2, 
                    intercs = TRUE, 
                    lags = c("rd", "hr"),
                    leads = c("rd", "hr"),
                    splinetime = 5, empri = 0.01*nrow(input1),
                    logs = c("rd", "hr", "ag_gdp", "gdp_pc", "gdp"))
