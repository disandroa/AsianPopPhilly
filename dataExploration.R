# MUSA6110: Javascript 
# Story map project: Asian Immigration and Community Well-being in Philadelphia
# I'm using R to come up with the data I need for my story map. 

# Akira Di Sandro
# 2024-09-23

# set-up ----
{
  # load packages
  library(tidyverse)
  library(tidycensus)
  library(sf)
  
  # functions
  `%notin%` <- Negate(`%in%`)
  
  # read in API
  census_api_key("f2855a6037284cb9cbed55e96e6b99be17ee05c6", overwrite = TRUE, install = T)
}

# load in data ----
{
  # 2022 ACS5 data
  # total population, Asian population, median HH income (total and Asian only), median rent, PctBach (Asian)
  tracts22 <- get_acs(geography = "tract",
                      variables = c("B01001_001E", # total population
                                    "B01001D_001E", # Asian population
                                    # "", # median HH income, total
                                    # "", # median HH income, Asian
                                    # "", # median rent
                                    # "", # bachelors, not doing this for now until i see that this is necessary
                                    ),
                      year = 2022,
                      state = 42,
                      county = 101,
                      geometry = T,
                      output = "wide") %>%
    st_transform('ESRI:2272') %>%
  #   rename(TotalPop = B25026_001E, 
  #          MedRent = B25058_001E) %>%
  #   dplyr::select(-NAME, -starts_with("B"))
  
  
  # 
}

# data set-up ----
{
  
}

# data exploration ----
{
  
}

# output data for story map ----
{
  
}