install.packages("RODBC")
require(RODBC)
conn = odbcDriverConnect("Driver={SQL Server};

                         server=DESKTOP-JJTCEEQ;

                         database=Storage_Assessment;

                         trusted_connection=true")

data = sqlQuery(conn, "SELECT c.CrimeName1, Count(c.CrimeKey) 

                     as CountofCrime

                    FROM CrimeDim1 c

                    INNER JOIN CrimeFact1 cf

                    ON c.CrimeKey = cf.CrimeKey
					 Group By CrimeName1
                    Order By CountofCrime")
data
png("CrimeType.png")
pie_percentage = round(data * 100/sum(data$CountofCrime),1)

pie(data$CountofCrime, main="Total Crime",
    
    col=rainbow(length(data$CountofCrime)))

legend("topright", c("Other","Crime Against Person","Crime Aganist Property","Crime Against Society","Not a Crime"),
       
       fill=rainbow(length(data$CountofCrime)), cex=1)
box()
dev.off()



