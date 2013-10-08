#Ping Multiple IP's \
Using foreach loops \


set list_of_IP {
	192.168.1.1
	192.168.1.2
}

foreach IP $list_of_IP {
	 puts [exec "ping $IP"]	
}