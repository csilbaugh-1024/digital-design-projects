# Valmis Mk. 3

## Project Goal
My goal with this project is to combine my transmitter and receiver designs into a fully functional UART, which I will test on my FPGA. This UART will, like the transmitter and receiver before it, use 7 bits, no parity, and a baud rate of 9600. Additionally, there will be no sketch design and very little VHDL because this full UART only requires instantiating and connecting the transmitter, receiver, and baud rate generator.

## VHDL Design
For the VHDL design, I created a file called "UART_full.vhd". Next, because this only requires instantiating the transmitter and receiver, I chose structural architecture. Because the transmitter and receiver files each have a baud rate generator file instantiated, there is no need to instantiate one in the full UART design. Furthermore, since the transmitter uses y for an output, and the receiver uses y as an input, I decided to use new variables in the full UART design. So, for "UART_full.vhd", I added R as a single-bit input to the receiver, and I added C as a single-bit output of the transmitter. I included the other relevant top-level inputs and outputs of the transmitter and receiver, W, data_in, D, and clk, unchanged.

## Testing on FPGA and Tutorial

## Problems and Headaches

## What Did I Learn?