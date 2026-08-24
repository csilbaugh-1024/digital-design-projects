# Valmis Mk. 2

## Project Goal
Now that the UART transmitter is finished, the natural next step is to begin designing the receiver. So, this is the project goal. The workflow for this project will be very similar to that of the transmitter. First, I will sketch the design's HLSM. Then, I will use this to design the datapath. Next, I will sketch an FSM for the controller, and, after that, I will design the controller. Finally, I will sketch a final design for the receiver with a datapath and controller. After finishing the sketch designs, I will translate these into VHDL with Vivado. There will be a .vhd file for the datapath, the controller, the final receiver design, and I will reuse the baud rate generator from the transmitter, too. This way, the receiver will be designed around the exact same baud rate that the transmitter uses, which will make them easier to combine in Valmis 3. Finally, I will flash this design to my FPGA for physical testing. This time, instead of using my FPGA to transmit information to a PuTTY terminal on my computer, I will use the PuTTY terminal to transmit information to my FPGA. Because the Basys 3 FPGA lacks a display, I will map each bit of the received ASCII value to an LED above the FPGA's switches. This will allow me to verify visually whether my receiver properly received the ASCII value I sent from the PuTTY terminal.

## Sketch Design

## VHDL Design

## Testing on FPGA and Tutorial

## Problems and Headaches
- SEND REGISTER was not truly the problem.
- Ngt6 had to be replaced by Ngt5 to fix timing delay.

## Better Design
- SEND REGISTER is redundant. Only the AND chain is needed for SHOW. Also, it caused a timing delay, so it was removed.
- multiple instances of baud generator. How does this compare to one in the top-level design?

## What Did I Learn?
