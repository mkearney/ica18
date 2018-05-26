
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
#> # A tibble: 7,980 x 87
#>    user_id  status_id  created_at          screen_name text         source
#>    <chr>    <chr>      <dttm>              <chr>       <chr>        <chr> 
#>  1 1384603… 100029434… 2018-05-26 08:35:31 prowag      Good commen… Twitt…
#>  2 1408418… 100029331… 2018-05-26 08:31:24 trendinali… The hashtag… Trend…
#>  3 14204987 100029485… 2018-05-26 08:37:33 dvshah      RT @svenges… Twitt…
#>  4 14204987 100029480… 2018-05-26 08:37:20 dvshah      @silviowais… Twitt…
#>  5 1464130… 100029414… 2018-05-26 08:34:43 reticentK   #ica18 @KLo… Twitt…
#>  6 14780909 100029494… 2018-05-26 08:37:53 jameslosey  RT @schradi… Twitt…
#>  7 1500115… 100029370… 2018-05-26 08:32:59 lenikrsova  RT @patyros… Twitt…
#>  8 15047905 100029513… 2018-05-26 08:38:40 alesherasi… It is amazi… Twitt…
#>  9 15047905 100029323… 2018-05-26 08:31:05 alesherasi… "and here c… Twitt…
#> 10 15608380 100029485… 2018-05-26 08:37:33 tetisheri   A start mig… Twitt…
#> # ... with 7,970 more rows, and 81 more variables:
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
