# Valmis Mk. 1

## Project Goal
The goal of Valmis Mk. 1 is to develop a UART transmitter capable of transmitting 7-bit ASCII characters. The Valmis Mk. 1 will be designed on paper, developed with VHDL in Vivado, and then it will be flashed onto an FPGA. The switches on the FPGA can be used to configure the ASCII character, and another switch is used to send it. The FPGA will be connected to a computer to display the output.

## What is a UART?
UART stands for universal asynchronous receiver/transmitter, and it is a protocol for sending information from one device to another. Specifically, UARTs send ASCII characters. For example, if someone wanted to use a UART to send "Hi" from one device to another, they would send two ASCII letters: 01001000 (H) and 01101001 (i). However, a transmitting UART sends ASCII letters in reverse by starting with the LSB rather than the MSB. This way, a receiving device catches the LSB first and the MSB last, allowing it to receive the ASCII letter in the correct form. Also, a UART does not only send the ASCII letters themselves. Rather, it must indicate when it is stopping or starting. So, an idling UART that is not sending any ASCII letters will constantly send a 1. To indicate that it is beginning a letter, it sends a 0. This is the start bit. Once the letter is done, it sends a 1 to indicate that it is finished. After, the UART continuously sends 1 until it is ready to repeat the process and send another letter. So, sending "Hi" would actually look like this:

1...10 00010010 10 10010110 1...

So, there are continuous 1s to indicate idling followed by a 0 start bit, then the reverse ASCII for H, followed by another stop bit and start bit. Then, the transmitter sends reverse ASCII for i, and it resumes idling, indicated by constant 1s again. 

Furthermore, UARTs are asynchronous, meaning that they are not synchronized with a device's clock when they send data. Rather, UARTs use baud rates, which dictate how quickly bits are sent. This way, two devices with different internal clocks can communicate with each other so long as they are operating at the same baud rate. Along with this, another one of UART's strengths is that it only requires two wires: TX to transmit and RX to receive. Each device connects its own TX pin to the other's RX pin.

## Sketch Design
When designing a digital circuit, the first step is to make a sketch or multiple sketches. For basic sequential circuits, the best first sketch to make is often an FSM. However, standard FSMs are not capable of certain functions that more advanced digital circuits like a UART demand. Instead, this design must start with a sketch of a high-level state machine (HLSM).

### HLSM
HLSMs are like FSMs, only more advanced. Like FSMs, HLSM sketches feature bubbles that represent different states, conditions to either stay at a state or move between them, and different outputs based on the present state. Unlike FSMs, though, HLSMs are capable of storing variables, manipulating data, comparing numbers, and other more sophisticated functions. 

Before making the HLSM, though, engineers should first clearly identify their design's functions based on the project goal, and they should have a clear and well thought-out plan. Doing this step first makes designing an HLSM substantially easier. So, I started by identifying the inputs and outputs of the transmitter. First, there is only one one-bit output, I called this y. y is one bit because a serial transmitter like this one only sends one bit at a time. Second, there are two inputs: a 7-bit ASCII word, I called this W, and a one bit ON/OFF input to send W, which I called data_in. With these inputs and outputs identified and standard UART serial transmitter behavior in mind, we can already reason that this transmitter must take the 7-bit input W and send each bit one at a time starting from the LSB, W(0), when data_in goes HIGH.

I continued by conceptually decomposing my transmitter plan into three core functions based on how UART transmitters work: first, UART transmitters continuously send 1s when they are idle. Second, they transmit exactly one 0 to act as a start bit and indicate to a receiver that data is coming. Third, the data is sent bit by bit. After that, the transmitter must, no matter what, return to an idle state and send repeating 1s again for at least one baud cycle. From there, it can either stay idle and continue to send 1s or send the 0 start bit and transmit once more. So, I took these three discrete functionalities and allocated a state and output for each. I plotted an "IDLE" state as the initial state where `y=1`. This represents the idle behavior where 1s are continuously sent. From IDLE, inputting data_in' causes the HLSM to loop back to IDLE, and data_in moves to the next state. The second state is "START", which is meant to handle the start bit. So, `y=0` in START. Here, it does not matter whether data_in is HIGH or LOW; the HLSM will begin to send W regardless. So, the HLSM always goes to the third state from START. I called this third state "SEND" and dedicated it to sending W. However, because the transmitter must send W one bit at a time starting from its LSB, there is no single y output that can be assigned to SEND. That is, unless the transmitter is being designed to send exactly one ASCII letter that is either 1111111 or 0000000. For example, if I were to decide that `y=1` at SEND, it would be impossible to send ASCII letters that contain zeros. 

Up until now, this design has been no different from that of an FSM. But, an FSM alone is not reasonably capable of the functionality that this transmitter needs. This is where the utility of HLSMs begins to show itself. Because W has multiple bits that vary between 1 and 0, the solution is to introduce a variable. So, I decided to set y equal to W(I), where I is the nth bit of W. I also added another output of the SEND state: `I = I + 1`. By doing this, the output y can increment the digit of W it sends each time. For example, the transmitter could first send the 0th bit of W by setting `y = W(0)`, loop to SEND again, send `y = W(1)`, loop to SEND again, send `y = W(2)`, and continue this way until it reaches W(6), the final bit of W. This way, I increases by one each time SEND loops to itself. However, this only works if I begins at 0. So, I went back to the START state and included `I = 0` as one of its behaviors.

Of course, the natural next question is "How does the controller know to loop at SEND until all seven bits of W have been sent?" Again, the solution lies with I. `I = 0` sends W(0), the first bit of W, `I = 1` sends W(1), the second bit of W, and `I = 6` sends W(6), the seventh and final bit of W. Any I value greater than `I = 6` therefore cannot be used the same way the first seven I values can. So, the controller can know when to stop looping SEND by observing whether I is greater than 6. So, I introduced a new input to the controller called "Igt6". From SEND, the controller will loop back to SEND when Igt6' is inputted, and it will move from SEND to IDLE when Igt6 is inputted. With this, the HLSM is finished. My sketch of the initial HLSM and the FSM are below:

![alt_text](Valmis1_HLSM_FSM.png)

### Datapath
After the HLSM is made, the next step is to use it to design a datapath. Similar to how an FSM can be translated into a controller and state register, an HLSM can be translated into a datapath, controller, and state register. The datapath is responsible for the outputs and variables of the HLSM. In this case, it must do two things. First, it must increment the variable I starting from 0 and send a signal "Igt6" when I is greater than six. Second, it must output W in the correct format. These two functions will make up two distinct zones in the datapath, and it is best to start with the I zone because it is easier. 

The zone for I uses four different components that connect together like a tree. First, at the very top, I placed a three bit 2x1 multiplexer. I called this the "I mux" and, and I added a new output to the controller called "I_sel", which I connected to the select line of the I mux. This way, the controller controls the output of the mux. I chose three bits for this mux because any I values after the largest possible binary number, 111 (7 in decimal), are not important for this digital circuit. Next, the inputs of this mux must either be zero, which is chosen in the START state by `I = 0`, or `I = I + 1`, which is chosen in the SEND state. So, I connected 000 to i1 of the mux. Before approaching the second input, `I + 1`, I connected the output of this mux to a register. Then, I recorded another output of the controller and called it "I_ld". I_ld is connected to I's register and controls whether it loads new values or not. Because the value of I changes as the HLSM moves between states, variable I must have a register just as the binary state digits of an FSM must. In fact, inputs, outputs, and variables in datapaths usually require their own registers. Then, I connected the output of this register to two separate components. First, I connected it to an incrementer. I then connected this incrementer's output back to i0 of the mux. This way, to output `I = I + 1`, the controller can simply choose i1, `I = 0`, then it can choose the incrementer's output, which is `0 + 1 = 1`. The controller can simply repeat this process until I reaches 7. As for the register's output's other connection, I used a three bit comparator. The first input of this comparator is, of course, I, and I connected 110 (six in decimal) as the other input. When I is greater than six in binary, the comparator outputs the signal "Igt6" to the controller. With this, I's branch of the datapath is finished.

The branch for W is larger, and it again begins with a 2x1 mux. However, this mux is seven bits rather than three. On the left side, for input i1, I connected W(7) and created another output of the controller called "W_sel" to drive this mux's select line. As for i0 of this mux, what I connected here will not make sense until more of W's branch is explained. Then, I fed the output of this mux to a register for W. Just like I's register, I created a new output of the controller called "W_ld" that is responsible for loading a new value to the W register. The W register then, again like I's, has an output that connects to two separate components. First, I had this output connect to a box that I labelled "LSB", which passes only the least significant bit of W. Though this can be done with only wires, I included an "LSB" component to indicate the intention of the design, and I also indicated that the output of this LSB component is W(0). Before continuing, it is essential to understand why this design needs the LSB of W. Here is my reasoning: a UART transmitter takes a multi-bit word and transmits one bit at a time starting from the LSB. So, W must be passed through wiring that isolates its least significant bit to be transmitted first. The most natural next question is, "how will this design transmit the remaining bits of W in the correct order?" When trying to answer this question, I discovered that there is, surprisingly, no need to design circuitry that passes anything other than the 0th bit of W. Instead, this transmitter can transmit all 7 bits of W by simply shifting W to the right by one bit and passing the LSB of this new W. This can be done repeatedly until the most significant bit of W is passed as the least significant bit of a new W that has been right-shifted 6 times. Yes, rather than modifying the hardware to pass any bit position other than the 0th bit, I chose to simply manipulate W so that the new 0th bit be the 1st bit. This only needs a shifter. So, I connected the other output of the W register to a right shifter whose output connects back to i0 of the W mux. This way, the W mux can pass either W or W/2, which has been shifted to the right one bit. If W/2 is selected, then the transmitter will pass its LSB, which is simply the second-least significant bit of W. W/2 can be sent through the shifter to be right-shifted again, which would pass the third-least significant bit, and so on. This is the exact same structure that allows I to be incremented by 1 and satisfy the state behavior `I = I + 1`, only this structure uses a right-shifter rather than an incrementer. Finally, I chose to design the shifter to shift in a 1. Though these 1s are useless because the transmitter does not need to transmit anything further than the MSB of the original W, I chose to shift in 1s so that I could have some flexibility in my design in case I wanted to use these shifted 1s for the idle output after the very first ASCII word is passed completely.

Alternatively, all seven bits of W could be connected to an 8x1 mux with the eigth input being 1 for idle bahvior. This way, the controller could drive the three select bits of this mux to determine which bit of W to pass. This may be the way that UART transmitters are normally designed. Though this is more logically straightforward and easier to understand, it is more costly in hardware than my shifter idea.

This hardware design is all that is needed to pass W in its entirety one bit at a time, but it is not yet capable of passing the idle 1s or the 0 start bit. So, the next question is, "what is the minimum logic needed to pass either W(I), 0, or 1?" At first, it may seem like this requires a 3x1 mux or a 4x1 mux with one input unused. However, I discovered a clever solution that only requires a 2x1 mux. Since this mux drives the output of the transmitter, I called this the y mux, driven by y_sel from the controller. Understanding this solution requires looking back at the HLSM: state 00 is the IDLE state, where `y=1`, state 01 is the START state, where `y=0`, and state 10 is the SEND state, where `y=W(I)`. In IDLE, this state's 0th bit is `p1=0`, and the output, y, is 1. In START, this state's 0th bit is `p1=1`, and the output is 0. In other words, the transmitter's output in both states IDLE and START is simply the current state's 0th state bit complemented. This is represented with p1'. So, I connected p1 of the controller to a NOT gate and then to i1 of the y mux. For i0, I connected W(0), which is the output of the LSB component. With this design, the controller can configure y_sel to pass `p1'=1` in IDLE, `p1'=0` in START, and W(I) in SEND. Then, the output of this mux connects to a register that I called the "y register". Of course, this register is loaded by the controller's output "y_ld". With this, the datapath is complete. 

Included below is my initial sketch of the datapath followed by my final datapath and controller sketch.

![alt_text](Valmis1_Initial_Datapath.png)

![alt_text](Valmis1.png)

### FSM
The next step is to design the FSM, which is very similar to the initial HLSM. It has the same three states: IDLE, START, and SEND, and the conditions to move between the states are conceptually similar. Only, since the FSM is meant to be used to design the controller, it includes as outputs the signals that control the datapath. In my sketch, I still included the values of the variable I and the output y to remind myself of the conceptual significance of the states I designed, but these are not necessary because the controller does not directly drive I or y. Instead, the controller outputs these values:

 + I_sel
 + I_ld
 + W_sel
 + W_ld
 + y_sel
 + y_ld

Yes, the controller is primarily responsible for driving the multiplexers and load registers in the datapath. So, I started by designing the initial state, IDLE. At IDLE, the outputs of the controller are:

 + I_sel = x
 + I_ld = 0
 + W_sel = x
 + W_ld = 0
 + y_sel = 0
 + y_ld = 1

As shown above, I_sel is a don't care because `I_ld = 0`. In other words, it does not matter what I value is selected in the I mux because no new I value is being loaded in this state. The same applies for W. For y, however, the idle output is 1, so p1' is being passed through the y mux and loaded. Data_in' causes the FSM to loop back to IDLE, and data_in moves to START. At START, the outputs are:

 + I_sel = 0
 + I_ld = 1
 + W_sel = 0
 + W_ld = 1
 + y_sel = 0
 + y_ld = 1

From START, the FSM will always move to the next state, SEND. Here, I again included `y = W(I)` to keep the purpose of the state clear to myself, but it is important to keep in mind that this is not a direct output of the controller. Instead, the outputs here are:

 + I_sel = 1
 + I_ld = 1
 + W_sel = 1
 + W_ld = 1
 + y_sel = 1
 + y_ld = 1

FSMs cannot store and compare variables the same way an HLSM can. So, to check whether I is greater than 6 at the SEND state, the FSM simply uses the signal Igt6 that comes from the comparator in the datapath. From SEND, the controller will loop to SEND again with input Igt6', and input Igt6 causes the controller to return to IDLE. From here, the next step was to draw a large truth table and make K maps to find the boolean equation for each output and state bit of the FSM. Then, these boolean equations can be used to design the controller circuit, and the controller's outputs can be connected to their proper destinations in the datapath. This is my sketch of the HLSM with the FSM below it:

![alt_text](Valmis1_HLSM_FSM.png)

And, here is my initial sketch of the controller:

![alt_text](Valmis1_Controller.png)

## VHDL Design

### Datapath

### Controller

### Baud Rate Controller

### Full Transmitter Design

## Testing on FPGA

## Tutorial for Use

## Problems and Headaches
- bit width in testbench (building muxes for different widths) (wip)
- y is one cycle behind in waveform (not technically a bug) (wip)
- unneeded edge detector in y mux
- needed edge detector for human use

## What Did I Learn?