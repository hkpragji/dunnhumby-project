--------------------------------------------------------------------------------
# Load required libraries
library(tidyverse)
library(janitor)
library(here)
--------------------------------------------------------------------------------
## DATA IMPORT
# Import CSV files into data frames and clean column names
df_trans <- data.frame(readr::read_csv(here::here("data/transaction_data.csv"), show_col_types = FALSE)) %>%
  janitor::clean_names()

glimpse(df_trans) # View general structure
summary(df_trans) # View summary statistics

df_prods <- data.frame(readr::read_csv(here::here("data/product.csv"), show_col_types = FALSE)) %>%
  janitor::clean_names()

glimpse(df_prods) # View general structure
summary(df_prods) # View summary statistics

--------------------------------------------------------------------------------
## DATA TRANSFORMATION
# Coerce all character variables to factors for analysis
df_prods <- df_prods %>%
  dplyr::mutate(across(where(is.character), as.factor))

# Join products to transactions using left join to
# keep all transactions and add product attributes
product_transactions <- df_trans %>%
  dplyr::left_join(df_prods, by = c("product_id"))

glimpse(product_transactions)

--------------------------------------------------------------------------------
## EXPLORATORY DATA ANALYSIS
# Verify number of distinct households
product_transactions %>%
  dplyr::distinct(household_key) %>%
  dplyr::summarise(n_households = n_distinct(household_key))

