### Tæller antal NA pr. variabel. Herefter træffes en beslutning om
### Hvorvidt de manglende pladser skal udfyldes, eller om det skal håndteres særskilt.
apply(Xdata,2,function(x) sum(is.na(x)))

###Mange tomme i speed, value og weight. Her må make_model være en god indikator.

### 
proprocessData_local <- function(data){
  
  ### Udregner middelværdien for vh_speed,vh_weight og vh_value pr make_model, da nogle har mange missing værdier
  filldata_vh_speed <- aggregate(Xdata$vh_speed, by = list(Xdata$vh_make_model), function(x) mean(x,na.rm = T))
  names(filldata_vh_speed) <- c("vh_make_model","vh_speed_new")
  filldata_vh_value <- aggregate(Xdata$vh_value, by = list(Xdata$vh_make_model), function(x) mean(x,na.rm = T))
  names(filldata_vh_value) <- c("vh_make_model","vh_value_new")
  filldata_vh_weight <- aggregate(Xdata$vh_weight, by = list(Xdata$vh_make_model), function(x) mean(x,na.rm = T))
  names(filldata_vh_weight) <- c("vh_make_model","vh_weight_new")
  
  ### På de tomme pladser fyldes de aggregerede variable ind.
  data <- merge(data,filldata_vh_speed, by = "vh_make_model")
  data <- merge(data,filldata_vh_value, by = "vh_make_model")
  data <- merge(data,filldata_vh_weight, by = "vh_make_model")
  data$vh_speed <- ifelse(is.na(data$vh_speed),data$vh_speed_new,data$vh_speed)
  data$vh_value <- ifelse(is.na(data$vh_value),data$vh_value_new,data$vh_value)
  data$vh_weight <- ifelse(is.na(data$vh_weight),data$vh_weight_new,data$vh_weight)
  data <- data[,-c("vh_value_new","vh_speed_new","vh_weight_new")]
  
  
  data$pol_payd <- NULL # Der er måske for mange YES til den ikke skal tages med
  data <- na.omit(data)
  data$pol_usage <- revalue(data$pol_usage, c("AllTrips"="Professional")) ## For få og der står i guiden at de minder om hinanden
  data$vh_fuel <- revalue(data$vh_fuel, c("Hybrid"="Gasoline")) ## for få
  
  
  return(data)
}

