install.packages("RODBC")
require(RODBC)
conn = odbcDriverConnect("Driver={SQL Server};

                         server=DESKTOP-JJTCEEQ;

                         database=Storage_Assessment;

                         trusted_connection=true")
pie_data = sqlQuery(conn, "SELECT l.[City ], Count(l.LocationKey) 

                     as CityCrime

                    FROM LocationDim1 l

                    INNER JOIN CrimeFact1 cf

                    ON l.LocationKey = cf.CrimeDateKey
					          Group By l.[City ]
                    Order By l.[City ] Desc")

pie_data
library(ggplot2)
theme_set(theme_bw())
pie_data$`City `<-as.factor(pie_data$`City `)
# Draw plot
ggplot(pie_data, aes(x= `City ` , y=CityCrime)) + geom_bar(stat="identity", width=.5, fill="tomato3") + 
  labs(title="Ordered Bar Chart",subtitle="Crime vs City. Crime Rate", 
       caption="source: mpg") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))

