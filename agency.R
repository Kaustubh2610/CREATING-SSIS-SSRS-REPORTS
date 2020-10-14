install.packages("RODBC")
require(RODBC)
library("ggplot2")
conn = odbcDriverConnect("Driver={SQL Server};

                         server=DESKTOP-JJTCEEQ;

                         database=Storage_Assessment;

                         trusted_connection=true")
pie_data = sqlQuery(conn, "SELECT a.Agency, Count(a.AgencyKey) 

                     as TotalCrimeHandledByAgency

                    FROM AgencyDim1 a

                    INNER JOIN CrimeFact1 cf

                    ON a.AgencyKey = cf.AgencyKey
					          Group By a.Agency
                    ")

pie_data
plot(main="Crimes Handeled By Agencies",xlab="Agencies",ylab="Number Of Crimes",pie_data$"Agency", pie_data$"TotalCrimeHandledByAgency", type = "l",col="blue", lty = 1)
lines(pie_data$"Agency", pie_data$"TotalCrimeHandledByAgency", type = "l",col="red",lty = 1)
