# FSM Battery Charger

## Project Goal
The goal of this project is to sharpen my VHDL and digital design skills and deepen my understanding of Vivado and FPGAs by implementing an FSM based on the logic of a battery charger. This project includes sketching the state driagram, truth table, and corresponding circuit of the FSM, building the FSM with VHDL in Vivado and, finally, testing it on my FPGA.

## FSMs and Sequential Logic
There are two types of logic used in digital logic design: combinational logic and sequential logic. Combinational logic describes an output that depends solely on the current inputs, and there is no element of memory. An ALU, for example, is purely combinational. Sequential logic, on the other hand, incorperates memory and describes an output that may depend on a history of inputs. Sequential logic, like combinational logic, is essential for modern technology, and the two logic types often appear together. Sequential logic often appears as SR latches, D-latches, D-flip flops, or registers. Registers are particularly useful for sampling data, storing it, and then supplying it. To do this effectively, they are connected to a clock so that they operate on an interval. As the clock oscillates periodically between high and low, registers sample data the moment a clock transitions from low to high, called the "rising edge". This data is stored and supplied continuously until it is overwritten by a different value at another rising edge of the clock. A register is said to be "synchronous" because it operates with a clock.

One important application of sequential logic is the finite state machine, FSM, which is a type of digital circuit that incorperates a combinational element, a controller, and a sequential element, a register. Based on the history of combinations of inputs, FSMs move between a finite number of states synchronously with the clock. FSMs are useful in a variety of modern electronics such as vending machines and elevators, whose behavior depends on a sequence of inputs. This project uses the FSM of a battery charger.

## How Does It Work?
One of the very first steps of designing an FSM is drawing the state diagram, which is a collection of circles and arrows that illustrates the various numbered states of the FSM, their outputs, and the conditions to move between them or remain at a state. States are denoted as circles, while arrows represent the possible paths to and from a state. This FSM waits to receive a battery in the "wait" state, charges it in the "chrg" state if the battery is connected and not fully charged, and it stops charging if the battery becomes full or is removed. If the battery is removed before charing is complete, the circuit returns to the "wait" state. If the battery remains but becomes fully charged, the circuit enters a "done" state where it waits for the battery to either be removed or need charging again. If the battery is removed, the circuit returns to the "wait" state. If the battery loses charge and needs to be recharged, the circuit returns to the "chrg" state. 

It is important to label the states in binary to make the truth table easier to construct and interpret. "Wait" is labelled 00, "chrg" is labelled 01, and "done" is labelled 10. Further, there are inputs b and f, which represent whether the battery is present and whether it is full, respectively. There are also outputs c, which represents charging and is only high at state "chrg", and d, which represents whether the charging is done and is only high at state "done".

"Wait" is the starting state, and the FSM can only move to "chrg" from here if b is 1 and f is 0. This is denoted by drawing an arrow from the "wait" state to the "chrg" state with bf' drawn above it. Alternatively, the FSM remains at "wait" if b is low or f is high. This is denoted by a circular arrow starting and ending at "wait" with b'+ f written above it. From "chrg", there are three paths. b' returns to "wait", bf' loops back to "chrg", and bf moves to "done". From here, bf' goes to "chrg", bf loops back to "done", and b' returns to "wait". 

## Truth Table
| P2 | P1 | b | f | n2 | n1 | c | d |
| -- | -- | - | - | -- | -- | - | - |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 1 | 1 | 1 | 0 | 1 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 | 0 | 1 | 0 | 1 |
| 1 | 0 | 1 | 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 1 | 1 | 0 | 1 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |

## State Diagram and Circuit
Below is the state diagram, truth table, and circuit schematics

![alt text](FSM_Circuit.jpg)

![alt text](FSM_SD_TT.jpg)

[ fill in vivado design here]

## Coding the FSM

## Constraints

## Testing

## Problems and Headaches

## What Did I learn?