install.packages("RODBC")
require(RODBC)
conn = odbcDriverConnect("Driver={SQL Server};

                         server=DESKTOP-JJTCEEQ;

                         database=Storage_Assessment;

                         trusted_connection=true")
pie_data = sqlQuery(conn, "SELECT c.Year, Count(c.CrimeDateKey) 

                     as CountofCrime

                    FROM CrimeDate c

                    INNER JOIN CrimeFact1 cf

                    ON c.CrimeDateKey = cf.CrimeDateKey
					 Group By Year
                    Order By c.Year
")

pie_data

barplot(pie_data$CountofCrime,pie_data$CountofCrime, main="Number Of Crimes from the year 2016-2019",
        xlab="YEAR", ylab="COUNT OF CRIME",names.arg=pie_data$Year,
        
        cex.names = 0.5,
        
        cex.axis=0.5,
        
        col=rainbow(length(unique(pie_data$CountofCrime))),
        
        legend.text = unique(pie_data$CountofCrime),
        
        args.legend = list(horiz=TRUE, x="topleft", cex=0.5))


