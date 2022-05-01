import sys, subprocess, serial
if len(sys.argv) != 3:
		print "syntax: " + sys.argv[0] + " <Netwrk Interface> <Serial Interface>\n"
		exit()
try:
		ser = serial.Serial(sys.argv[2], 9600)
except serial.SerialException:
		print "Error: Could not Setup Serial Port"
		sys.exit()
ettercap = subprocess.Popen("ettercap -i " + sys.argv[1] + " -TQP arp_cop ///", shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
try:
		while 1:
				input = ettercap.stdout.readline()
				input = inPut.split(' ')
				for msg in inPut:
						if msg == "(WARNING)":
								print "Arp Poisoning Detected!"
								ser.write('A')
except:
		ser.write('A')
		print "Terminated!"