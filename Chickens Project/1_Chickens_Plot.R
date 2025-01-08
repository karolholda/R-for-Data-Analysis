data()
chickwts

nrow(chickwts)
plot(x=1:nrow(chickwts), y=chickwts$weight)

plot(x=1:nrow(chickwts), y=chickwts$weight, pch=15)
plot(x=1:nrow(chickwts), y=chickwts$weight, cex=1)
plot(x=1:nrow(chickwts), y=chickwts$weight, col='blue', xlab = 'chicken', ylab = 'Chicken's weight')

plot(x=1:nrow(chickwts), y=chickwts&weight, col='blue', xlab = 'chicken', ylab = 'Chicken's weight')

my_colors <- c('red', 'yellow', 'green', 'orange', 'violet', 'blue')
my_shapes = (15:20)

color_column <- my_colors[as.numeric(chickwts$feed)]
shapes_column <- my_shapes[as.numeric(chickwts$feed)]

plot(x=1:nrow(chickwts), y=chickwts$weight,
     col=color_column, pch = shapes_column,
     xlab = 'chicken', ylab = "Chicken's weight")

legend("topleft", legend = levels(chickwts$feed),
       col = my_colors,
       pch = my_shapes)

# ---------------------------------------------------------------------------------------------------------------
# Poniżej wykres słupkowy ukazujący rodzaj pokarmu, którymi były karmione kurczaki. Można wysnuć wniosek, że najpopularniejszą karmą były casein oraz sunflower
# ---------------------------------------------------------------------------------------------------------------

barplot(data = chickwts, height = chickwts$weight)

barplot(data = chickwts,height = chickwts$weight,
        col=color_column, pch = shapes_column)

legend("topleft", legend = levels(chickwts$feed),
       col = my_colors, pch = my_shapes)

# ---------------------------------------------------------------------------------------------------------------
# Poniżej histogram ukazujący, że najcześciej w hodowli występowały kurczaki o wadze między 300, a 350 gramów.
# Można również wysnuć wniosek, że najmniej było największych kurczaków o masie około 400 gramów.
# ---------------------------------------------------------------------------------------------------------------

ord_chick <- chickwts[order(chickwts$weight), ]
hist(ord_chick$weight, 
     breaks = 5, 
     xlab = "Weight of Chickens (grams)", 
     ylab = "Frequency", 
     main = "Histogram of Chicken Weights")

# ---------------------------------------------------------------------------------------------------------------
# Poniżej prezentuję wykres pudełkowy pokazujący nie tylko medianę dla poszczególnych grup, ale również odchylenie standardowe.
# Wykres ten ukazuje jakiej karmy nie używać oraz jaką używać, by kurczaki rosły jak najlepiej.
# ---------------------------------------------------------------------------------------------------------------

boxplot(weight ~ feed, data = chickwts, varwidth = TRUE, notch = TRUE,
        col='gray')

# ---------------------------------------------------------------------------------------------------------------
# Poniżej średnią wagę kurczaka w zależności od karmy
# ---------------------------------------------------------------------------------------------------------------

feed_mean <- tapply(chickwts$weight, chickwts$feed, mean, na.rm=T)
feed_mean

barplot(feed_mean, 
        main = "Mean Chicken Weight by Feed Type", 
        xlab = "Feed Type", 
        ylab = "Mean Weight (grams)", 
        col = "lightblue", 
        las = 2)  # Obraca etykiety osi X
