
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
#> # A tibble: 10,658 x 87
#>    user_id status_id created_at          screen_name text  source display_text_wi… reply_to_status…
#>    <chr>   <chr>     <dttm>              <chr>       <chr> <chr>             <dbl> <chr>           
#>  1 176186… 10006274… 2018-05-27 06:39:00 CatyBC      .@CM… Twitt…              81. <NA>            
#>  2 148600… 10006268… 2018-05-27 06:36:38 aschrock    RT @… Tweet…             119. <NA>            
#>  3 154785… 10006266… 2018-05-27 06:36:00 ICA_CAT     Plea… Tweet…              82. <NA>            
#>  4 185552… 10006264… 2018-05-27 06:35:05 nikospan    RT @… Twitt…             140. <NA>            
#>  5 189983… 10006264… 2018-05-27 06:35:18 CarolienNi… RT @… Twitt…             144. <NA>            
#>  6 259832… 10006266… 2018-05-27 06:36:00 boomgaarde… RT @… Twitt…             139. <NA>            
#>  7 310737… 10006266… 2018-05-27 06:35:59 DrSha       RT @… Twitt…             139. <NA>            
#>  8 315607… 10006266… 2018-05-27 06:36:00 icahdq      "Nur… Hoots…             195. <NA>            
#>  9 394285… 10006263… 2018-05-27 06:34:56 scroeser    The … Twitt…             248. 100062550173886…
#> 10 5165901 10006270… 2018-05-27 06:37:27 Hermida     Time… Twitt…             165. 100062661754537…
#> # ... with 10,648 more rows, and 79 more variables: reply_to_user_id <chr>,
#> #   reply_to_screen_name <chr>, is_quote <lgl>, is_retweet <lgl>, favorite_count <int>,
#> #   retweet_count <int>, hashtags <list>, symbols <list>, urls_url <list>, urls_t.co <list>,
#> #   urls_expanded_url <list>, media_url <list>, media_t.co <list>, media_expanded_url <list>,
#> #   media_type <list>, ext_media_url <list>, ext_media_t.co <list>, ext_media_expanded_url <list>,
#> #   ext_media_type <chr>, mentions_user_id <list>, mentions_screen_name <list>, lang <chr>,
#> #   quoted_status_id <chr>, quoted_text <chr>, quoted_created_at <dttm>, quoted_source <chr>,
#> #   quoted_favorite_count <int>, quoted_retweet_count <int>, quoted_user_id <chr>,
#> #   quoted_screen_name <chr>, quoted_name <chr>, quoted_followers_count <int>,
#> #   quoted_friends_count <int>, quoted_statuses_count <int>, quoted_location <chr>,
#> #   quoted_description <chr>, quoted_verified <lgl>, retweet_status_id <chr>, retweet_text <chr>,
#> #   retweet_created_at <dttm>, retweet_source <chr>, retweet_favorite_count <int>,
#> #   retweet_retweet_count <int>, retweet_user_id <chr>, retweet_screen_name <chr>,
#> #   retweet_name <chr>, retweet_followers_count <int>, retweet_friends_count <int>,
#> #   retweet_statuses_count <int>, retweet_location <chr>, retweet_description <chr>,
#> #   retweet_verified <lgl>, place_url <chr>, place_name <chr>, place_full_name <chr>,
#> #   place_type <chr>, country <chr>, country_code <chr>, geo_coords <list>, coords_coords <list>,
#> #   bbox_coords <list>, name <chr>, location <chr>, description <chr>, url <chr>, protected <lgl>,
#> #   followers_count <int>, friends_count <int>, listed_count <int>, statuses_count <int>,
#> #   favourites_count <int>, account_created_at <dttm>, verified <lgl>, profile_url <chr>,
#> #   profile_expanded_url <chr>, account_lang <chr>, profile_banner_url <chr>,
#> #   profile_background_url <chr>, profile_image_url <chr>
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

 

``` r
source("division_hashtags.R")
#> Searching for tweets...
#> This may take a few seconds...
#> Finished collecting tweets!
#> Searching for tweets...
#> This may take a few seconds...
#> Finished collecting tweets!
#> `geom_smooth()` using method = 'loess'
```

<p align="center">

<img width="100%" height="auto" src="ica_divs.png" />

</p>
