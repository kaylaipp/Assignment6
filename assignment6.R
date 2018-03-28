library(ggmap)
library(tidyverse)
library(magick)

#didn't end up using to avoid over querying error :)
bude <- geocode("Bude, England")
p1 <- geocode("Bude and North Cornwall Golf Club")
p2 <- geocode("Bude Tidal Swimming Pool")
p3 <- geocode("The Carrier's Inn Pub, Bude England")
p4 <- geocode("Compass Point, Bude England")

#by Deyan
beach <- geocode("Summerleaze Beach") 
pub <- geocode("The Barrel at Bude")

longs <- c(-4.543678,-4.544649,-4.553974,-4.544217,-4.556585,-4.551349,-4.543023)
lats <- c(50.82664,50.832559,50.83257,50.828082,50.82858,50.83054,50.83007)
print(longs)

#table of lats and longs of 5 points + 2 points from Deyan
points12 <- data.frame("longs" = longs, "lats" = lats)
print(points12)

#points from golf club to pub
path1 <- data.frame("longs" = c(longs[2],longs[4]), "lats" = c(lats[2],lats[4]))
print(path1)


#regular map
png('regmap.png')
map <-get_googlemap(center = c(lon=-4.550,lat=50.83),markers = points12,path=path1,zoom = 15)
ggmap(map)
map2<-ggmap(map)+
  geom_point(
    aes(x=longs,y=lats),
    data=points12, size = 1)
plot(map2)
dev.off()

#water color map 
png('watercolor-map.png')
map3 <-get_map(location = c(-4.550,50.83),source = "google",zoom = 14,maptype = "watercolor")
ggmap(map3)
map4<-ggmap(map3)+
  geom_point(
    aes(x=longs,y=lats),
    data=points12, size = 4)
plot(map4)
dev.off()

#by Deyan
SummerleazeBeach <- image_scale(image_read('https://upload.wikimedia.org/wikipedia/commons/9/99/Beach_huts_on_Summerleaze_Beach.jpg'))
print(SummerleazeBeach)
image_write(SummerleazeBeach, "SummerleazeBeach.jpg", format="jpg")

TheBarrelatBude <- image_scale(image_read('http://www.micropubassociation.co.uk/wp-content/uploads/barrel-800x800.jpg'))
print(TheBarrelatBude)
image_write(TheBarrelatBude, "TheBarrelatBude.jpg", format="jpg")
