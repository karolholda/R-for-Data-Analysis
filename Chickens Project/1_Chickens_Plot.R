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

barplot(data = chickwts, height = chickwts$weight)

barplot(data = chickwts,height = chickwts$weight,
        col=color_column, pch = shapes_column)

legend("topleft", legend = levels(chickwts$feed),
       col = my_colors, pch = my_shapes)

