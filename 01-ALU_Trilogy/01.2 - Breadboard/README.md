# ALU Trilogy Part Two: Breadboard Prototype

## Part Two Goal
In part one of the ALU Trilogy, which was focused on design and simulation, I designed the ALU with VHDL and verified its functionality using testbenches in Vivado and my FPGA. Because it demonstrated its intended behavior, testing was successful. Now, the design can advance to the physical world and enter the prototyping stage. This is the goal of part two. In this part, I will create a physical breadboard design for the ALU with discrete logic integrated circuits, and I will verify functionality of the completed prototype. Once a successful prototype is complete, the ALU will be ready to reach the third and final stage: a custom PCB design.

## Selecting Logic ICs
The logic behind this design is driven by logic integrated circuits (ICs) that connect to the breadboard and perform a variety of logic operations such as AND, OR, NOT, or other functions such as adding or subtracting bits or multiplexing them. So, before the design can be physically assembled, the first step is to order the proper logic components. Below is a list of the logic components I ordered:

| Part | Common Name | 
| ---- | ----------- |
| SN74HC04N | Inverter |
| SN74HC00N | NAND |
| SN74HC02N | NOR |
| SN74HC08N | AND |
| SN74HC32N | OR |
| SN74HC86N | XOR |
| SN74LS283N | Carry Lookahead Adder |
| SN74LS157N | 2x1 Mux | 

This table does not align perfectly with the list of components I used to design the ALU in VHDL in stage 1, and this is because there were a few supply issues that appeared as I searched for components online. First, I was not able to find an IC for the carry-ripple adder. Instead, I chose the SN74LS283N, an IC that features a 4 bit carry-lookahead adder. Carry-lookahead adders perform the same core function as a carry-ripple adder, only they do so faster and with more gates. Second, I was not able to find an IC for the 8x1 multiplexer that the ALU needs to select its output function. Though this initially seemed like a fatal issue with the project, I discovered a clever method for building an 8x1 mux with only 2x1 muxes that involves chaining seven 2x1 muxes together. Below is a diagram:

![alt text](Mux_Chain.png)

This design has the same functionality as the standard 8x1 mux used in this ALU. For example, setting each multiplexer's associated select line high passes its left input, so s2s1s0=111 would pass i7.

### Bypass Capacitors
Integrated circuits like the ones used in this project can switch on and off very quickly, and their switching can quickly draw current. However, because wires have inductance, the power supply may not be able to supply that current quickly enough. The solution to this problem is bypass capacitors, which are meant to supply voltage quickly in switching events like these. Each IC should usually get its own bypass capacitor, and it should be wired in parallel to the IC's VCC and GND pins. However, the capacitor's legs still have inductance like any other wire. So, the bypass capacitor should be placed as close to the IC as physically possible to minimize the distance the current needs to travel and thus minimize the time it takes to be supplied to the switching IC.

For this project, I chose to follow the datasheets' instructions and use a 0.1-μF "104" ceramic capacitor for each IC.

![alt text](Capacitor104.png)

## Electrical Specifications
Before assembling circuits of any kind, breadboard or PCB, it is important to consider first the electrical characteristics of the components being used. For this project, the electrical specifications of the logic ICs must be respected to avoid potentially damaging them and the circuit. Though these logic ICs have many different specifications, such as recommended input voltage and supply current, they are all displayed clearly on the components' respective datasheets. Additionally, there are a few other concepts to keep in mind to ensure safe operation of ICs like these.

### Supply and Input Values and Current Draw
A few of the most important electrical requirements for each IC in this project include supply voltage (VCC), input voltage (VI), supply current (ICC), and input current. Supply voltage and current are supplied to the IC for functionality, while input voltage and current are the data being inputted and manipulated. Importantly, input current indicates the amount of current that an IC will draw based on its behavior, not the suggested amount that should be fed to the IC at all times. So, it is important to verify that the power supply can handle the current demands of the ICs. For this project, I used a standard arduino power supply module connected to a 9v battery via barrel jack. The datasheets for each IC indicated that they all could accept 5 volts of supply and input voltage, so I configured the power supply to supply 5 volts. Supply and input current was, however, less consistent between ICs. Because they varied from IC to IC, I chose to construct an excel sheet to make analysis easier. This sheet, "ALU Components.csv", is included in this repo. It contains each logic ICs part name, common name, supply voltage, input voltage, supply current, input current, logic family, and datasheet link.

### Fan-Out
Another important electrical concern is fan-out, which describes the amount of subsequent ICs that pull one IC's output as an input. Because this requires current, it can be dangerous for one IC's output to feed into too many other inputs because they may pull too much total current for the outputting IC to handle. In this project, there are two specific instances of fan-out. First, NOT B feeds into both the 2x1 mux before the adder and the 8x1 mux. Second, the adder feeds into the 8x1 mux. Fortunately, these situations do not have an unsafe amount of fan-out, as they only include one output driving two inputs. Everywhere else in the circuit, there is one output driving one input. So, fan-out is a not a risk for this ALU, but it is an important safety concern to understand.

Inversely, it is completely safe to have a cascade-style reverse-fan-out. While it can be dangerous to have multiple inputs pulling from one output, it is completely acceptable for multiple outputs to feed into one input. This works in configurations like the alternative 8x1 mux made of 2x1 muxes shown above, where multiple ICs connect to one in the end.

### Logic Families
Logic ICs are grouped into different families based on certain characteristics. In this project, the 4-bit carry-cookahead adder IC (SN74LS283N) and the 2x1 mux (SN74LS157N) are part of the LS family, while all of the other ICs are part of the HC family. While both families retain the same general functionality, there is one difference that could have been fatal for this project: the LS mux has a high-level output voltage of 2.4-3.4 volts, and the LS adder's high-level output voltage is 2.4-3.6 volts. However, HC family ICs generally prefer high-level input voltage around 5 volts, which is the voltage chosen for this project. In other words, LS family ICs can not always produce a high-level output voltage that is high enough for HC family ICs to recognize and accept. So, it is not reliable to drive HC ICs with LS ones. Fortunately, this never happens in this project. Instead, this project only has either HC driving LS or LS driving LS. Though, it is still best to complete projects like these using ICs of a single logic family, not multiple. So, I should have ordered either only LS ICs or only HC ICs.

## Circuit Design

## Components Used

## Assembling the Prototype

## Final Product and Testing

## Problems and Headaches

## What Did I Learn?

