library(readxl)
library(writexl)


check_id <- function(directory){
  check_file <- setwd(directory)
  results <- data.frame()
  for (name_file in list.files()){
    if (endsWith(name_file, '.csv')){
      open_file <- read.csv(name_file)
      check_id <- ifelse("ID" %in% colnames(open_file), 1, 0)
      results <- rbind(results, data.frame(filename = name_file, type = check_id))
    }
  }
  write_xlsx(results, 'info.xlsx')
}


print(check_id("C:/Users/alimb/test"))