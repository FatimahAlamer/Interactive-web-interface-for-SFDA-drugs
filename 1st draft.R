library(tidyverse)

HumanDrugs <- read_csv("Data/HumanDrugs.csv")

colnames(HumanDrugs)

#drop product type # drop markting status 
HumanDrugs %>% count(`Product type`) 
# aLL HUMAN , 6 (NAs)
# drop Arabic columns
HumanDrugs %>% count(`Authorization Status`) 
# drop AtcCode2, more than 7000 are missing
HumanDrugs %>% count(AtcCode2) -> code
HumanDrugs %>% count(AtcCode1) -> first_code
#EVERY DRUG HAS UNQUE REG_NO
HumanDrugs %>% count(RegisterNumber)

HumanDrugs %>% count(`Product Control`) 

# possible prediction of registerd drugs, predction on price based on clss

HumanDrugs %>% count(RegisterYear)-> RegisterYear
HumanDrugs %>% count(`Sub-Type`)
HumanDrugs %>% count('Scientific Name Arabic')
# nice one
HumanDrugs %>% count(AdministrationRoute) ->AdministrationRoute

HumanDrugs %>% count(SizeUnit)

HumanDrugs %>% count(PackageSize)
HumanDrugs %>% count(`Public price`) -> price
HumanDrugs %>% count(`Storage conditions`) -> storge_con
#nice one
HumanDrugs %>% count(`Marketing Country`) -> markteing_coun
HumanDrugs %>% count(`Manufacture Country...29`) -> man_coun
#drop Manufacture Country...31 same the first but lots of missing values 
HumanDrugs %>% count(`Manufacture Country...31`) -> sec_man_coun
HumanDrugs %>% select(`Main Agent`,`Secosnd Agent`,`Third agent`)-> agents
HumanDrugs %>% select(`Manufacture Name`,`2Manufacture Name`)-> man_name
#drop 2 2Manufacture Name it contain only 41 obser which is identical to Manufacture Name
#nice one
HumanDrugs %>% count(shelfLife) -> shelf
HumanDrugs %>% count(`Trade Name`)
HumanDrugs %>% count(`Secondry package  manufacture`)
HumanDrugs %>% count(`Marketing Status`)

select (HumanDrugs,-c(`Marketing Status`,`Scientific Name Arabic`,`Trade Name Arabic`,AtcCode2,`Product type`,`Manufacture Country...31`,`2Manufacture Name`)) ->Sdrugs

write_csv(Sdrugs,"Data/Sdrugs.csv")
