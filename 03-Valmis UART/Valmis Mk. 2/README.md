# Valmis Mk. 2

## Project Goal
Now that the UART transmitter is finished, the natural next step is to begin designing the receiver. So, this is the project goal. The workflow for this project will be very similar to that of the transmitter. First, I will sketch the design's HLSM. Then, I will use this to design the datapath. Next, I will sketch an FSM for the controller, and, after that, I will design the controller. Finally, I will sketch a final design for the receiver with a datapath and controller. After finishing the sketch designs, I will translate these into VHDL with Vivado. There will be a .vhd file for the datapath, the controller, the final receiver design, and I will reuse the baud rate generator from the transmitter, too. This way, the receiver will be designed around the exact same baud rate that the transmitter uses, which will make them easier to combine in Valmis 3. Finally, I will flash this design to my FPGA for physical testing. This time, instead of using my FPGA to transmit information to a PuTTY terminal on my computer, I will use the PuTTY terminal to transmit information to my FPGA. Because the Basys 3 FPGA lacks a display, I will map each bit of the received ASCII value to an LED above the FPGA's switches. This will allow me to verify visually whether my receiver properly received the ASCII value I sent from the PuTTY terminal.

## Sketch Design

## VHDL Design

## Testing on FPGA and Tutorial
Testing on the FPGA was successful. I programmed my FPGA with the receiver design, connected it to my computer, and opened a PuTTY terminal at 9600 baud with 7 bits. Then, I typed different letters on my keyboard with the PuTTY terminal open and verified that the appropriate LEDs on the FPGA illuminate according to each sent letter's corresponding ASCII value. Below, I have included a link to a YouTube video where I demonstrate how to use this UART receiver.

https://youtube.com/shorts/Cp6Fhl6WPGQ?feature=share

## Problems and Headaches
Developing the datapath and controller individually went very smoothly, but problems began to arise when I started testing the full receiver design. During testing, I saw that my last two tests failed, indicating that the datapath failed to display the correct D value in the SHOW state. I wrote the testbench to test whether the receiver would receive the ASCII value 110 1011 correctly, which would result in `D = 110 1011`. Instead, the receiver displayed `D = 111 0101`. This is the waveform I saw:

![alt_text](Delay.png)

There are two problems here: First, D should have been equal to `110 1011`, not `111 0101`. Second, the SEND register is outputting UU for a full baud cycle after the receiver finishes receiving. I started debugging by looking at the second of these two problems. This problem is happening because, initially, I neglected to initialize the SEND register's values. So, it started as UU. When the controller entered the SHOW state, t_ld went HIGH, causing the output to be U AND 1 for each bit of D. So, the output here was `D = UUU UUUU`. Even though the SEND register was constantly outputting its saved U value for each bit throughout the whole receiving process, the AND chain was causing D to be equal to `000 0000` because t_ld was 0, and U AND 0 is 0. So, the undefined D value only appeared when t_ld went high in the SHOW state. Contrary to how it may appear, initializing the SEND register would not fix this problem. If I had initialized it to store `000 0000`, it would simply cause the receiver to display `D = 000 0000` in the SHOW state rather than the desired ASCII value, `110 1011`. 

After discovering this, I decided to remove the SEND register entirely. However, this did not fix the problem. D still did not show the correct ASCII value, and it did so one baud cycle too late. Fortunately, the fix to this became quite obvious to me when I analyzed the incorrect ASCII value that was being shown. This receiver was supposed to display `D = 110 1011`, but it actually displayed `D = 111 0101`. The latter value, `111 0101`, is just the former value shifted right by one bit with a 1 inserted. Furthermore, I had configured the testbench to receive an idle `y = 1` after receiving the full ASCII value. So, this design was loading its register chain for one more baud cycle than intended. To fix this, I simply changed Ngt6 to Ngt5, and I modified the comparator to compare N against 101 (5 in binary) rather than 110 (6 in binary). After doing this, the receiver functioned perfectly.

However, this raises the question, "Why did Ngt6 not work for the receiver even though Igt6 worked for the transmitter?" This question stumped me for a while, but the answer lies in what the transmitter uses Igt6 for. The transmitter uses Igt6 for sending all of W as well as an idle bit `y = 1` immediately after. This is essential for a UART transmitter because it must send at least one idle 1 between ASCII values. That way, the start bit, 0, comes after at least one bit of idle behavior. For example, a UART transmitter transmitting as quickly as possible would look like this:

111... (ASCII value #1) 10 (ASCII value #2) 11...

So, the transmitter uses Igt6 because it increments I up to 6 from 0 after sending all 7 bits of W, and then it increments I from 6 to 7 after sending the idle `y = 1`. At this point, Igt6 fires because I is greater than 6, and the transmitter either continues sending idle 1s, or it sends a 0 start bit. The receiver, on the other hand, stores 7 bits while actively receiving. By incrementing N the same way the transmitter increments I, N becomes 6 once all 7 bits of the incoming ASCII value are stored. So, the controller should move states when `N = 6`. However, `Ngt6 = 0` when `N = 6`, so the receiver does not move states until one more bit is erroneously stored, after which Ngt6 fires because N is 7. So, modifying the receier to use Ngt5 rather than Ngt6 ensures it changes states at the correct time, as soon as all 7 bits of the incoming ASCII value are stored.

## Better Design
- SEND REGISTER is redundant. Only the AND chain is needed for SHOW. Also, it caused a timing delay, so it was removed.
- multiple instances of baud generator. How does this compare to one in the top-level design?

## What Did I Learn?
