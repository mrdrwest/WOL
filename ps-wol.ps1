#-------------------------------#
# Magic packet PowerShell script#
# author: Darrick west          # 
# date: 11/13/2008              #
# date: 12/2/2008 AWESOME!!!     #
#-------------------------------#

#generate syncstream of 6 bytes = 0xFF 
[Byte[]]$syncstream = @(0xFF)*6 # AWESOME!!!
#[Byte[]]$macaddr = [byte[]]("00-AA-01-BB-02-CC".split("-")|%{[int]"0x$_"}) # AWESOME!!!
[Byte[]]$macaddr = [byte[]]("E4-AD-7D-F0-D6-6F".split("-")|%{[int]"0x$_"}) # AWESOME!!!

#----------------------#
#Construct Magic Packet#
#----------------------#

#add syncstream bytes, and 16 sequences (96 elements) of MAC address to $magicpacket byte array
[Byte[]]$magicpacket = $syncstream + @($macaddr)*16 # AWESOME!!!

#------------------------------------#
#Create a socket to send Magic Packet#
#------------------------------------#
"Creating socket..."
$broadcast = [system.Net.IPAddress]::broadcast #get network broadcast address
$endpoint = New-Object system.net.ipendpoint($broadcast,0)
$socket = New-Object system.net.sockets.Socket('InterNetwork','Dgram','Udp')
$socket.SetSocketOption('Socket', 'Broadcast', $true)
$socket.DontFragment = $True

#send the magic packet
"Sending packet..."
$socket.SendTo($magicpacket,$endpoint)

#close the socket
$socket.Close()