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
  # 2012 ACS5 data
  # total population, Asian population, median HH income (total and Asian only). for later: median rent, PctBach (Asian)
  tracts12 <- get_acs(geography = "tract",
                      variables = c("B01001_001E", # total population
                                    "B01001D_001E", # Asian population
                                    "B02006_002E", # total population, indian
                                    "B02006_003E", # total population, bangladeshi
                                    "B02006_004E", # total population, cambodian
                                    "B02006_005E", # total population, chinese
                                    "B02006_006E", # total population, filipino
                                    "B02006_007E", # total population, hmong
                                    "B02006_008E", # total population, indonesian
                                    "B02006_009E", # total population, Japanese
                                    "B02006_010E", # total population, Korean
                                    "B02006_011E", # total population, Laotian
                                    "B02006_012E", # total population, Malaysian
                                    "B02006_013E", # total population, Pakistani
                                    "B02006_014E", # total population, SriLankan
                                    "B02006_015E", # total population, Taiwanese
                                    "B02006_016E", # total population, Thai
                                    "B02006_017E", # total population, Vietnamese
                                    "B02006_018E", # total population, OtherAsianSpecified
                                    "B02006_019E", # total population, OtherAsianUnspecified
                                    "B19001_001E" # HH income, total
                      ),
                      year = 2012,
                      state = 42,
                      county = 101,
                      geometry = T,
                      output = "wide") %>%
    st_transform(crs = 2272) %>%
    rename(TotalPop = B01001_001E,
           TotalAsianPop = B01001D_001E,
           Indian = B02006_002E,
           Bangladeshi = B02006_003E,
           Cambodian = B02006_004E,
           Chinese = B02006_005E,
           Filipino = B02006_006E,
           Hmong = B02006_007E,
           Indonesian = B02006_008E,
           Japanese = B02006_009E,
           Korean = B02006_010E,
           Laotian = B02006_011E,
           Malaysian = B02006_012E,
           Pakistani = B02006_013E,
           SriLankan = B02006_014E,
           Taiwanese = B02006_015E,
           Thai = B02006_016E,
           Vietnamese = B02006_017E,
           OtherAsianSpecified = B02006_018E,
           OtherAsianUnspecified = B02006_019E,
           MedHHIncome = B19001_001E
    ) %>%
    dplyr::select(-ends_with("M", ignore.case = F))
  
  # 2022 ACS5 data
  # total population, Asian population, median HH income (total and Asian only). for later: median rent, PctBach (Asian)
  tracts22 <- get_acs(geography = "tract",
                      variables = c("B01001_001E", # total population
                                    "B01001D_001E", # Asian population
                                    "B02015_002E", # total population, chinese
                                    "B02015_003E", # total population, hmong
                                    "B02015_004E", # total population, japanese
                                    "B02015_005E", # total population, korean
                                    "B02015_006E", # total population, mongolian
                                    "B02015_007E", # total population, okinawan
                                    "B02015_008E", # total population, taiwanese
                                    "B02015_009E", # total population, other east asian
                                    "B02015_010E", # total population, burmese
                                    "B02015_011E", # total population, cambodian
                                    "B02015_012E", # total population, filipino
                                    "B02015_013E", # total population, indonesian
                                    "B02015_014E", # total population, laotian
                                    "B02015_015E", # total population, malaysian
                                    "B02015_016E", # total population, mien
                                    "B02015_017E", # total population, singaporean
                                    "B02015_018E", # total population, thai
                                    "B02015_019E", # total population, vietnamese
                                    "B02015_020E", # total population, other SE asian
                                    "B02015_021E", # total population, indian
                                    "B02015_022E", # total population, bangladeshi
                                    "B02015_023E", # total population, bhutanese
                                    "B02015_024E", # total population, nepalese
                                    "B02015_025E", # total population, pakistani
                                    "B02015_026E", # total population, sikh
                                    "B02015_027E", # total population, sri lankan
                                    "B02015_028E", # total population, other south asian
                                    "B02015_029E", # total population, kazakh
                                    "B02015_030E", # total population, uzbek
                                    "B02015_031E", # total population, other central asian
                                    "B02015_032E", # total population, other asian, specified
                                    "B02015_033E", # total population, other asian, unspecified
                                    "B02015_034E", # total population, two or more, asian
                                    "B19001_001E" # HH income, total
                                    ),
                      year = 2022,
                      state = 42,
                      county = 101,
                      geometry = T,
                      output = "wide") %>%
    st_transform(crs = 2272) %>%
    rename(TotalPop = B01001_001E,
           TotalAsianPop = B01001D_001E,
           Chinese = B02015_002E,
           Hmong = B02015_003E,
           Japanese = B02015_004E,
           Korean = B02015_005E,
           Mongolian = B02015_006E,
           Okinawan = B02015_007E,
           Taiwanese = B02015_008E,
           OtherEAsian = B02015_009E,
           Burmese = B02015_010E,
           Cambodian = B02015_011E,
           Filipino = B02015_012E,
           Indonesian = B02015_013E,
           Laotian = B02015_014E,
           Malaysian = B02015_015E,
           Mien = B02015_016E,
           Singaporean = B02015_017E,
           Thai = B02015_018E,
           Vietnamese = B02015_019E,
           OtherSEAsian = B02015_020E,
           Indian = B02015_021E,
           Bangladeshi = B02015_022E,
           Bhutanese = B02015_023E,
           Nepalese = B02015_024E,
           Pakistani = B02015_025E,
           Sikh = B02015_026E,
           SriLankan = B02015_027E,
           OtherSAsian = B02015_028E,
           Kazakh = B02015_029E,
           Uzbek = B02015_030E,
           OtherCAsian = B02015_031E,
           OtherAsianSpecified = B02015_032E,
           OtherAsianUnspecified = B02015_033E,
           TwoOrMoreAsian = B02015_034E,
           MedHHIncome = B19001_001E
           ) %>%
    dplyr::select(-ends_with("M", ignore.case = F))
  
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