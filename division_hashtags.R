## ica hashtags
hashtags <- c("ica_acsj", "ica_cam", "ica_cat", "ica_clp", "ica_his",
  "ica_csab", "ica_cm", "ica_env", "ica_eric", "ica_fsd", "ica_gs", "ica_gcsc",
  "ica_hc", "ica_is", "ica_idd", "ica_icd", "ica_igc", "ica_jsd", "ica_lsi",
  "ica_lgbtq", "ica_mass", "ica_mis", "ica_mob", "ica_org", "ica_ptc",
  "ica_pol", "ica_pop", "ica_pd", "ica_pr", "ica_sc", "ica_vis", "ica18",
  "ica2018", "ica18_theme", "ica_green", "ica_secac")

## read data
if (file.exists(file.path("data", "icall.rds"))) {
  icall_old <- readRDS(file.path("data", "icall.rds"))
  sinceid <- icall_old$status_id[order(icall_old$created_at, decreasing = TRUE)[1]]
} else {
  sinceid <- NULL
}

## search for all tweets - pt1
icall1 <- search_tweets(paste(hashtags[1:18], collapse = " OR "), n = 45000,
  since_id = sinceid, token = bearer_token())

## search for all tweets - pt2
icall2 <- search_tweets(paste(hashtags[19:36], collapse = " OR "), n = 45000,
  since_id = sinceid, token = bearer_token())

## merge into icall
icall <- funique::funique(rbind(icall1, icall2))

## bind with old data
if (exists("icall_old")) {
  icall <- funique::funique(rbind(icall, icall_old))
}

## save
saveRDS(icall, "data/icall.rds")

## create dummy codes for each ica hashtag
for (i in seq_along(hashtags)) {
  icall[[hashtags[i]]] <- vapply(icall$hashtags, function(.) hashtags[i] %in% .,
    FUN.VALUE = logical(1), USE.NAMES = FALSE)
}

d <- icall %>%
  filter(created_at > "2018-05-23") %>%
  select(created_at, status_id, ica_acsj:ica_secac, -ica18, -ica2018) %>%
  gather(hashtag, true, -created_at, -status_id) %>%
  filter(true) %>%
  group_by(hashtag) %>%
  ts_data("3 hours", trim = 1) %>%
  group_by(hashtag) %>%
  mutate(tot = sum(n)) %>%
  arrange(-tot)

## identity top 16 most popular division hashtags
top16 <- unique(d$hashtag)[1:16]

## plot time series for top 16
d %>%
  filter(hashtag %in% top16) %>%
  ggplot(aes(x = time, y = n, colour = hashtag)) +
  geom_smooth(span = .25, fill = "transparent") +
  geom_point(alpha = .75) +
  theme_mwk(12, "Roboto Condensed") +
  facet_wrap(~ hashtag) +
  theme(legend.position = "none") +
  labs(x = NULL, y = NULL,
    title = "ICA 2018 Twitter statuses by division/group hashtag",
    subtitle = "Number of tweets containing division-specific hashtags in 3-hour intervals") +
  ylim(-7.5, NA) +
  ggsave("ica_divs.png", width = 10, height = 7, units = "in")

## hashtag freq counts
icall %>%
  filter(created_at > "2018-05-23") %>%
  select(created_at, status_id, ica_acsj:ica_secac, -ica18, -ica2018) %>%
  gather(hashtag, true, -created_at, -status_id) %>%
  filter(true) %>%
  group_by(hashtag) %>%
  summarise(n = n()) %>%
  arrange(-n) %>%
  readr::write_csv("freq.csv")
