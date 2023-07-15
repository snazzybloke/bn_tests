# From C. Bishop, "Patern Recognition and ML", section 8.2.1

library(bnlearn)
# B = car battery, F = fuel tank, G = fuel gauge (powered by the Battery)
wiki = model2network("[B][F][G|B:F]")
print(paste("Model string: ", modelstring(wiki)))

cpt_B <- matrix(c(0.9, 0.1), ncol=2, dimnames = list(NULL, c("Battery_full", "Battery_flat")))
print("Battery CPT: ")
print(cpt_B)
cpt_F <- matrix(c(0.9, 0.1), ncol=2, dimnames = list(NULL, c("Tank_full", "Tank_empty")))
print("Fuel tank CPT: ")
print(cpt_F)
cpt_G <- array(c(0.8, 0.2, 0.2, 0.8, 0.2, 0.8, 0.1, 0.9),
	       dim=c(2, 2, 2),
	       dimnames = list("G" = c("G_tank_full", "G_tank_empty"),
			       "B" = c("Battery_full", "Battery_flat"),
			       "F" = c("Tank_full", "Tank_empty")))
print("Fuel Gauge CPT: ")
print(cpt_G)

gbf = custom.fit(wiki, dist = list(B = cpt_B, F = cpt_F, G = cpt_G))

print(paste("Fitted model: ", gbf))
# class(gbf)
print("Probablity the tank is actually empty given that the gauge indicates so:")
for (i in 1:10) {
	print(cpquery(gbf, event = (F == "Tank_empty"), evidence = (G == "G_tank_empty")))
}
print("Probablity the tank is empty given that the gauge indicates so with the battery flat:")
for (i in 1:10) {
	print(cpquery(gbf, event = (F == "Tank_empty"), evidence = ((G == "G_tank_empty") & (B == "Battery_flat"))))
}
