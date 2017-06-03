
##this script reads in the HPC data set and then creates 4 line graphs
##that will be exported to a single pmg


##read in the data
HPC <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
HPC$Date <- as.Date(strptime(HPC$Date,format="%d/%m/%Y"))
use_dates <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
HPC_filter <- HPC[(HPC$Date  %in% use_dates), ]

##tidy up some variables into numeric, and some other tidy ups
HPC_filter$Global_active_power <- gsub("?","",HPC_filter$Global_active_power)
HPC_filter$Global_active_power <-as.numeric(HPC_filter$Global_active_power)

HPC_filter$Global_reactive_power <- gsub("?","",HPC_filter$Global_reactive_power)
HPC_filter$Global_reactive_power <-as.numeric(HPC_filter$Global_reactive_power)

HPC_filter$Sub_metering_1 <- gsub("?","",HPC_filter$Sub_metering_1)
HPC_filter$Sub_metering_1 <- as.numeric(HPC_filter$Sub_metering_1)

HPC_filter$Sub_metering_2 <- gsub("?","",HPC_filter$Sub_metering_2)
HPC_filter$Sub_metering_2 <- as.numeric(HPC_filter$Sub_metering_2)

HPC_filter$Sub_metering_3 <- gsub("?","",HPC_filter$Sub_metering_3)
HPC_filter$Sub_metering_3 <- as.numeric(HPC_filter$Sub_metering_3)

HPC_filter$Voltage <- gsub("?","",HPC_filter$Voltage)
HPC_filter$Voltage <- as.numeric(HPC_filter$Voltage)
HPC_datetime <- strptime(paste(HPC_filter$Date,HPC_filter$Time),"%Y-%m-%d %H:%M:%S")
HPC_filter2 <- cbind(HPC_filter,HPC_datetime)

##plot 4; multiple plots
par(mfrow=c(2,2))

plot(HPC_filter2$HPC_datetime,HPC_filter2$Global_active_power,type="n",xlab="",ylab="Global Active Power")
lines(HPC_filter2$HPC_datetime,HPC_filter2$Global_active_power)

plot(HPC_filter2$HPC_datetime,HPC_filter2$Voltage,type="n",xlab="datetime",ylab="Voltage")
lines(HPC_filter2$HPC_datetime,HPC_filter2$Voltage)

plot(HPC_filter2$HPC_datetime,HPC_filter2$Sub_metering_1,type="n",xlab="",
     ylab="Energy sub metering")
lines(HPC_filter2$HPC_datetime,HPC_filter2$Sub_metering_1)
lines(HPC_filter2$HPC_datetime,HPC_filter2$Sub_metering_3,col="blue")
lines(HPC_filter2$HPC_datetime,HPC_filter2$Sub_metering_2,col="red")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),col=c("black","red","blue"),cex=0.6)

plot(HPC_filter2$HPC_datetime,HPC_filter2$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
lines(HPC_filter2$HPC_datetime,HPC_filter2$Global_reactive_power)
dev.copy(device=png,'plot4.png',width=480,height=480)
dev.off()

par(mfrow=c(1,1))