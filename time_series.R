## pretty time series
ts_plot(ica, "hours", trim = 1, colour = "transparent") +
  geom_smooth(method = "loess", se = FALSE, span = .1, size = 1.25, colour = "#0066aa") +
  geom_point(size = 3.5, shape = 21, fill = "#ADFF2F99", colour = "#000000dd") +
  theme_mwk(base_size = 13, base_family = "Roboto Condensed") +
  theme(axis.text = element_text(colour = "#222222"),
    plot.title = element_text(size = rel(1.5), face = "bold"),
    plot.subtitle = element_text(size = rel(1.1)),
    plot.caption = element_text(face = "italic", size = rel(.8), colour = "#444444")) +
  labs(title = "Twitter statuses about the 2018 ICA conference",
    subtitle = "Hourly number of tweets containing #ICA18 or #ICA2018 hashtags",
    caption = "\nSource: Data gathered via Twitter's standard `search/tweets` API using rtweet",
    x = NULL, y = NULL) +
    ggsave("ica_frequency.png", width = 10, height = 7, units = "in")
