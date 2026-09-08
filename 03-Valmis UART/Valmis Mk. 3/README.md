# Valmis Mk. 3

## Project Goal
My goal with this project is to combine my transmitter and receiver designs into a fully functional UART, which I will test on my FPGA. This UART will, like the transmitter and receiver before it, use 7 bits, no parity, and a baud rate of 9600. Additionally, there will be no sketch design and very little VHDL because this full UART only requires instantiating and connecting the transmitter, receiver, and baud rate generator.

## VHDL Design
For the VHDL design, I created a file called "UART_full.vhd". Next, because this only requires instantiating the transmitter and receiver, I chose structural architecture. Because the transmitter and receiver files each have a baud rate generator file instantiated, there is no need to instantiate one in the full UART design. Furthermore, since the transmitter uses y for an output, and the receiver uses y as an input, I decided to use new variables in the full UART design. So, for "UART_full.vhd", I added RX as a single-bit input to the receiver, and I added TX as a single-bit output of the transmitter. I included the other relevant top-level inputs and outputs of the transmitter and receiver, W, data_in, D, and clk, unchanged.

Next, making the constraints file for this project only required combining the constraints files for the individual transmitter and receiver.

## Testing on FPGA and Tutorial
After connecting the FPGA to my computer and using Vivado's hardware manager to program it, I began testing. First, I opened a PuTTY terminal on my computer with a serial connection, 9600 baud, and 7 bits. Then, I verified that this design can successfully transmit by transmitting verious ASCII values to the PuTTY terminal using the FPGA switches. Next, I verified receiving capabilities by transmitting ASCII values from the PuTTY terminal to the FPGA using my computer's keyboard, and the LEDs on the FPGA illuminated successfully according to the ASCII value received. Below is a link to a YouTube video demonstration.

https://youtube.com/shorts/fmMi4dUeMn8?feature=share

## Problems and Headaches
Since I designed this UART hierarchically and methodically, I did not run into any problems here. Instead, combining the transmitter and receiver was very easy because I had already tested and validated each of them before.

## What Did I Learn?
Though I already came into this specific sub-project with a sound understanding of how UART transmitters and receivers are designed, I had no prior experience with a fully functional UART. So, combining my previous transmitter and receiver designs into a proper UART helped me better grasp its scope and capabilities. Furthermore, it was helpful to test this design by having it send and receive real ASCII values from my keyboard or switches, and this helped me better internalize the utility of UART. In fact, UART is used quite often in electronics. Because of this utility, it was very fulfilling to correctly design something that is useful in the real world.

Additionally, this has been my most advanced project yet by far, and it has helped me improve very much as an engineer beyond my UART knowledge and experience specifically. During this project, I gained experience with Vivado, VHDL, and I gained a better understanding of the capabilities of an FPGA. Also, I gained more experience with the process of engineering design. Because I chose to design my UART thoroughly, in stages, and with lots of testing in between, I encountered no bugs when it came time to assemble the final top-level design. Thanks to my careful and patient approach to designing the project, my final design was not derailed by previous mistakes I did not catch. Overall, this project helped me gain important knowledge about UART, it helped me gain plenty of experience with digital logic design, VHDL, and Vivado, and it helped me gain experience with the engineering design process.