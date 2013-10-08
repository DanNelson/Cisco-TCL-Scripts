#Ping list of IP's \
using TCL

set list_of_IP {
192.168.1.1
192.168.1.2
}

for {set i 0} {$i < [llength $list_of_IP] } {incr i} {
	puts [exec "ping [lindex $list_of_IP $i]"]
}