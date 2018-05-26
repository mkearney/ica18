
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
#> # A tibble: 9,946 x 87
#>    user_id  status_id created_at          screen_name text    source display_text_wi… reply_to_status… reply_to_user_id
#>    <chr>    <chr>     <dttm>              <chr>       <chr>   <chr>             <dbl> <chr>            <chr>           
#>  1 1636606… 10004131… 2018-05-26 16:27:24 ICD_AEJMC   RT @gn… Twitt…             116. <NA>             <NA>            
#>  2 2325584… 10004127… 2018-05-26 16:25:52 PaoloBory   RT @vk… Twitt…             107. <NA>             <NA>            
#>  3 2867286… 10004128… 2018-05-26 16:26:29 ygnieves    RT @kr… Twitt…             140. <NA>             <NA>            
#>  4 46111691 10004129… 2018-05-26 16:26:54 DCInbox     RT @kr… Twitt…             140. <NA>             <NA>            
#>  5 1010387… 10002963… 2018-05-26 08:43:20 lsangalang  RT @An… Twitt…             139. <NA>             <NA>            
#>  6 1010387… 10003904… 2018-05-26 14:57:23 lsangalang  RT @Ru… Twitt…             139. <NA>             <NA>            
#>  7 1010387… 10003908… 2018-05-26 14:59:00 lsangalang  RT @MK… Twitt…             140. <NA>             <NA>            
#>  8 1010387… 10003909… 2018-05-26 14:59:15 lsangalang  RT @Li… Twitt…             140. <NA>             <NA>            
#>  9 10162032 10003606… 2018-05-26 12:58:51 Soares_Luc… RT @kk… Twitt…             131. <NA>             <NA>            
#> 10 1024842… 10003891… 2018-05-26 14:52:09 pisotalus   #ICA18… Twitt…              86. <NA>             <NA>            
#> # ... with 9,936 more rows, and 78 more variables: reply_to_screen_name <chr>, is_quote <lgl>, is_retweet <lgl>,
#> #   favorite_count <int>, retweet_count <int>, hashtags <list>, symbols <list>, urls_url <list>, urls_t.co <list>,
#> #   urls_expanded_url <list>, media_url <list>, media_t.co <list>, media_expanded_url <list>, media_type <list>,
#> #   ext_media_url <list>, ext_media_t.co <list>, ext_media_expanded_url <list>, ext_media_type <chr>,
#> #   mentions_user_id <list>, mentions_screen_name <list>, lang <chr>, quoted_status_id <chr>, quoted_text <chr>,
#> #   quoted_created_at <dttm>, quoted_source <chr>, quoted_favorite_count <int>, quoted_retweet_count <int>,
#> #   quoted_user_id <chr>, quoted_screen_name <chr>, quoted_name <chr>, quoted_followers_count <int>,
#> #   quoted_friends_count <int>, quoted_statuses_count <int>, quoted_location <chr>, quoted_description <chr>,
#> #   quoted_verified <lgl>, retweet_status_id <chr>, retweet_text <chr>, retweet_created_at <dttm>,
#> #   retweet_source <chr>, retweet_favorite_count <int>, retweet_retweet_count <int>, retweet_user_id <chr>,
#> #   retweet_screen_name <chr>, retweet_name <chr>, retweet_followers_count <int>, retweet_friends_count <int>,
#> #   retweet_statuses_count <int>, retweet_location <chr>, retweet_description <chr>, retweet_verified <lgl>,
#> #   place_url <chr>, place_name <chr>, place_full_name <chr>, place_type <chr>, country <chr>, country_code <chr>,
#> #   geo_coords <list>, coords_coords <list>, bbox_coords <list>, name <chr>, location <chr>, description <chr>,
#> #   url <chr>, protected <lgl>, followers_count <int>, friends_count <int>, listed_count <int>, statuses_count <int>,
#> #   favourites_count <int>, account_created_at <dttm>, verified <lgl>, profile_url <chr>, profile_expanded_url <chr>,
#> #   account_lang <chr>, profile_banner_url <chr>, profile_background_url <chr>, profile_image_url <chr>
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
