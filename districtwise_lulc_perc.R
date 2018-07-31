#Importing district boundaries shapefile#
library(rgdal)
setwd("E:/PhD plans/Ideas/Agricultural landscapes/Pesticide use Idea/Boundary Shapefiles for India/maps-master/maps-master/Districts/Census_2011")
dist_shapefile=readOGR(dsn="E:/PhD plans/Ideas/Agricultural landscapes/Pesticide use Idea/Boundary Shapefiles for India/maps-master/maps-master/Districts/Census_2011",
                       layer="2011_Dist")
dist_shapefile@data
summary(dist_shapefile)
nrow(dist_shapefile)
dist_dataframe=dist_shapefile@data
dist_dataframe_goa=dist_dataframe[which(dist_dataframe$ST_NM=="Goa"),]
dist_shapefile_goa=dist_shapefile[dist_shapefile@data$DISTRICT=="North Goa",]

#Importing LULC raster data for a state as a test#
library(raster)
#Karnataka
karnataka_lulc_ras=raster("E:/PhD plans/Ideas/Agricultural landscapes/Pesticide use Idea/LULC data/request_id10788-karnataka/lulc250k_1011_10788.tif")
#Goa
goa_lulc_ras=raster("E:/PhD plans/Ideas/Agricultural landscapes/Pesticide use Idea/LULC data/request_id10782-goa/lulc250k_1011_10782.tif")
#Extract LULC raster data bounded by district
karnataka_lulc_extract=extract(karnataka_lulc_ras,dist_shapefile)
goa_lulc_extract=extract(goa_lulc_ras,dist_shapefile_goa,df=TRUE)

