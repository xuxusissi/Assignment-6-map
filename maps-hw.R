library(ggmap)
library(tidyverse)

# simple mapping with ggmap

# get a water map for Bude
gc <- geocode("Bude")
map_water <- get_map(gc, source="stamen", maptype = "watercolor",zoom=14)
ggmap(map_water) 
# get a road map for Bude
map_road <- get_map(gc, source="google", maptype = "roadmap",zoom=14)
ggmap(map_road)

#mark points for crooklets Beach, Summerleaze Beach, cricket-Bude and THe Heron on watermap 
#gc1 <- geocode("Crooklets Beach, Bude")
#gc2 <- geocode("Summerleaze Beach, Bude, UK")
#gc3 <- geocode("Bude North Cornwall Cricket Club, Bude, UK")
#gc4 <- geocode("Crooklets Inn, Bude,UK") 

lon <- c(-4.553962,-4.551349,-4.552814,-4.550984)
lat <- c(50.83587,50.83054,50.83347,50.8362)

df <- as.data.frame(cbind(lon,lat))

ggmap(map_water) +
  geom_point(
    aes(x = df$lon, y = df$lat),
    data = df, color = "red", size = 3
  )

#mark points for crooklets Beach,Summerleaze Beach,cricket-Bude, crooklets Inn and shortest distance on roadmap

from <- "Bude North Cornwall Cricket Club, Bude, UK"
to <- "Crooklets Inn, Bude"
route_df <- route(from, to, structure = "route")
ggmap(map_road) +
  geom_path(
    aes(x = lon, y = lat), color = "red", size = 2,
    data = route_df, lineend = "round")+
  geom_point(aes(x=df$lon, y=df$lat),
             data=df, color = "red", size=2)
