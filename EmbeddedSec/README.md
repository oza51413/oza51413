# Embedded Security	

# Recon		
[] Target's Intended Functionality		
[] Define Goals: What do i want to do with this device?			
[] FCC documentation fccid.io		

[] Open Case		
	- ID Chips(part numbers, datasheets)		
	- find debug ports, or unpopulated pads		
	- photograph/label all visible ICs		
	- look for devboards, user manuals, errata docs	


# Foothold		

[] Signal Analysis		
	- proto in use?		
	- logic analyzer or oscilloscope		
		- decode proto using Pulseview/sigrok		
	- voltage fluctuations w multimeter(continuity mode)		

[] Signal Interposition		
	- can you interface w identified components?		
	- Extract flash chips via(dump firmware)		
		- SPI		
			- In Circuit Reading or Chip Removal		
		- I2C		
	- Connect to debug interfaces		
		- UART(Universal Asynchronous Receiver Transmitter)		
			- RX,TX,GND		
		- JTAG(Joint Test Access Group)		
			- JTAGEnum		
			- TCK, TMS, TDI, TDO, nTRST		
			- can dump firmware		
		- SWD		
			- SWDIO, SWCLK, GND, VCC		
			- can dump firmware	



# Reverse Engineer		

[] Data Manipulation		
	- analyze extracted firmware w binwalk, ghidra		
	- modify firmware and reflash to device 		
	- patch or backdoor firmware for persistence		

[] Hunt Pw,keys,abusable logic 	



