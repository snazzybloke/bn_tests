# https://en.wikipedia.org/wiki/Bayesian_network#d-separation

library(bnlearn)
wiki = model2network("[R][S|R][G|S:R]")
print(paste("Model string: ", modelstring(wiki)))

cpt_R <- matrix(c(0.2, 0.8), ncol=2, dimnames = list(NULL, c("Rain_T", "Rain_F")))
cpt_S <- matrix(c(0.4, 0.6, 0.01, 0.99),
	       	ncol=2,
	       	dimnames = list(S = c("Sprinkler_T", "Sprinkler_F"),
				       R = c("Rain_F", "Rain_T")))
cpt_G <- array(c(0.0, 1.0, 0.8, 0.2, 0.9, 0.1, 0.99, 0.01),
	       dim=c(2, 2, 2),
	       dimnames = list(G = c("GWet_T", "GWet_F"),
			       R = c("Rain_F", "Rain_T"),
			       S = c("Sprinkler_F", "Sprinkler_T")))

grs_wiki = custom.fit(wiki, dist = list(R = cpt_R, S = cpt_S, G = cpt_G))

print(paste("Fitted model: ", grs_wiki))
print("Probablity it rained given that grass is wet:")
# class(grs_wiki)
for (i in 1:10) {
	print( cpquery(grs_wiki, event = (R == "Rain_T"), evidence = (G == "GWet_T")))
}
