proprocessData_local <- function(data){
  data$pol_payd <- NULL # Der er måske for mange YES til den ikke skal tages med
  data <- na.omit(data)
  data$pol_usage <- revalue(data$pol_usage, c("AllTrips"="Professional")) ## For få og der står i guiden at de minder om hinanden
  data$vh_fuel <- revalue(data$vh_fuel, c("Hybrid"="Gasoline")) ## for få
  
  
  
  return(data)
}
