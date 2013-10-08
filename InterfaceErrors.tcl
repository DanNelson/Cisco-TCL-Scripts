#Show errors on interfaces

proc interfaces {} {
	set show_int [exec "show interfaces"]
	set interface_status {}
	set line_status {}
	set interfaces {}
	set interface_IP {}
	
	#returns as a list and gets all interfaces    
	foreach interface [regexp -all -inline -line "^\[A-Za-z\]+\[0-9\]+\[/0-9\]*" $show_int] {
  		set current_show [exec "show interface $interface"]
  		lappend interfaces $interface
  		set current_interface_status [regexp -line -inline "^$interface.*$" $current_show]
  		 if {[string match {*administratively down*} $current_interface_status]} {
  		 	lappend interface_status {The interface is shutdown}
  		 } else {
  		 	lappend interface_status {The interface is up}
  		 } 
  		  if {[string match {*line protocol is up *} $current_interface_status] == 0} {
  		 	lappend line_status {The line protocol is down}
  		 } else {
  		 	lappend line_status {The line protocol is up}
  		 } 
  		 if {[string match {*Internet address*} $current_show] == 1} {
  		 	lappend interface_IP [regexp -line -inline "\[0-9\]+\.\[0-9\]+\.\[0-9\]+\.\[0-9\]+/\[0-9\]+" $current_show]
  		 } else {
  		 	lappend interface_IP {Unassigned}
  		 }	 
	}
	
	for {set i 0} {$i < [llength $interfaces] } {incr i} {
		puts "Interface: [lindex $interfaces $i]"
		puts "\tStatus: [lindex $interface_status $i]"
		puts "\tLine Status: [lindex $line_status $i]"
		puts "\tIP Address: [lindex $interface_IP $i]"
	}
}
