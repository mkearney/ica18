
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ica18

How to collect \[and update\] data.

``` r
## load rtweet
library(rtweet)

## read data
if (file.exists(file.path("data", "ica18.rds"))) {
  ica_old <- readRDS(file.path("data", "ica18.rds"))
  sinceid <- ica_old$status_id[order(ica_old$created_at, decreasing = TRUE)[1]]
} else {
  sinceid <- NULL
}

## get ICA18 tweets
ica <- search_tweets("ica18 OR ica2018", n = 18000, since_id = sinceid)
#> Searching for tweets...
#> This may take a few seconds...
#> Finished collecting tweets!

## merge if updating
if (exists("ica_old")) {
  ## merge data
  ica <- rbind(ica, ica_old)
  
  ## rm ica2
  rm(ica_old)

  ## filter unique data
  ica <- funique::funique(ica)
}

## save data set
saveRDS(ica, file.path("data", "ica18.rds"))

## view data
ica
#> # A tibble: 5,203 x 87
#>    user_id  status_id created_at          screen_name text          source
#>    <chr>    <chr>     <dttm>              <chr>       <chr>         <chr> 
#>  1 14464346 99995633… 2018-05-25 10:12:23 dragz       RT @Hermida:… Twitt…
#>  2 1699604… 99995654… 2018-05-25 10:13:12 rasmus_kle… "Want to lea… Twitt…
#>  3 1699604… 99995653… 2018-05-25 10:13:11 rasmus_kle… "People inci… Twitt…
#>  4 16996332 99995623… 2018-05-25 10:11:59 NaledgeEva… Today's high… Twitt…
#>  5 27914459 99995660… 2018-05-25 10:13:26 shotinshan… @josh_braun … Twitt…
#>  6 3646935… 99995640… 2018-05-25 10:12:40 ICA_Langua… RT @icahdq: … Twitt…
#>  7 3646935… 99995631… 2018-05-25 10:12:17 ICA_Langua… RT @k_brownl… Twitt…
#>  8 88436629 99995625… 2018-05-25 10:12:04 StineEckert RT @ICA_FSD:… Twitt…
#>  9 9192272  99995654… 2018-05-25 10:13:14 monrodrigu… RT @aschrock… Twitt…
#> 10 14271015 99995533… 2018-05-25 10:08:23 Gusse       "RT @monrodr… Twitt…
#> # ... with 5,193 more rows, and 81 more variables:
#> #   display_text_width <dbl>, reply_to_status_id <chr>,
#> #   reply_to_user_id <chr>, reply_to_screen_name <chr>, is_quote <lgl>,
#> #   is_retweet <lgl>, favorite_count <int>, retweet_count <int>,
#> #   hashtags <list>, symbols <list>, urls_url <list>, urls_t.co <list>,
#> #   urls_expanded_url <list>, media_url <list>, media_t.co <list>,
#> #   media_expanded_url <list>, media_type <list>, ext_media_url <list>,
#> #   ext_media_t.co <list>, ext_media_expanded_url <list>,
#> #   ext_media_type <chr>, mentions_user_id <list>,
#> #   mentions_screen_name <list>, lang <chr>, quoted_status_id <chr>,
#> #   quoted_text <chr>, quoted_created_at <dttm>, quoted_source <chr>,
#> #   quoted_favorite_count <int>, quoted_retweet_count <int>,
#> #   quoted_user_id <chr>, quoted_screen_name <chr>, quoted_name <chr>,
#> #   quoted_followers_count <int>, quoted_friends_count <int>,
#> #   quoted_statuses_count <int>, quoted_location <chr>,
#> #   quoted_description <chr>, quoted_verified <lgl>,
#> #   retweet_status_id <chr>, retweet_text <chr>,
#> #   retweet_created_at <dttm>, retweet_source <chr>,
#> #   retweet_favorite_count <int>, retweet_retweet_count <int>,
#> #   retweet_user_id <chr>, retweet_screen_name <chr>, retweet_name <chr>,
#> #   retweet_followers_count <int>, retweet_friends_count <int>,
#> #   retweet_statuses_count <int>, retweet_location <chr>,
#> #   retweet_description <chr>, retweet_verified <lgl>, place_url <chr>,
#> #   place_name <chr>, place_full_name <chr>, place_type <chr>,
#> #   country <chr>, country_code <chr>, geo_coords <list>,
#> #   coords_coords <list>, bbox_coords <list>, name <chr>, location <chr>,
#> #   description <chr>, url <chr>, protected <lgl>, followers_count <int>,
#> #   friends_count <int>, listed_count <int>, statuses_count <int>,
#> #   favourites_count <int>, account_created_at <dttm>, verified <lgl>,
#> #   profile_url <chr>, profile_expanded_url <chr>, account_lang <chr>,
#> #   profile_banner_url <chr>, profile_background_url <chr>,
#> #   profile_image_url <chr>
```

## Tweet frequency

See the source code [here](time_series.R)

``` r
source("time_series.R")
```

<p align="center">

<img width="100%" height="auto" src="ica_frequency.png" />

</p>

 

## Semantic network

See the source code [here](network_analysis.R)

``` r
source("network_analysis.R")
```

<p align="center">

<img width="100%" height="auto" src="ica_network.png" />

</p>
