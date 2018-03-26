library(ggmap)
library(tidyverse)
#library(magick)

#didn't end up using to avoid over querying error :)
bude <- geocode("Bude, England")
p1 <- geocode("Bude and North Cornwall Golf Club")
p2 <- geocode("Bude Tidal Swimming Pool")
p3 <- geocode("The Carrier's Inn Pub, Bude England")
p4 <- geocode("Compass Point, Bude England")

longs <- c(-4.543678,-4.544649,-4.553974,-4.544217,-4.556585)
lats <- c(50.82664,50.832559,50.83257,50.828082,50.82858)
print(longs)

#table of lats and longs of 5 points
points12 <- data.frame("longs" = longs, "lats" = lats)
print(points12)

#points from golf club to pub
path1 <- data.frame("longs" = c(longs[2],longs[4]), "lats" = c(lats[2],lats[4]))
print(path1)

#regular map
map <-get_googlemap(center = c(lon=-4.550,lat=50.83),markers = points12,path=path1,zoom = 15)
ggmap(map)
map2<-ggmap(map)+
  geom_point(
    aes(x=longs,y=lats),
    data=points12, size = 1)
plot(map2)

saveRDS(map2,file="route_map.rds")

#water color map 
map3 <-get_map(location = c(-4.550,50.83),source = "google",zoom = 14,maptype = "watercolor")
ggmap(map3)

map4<-ggmap(map3)+
  geom_point(
    aes(x=longs,y=lats),
    data=points12, size = 4)
plot(map4)

saveRDS(map4,file="water_map.rds")

##Pictures of locations :)

Crooklet_Beach <- image_read('https://www.visitbude.info/wp-content/uploads/2016/07/Crooklets-Beach-Huts-1.jpg')%>%
  image_scale("600x") %>%
  image_annotate("Crooklet Beach", size = 20, color = "white")

print(Crooklet_Beach)

Summerleaze_Beach <- image_read('http://www.visitbude.info/wp-content/uploads/2015/04/Summerleaze-Decking-3.jpg')%>%
  image_scale("600x") %>%
  image_annotate("Summerleaze Beach", size = 20, color = "white")

print(Summerleaze_Beach)

Bude_North_Cornwall_Cricket_Club <- image_read('https://i.pinimg.com/originals/42/21/20/42212062d2dbf181dc1b1eaa160dce53.jpg')%>%
  image_scale("600x") %>%
  image_annotate("Bude North Cornwall Cricket Club", size = 20, color = "white")

print(Bude_North_Cornwall_Cricket_Club)

The_Barrel_at_Bude <- image_read('http://www.micropubassociation.co.uk/wp-content/uploads/barrel-800x800.jpg')%>%
  image_scale("600x") %>%
  image_annotate("The Barrel at Bude", size = 20, color = "white")

print(The_Barrel_at_Bude)


