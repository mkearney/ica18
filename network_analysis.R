## unlist observations into long-form data frame
unlist_df <- function(...) {
  dots <- lapply(list(...), unlist, use.names = FALSE)
  tibble::as_tibble(dots, validate = FALSE)
}

## iterate by row
row_dfs <- lapply(
  seq_len(nrow(ica)), function(i)
    unlist_df(from_screen_name = ica$screen_name[i],
      reply = ica$reply_to_screen_name[i],
      mention = ica$mentions_screen_name[i],
      quote = ica$quoted_screen_name[i],
      retweet = ica$retweet_screen_name[i])
)

## bind rows, gather (to long), convert to matrix, and filter out NAs
rdf <- dplyr::bind_rows(row_dfs)
rdf <- tidyr::gather(rdf, interaction_type, to_screen_name, -from_screen_name)
mat <- as.matrix(rdf[, -2])
mat <- mat[apply(mat, 1, function(i) !any(is.na(i))), ]

## get rid of self references
mat <- mat[mat[, 1] != mat[, 2], ]

## filter out users who don't appear in RHS at least 3 times
apps1 <- table(mat[, 1])
apps1 <- apps1[apps1 > 5L]
apps2 <- table(mat[, 2])
apps2 <- apps2[apps2 > 5L]
apps <- names(apps1)[names(apps1) %in% names(apps2)]
mat <- mat[mat[, 1] %in% apps & mat[, 2] %in% apps, ]

## create graph object
g <- igraph::graph_from_edgelist(mat)

## calculate size attribute (and transform to fit)
matcols <- factor(c(mat[, 1], mat[, 2]), levels = names(igraph::V(g)))
size <- table(screen_name = matcols)
size <- (log(size) + sqrt(size)) / 4

## reorder freq table
size <- size[match(names(size), names(igraph::V(g)))]

## plot network
png("ica_network.png", width = 120 * 36, height = 120 * 30, bg = "#f7f7f7")
par(mar = c(12, 6, 15, 6), bg = "#f7f7f7", bg = "#f7f7f7")
plot(g,
  edge.size = .4,
  curved = FALSE,
  margin = -.05,
  edge.arrow.size = 0,
  edge.arrow.width = 0,
  vertex.color = "#ADFF2F99",
  vertex.size = size,
  vertex.frame.color = "#003366",
  vertex.label.color = "#003366",
  vertex.label.cex = .8,
  vertex.label.family = "Roboto Condensed",
  edge.color = "#0066aa",
  edge.width = .2,
  main = "")
par(mar = c(9, 6, 9, 6), bg = "#f7f7f7")
title("Semantic network of users tweeting about #ica18",
  adj = 0, family = "Roboto Condensed", cex.main = 6.5)
mtext("Source: Data gathered using rtweet. Network analysis done using igraph",
  side = 1, line = 0, adj = 1.0, cex = 3.8,
  family = "Roboto Condensed", col = "#222222")
mtext("User connections by mentions, replies, retweets, and quotes",
  side = 3, line = -4.25, adj = 0,
  family = "Roboto Condensed", cex = 4.9)
dev.off()

