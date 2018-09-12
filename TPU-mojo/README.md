# TPU-mojo

## Structure

Based on the Mojo V3 template.

## Modules

## Naming

Naming uses the following rules/guidelines

- Prepend **I_** for inputs
- Prepend **O_** for outputs
- Selector is shortened to **sel**
- Clock is referred to as **clk**
- Enable is shortened to **en**
- Write Enable is shortened to **we**

### Registers

The registers are defined by the following properties

- The CPU will use 8 registers with 16-bit values.
- To select a register we use a 3-bit value
- We have a bit to enable writing to the registers
- Has a clock input
- Has an enable bit

The module is called reg16_8

We can select two outputs to using I_selA and I_selB. The values will appear at O_dataA and O_dataB respectively.

We can select which register to write to using I_selD. This will store I_dataD at the selected address.

### Instruction Set Architecture (ISA)\

[Reference](http://labs.domipheus.com/blog/designing-a-cpu-in-vhdl-part-3-instruction-set-decoder-ram/)

The ISA has the following properties

- There are 14 instructions.
- Instructions are 16-bit.
- Opcodes are 4-bit.
- Immediate values are 8-bit.
- The Load instruction takes a 4-bit opcode, 3-bit destination register address and an 8-bit immediate value. This adds up to 4 + 3 + 8 = 15 bits, leaving 1 spare bit. This bit will be used to indicate whether we want to store the input in the high or low 8-bit part of the 16-bit destination register.



Table of instructions

| Operation                 | Function                              |
|---------------------------|---------------------------------------|
| Add                       | D = A + B                             |
| Subtract                  | D = A – B                             |
| Bitwise Or                | D = A or B                            |
| Bitwise Xor               | D = A xor B                           |
| Bitwise And               | D = A and B                           |
| Bitwise Not               | D = not A                             |
| Read                      | D = Memory[A]                         |
| Write                     | Memory[A] = B                         |
| Load                      | D = 8-bit Immediate Value             |
| Compare                   | D = cmp(A, B)                         |
| Shift Left                | D = A << B                            |
| Shift Right               | D = A >> B                            |
| Jump/Branch               | PC = A Register or Immediate Value    |
| Jump/Branch conditionally | PC = Register if (condition) else nop |

Opcode Layout

| Form 	| Overview             	| Example Instruction       	|
|------	|----------------------	|---------------------------	|
| RRR  	| OpCode rD, rA, rB    	| Add                       	|
| RRd  	| OpCode rD, rA        	| Not                       	|
| RRs  	| OpCode rA, rB        	| Memory Write              	|
| R    	| OpCode rA            	| Branch to Register Value  	|
| RImm 	| OpCode rD, Immediate 	| Load                      	|
| Imm  	| OpCode Immediate     	| Branch to Immediate Value 	|

Bit-layout

| Form 	| 15     	| 14     	| 13     	| 12     	| 11     	| 10     	| 9      	| 8 	| 7                     	| 6                     	| 5                     	| 4                     	| 3                     	| 2                     	| 1                     	| 0                     	|
|------	|--------	|--------	|--------	|--------	|--------	|--------	|--------	|---	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|
| RRR  	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| rA                    	| rA                    	| rA                    	| rB                    	| rB                    	| rB                    	| Unused                	| Unused                	|
| RRs  	| opcode 	| opcode 	| opcode 	| opcode 	| Unused 	| Unused 	| Unused 	| F 	| rA                    	| rA                    	| rA                    	| rB                    	| rB                    	| rB                    	| Unused                	| Unused                	|
| RRd  	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| rA                    	| rA                    	| rA                    	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	|
| R    	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	|
| Rimm 	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	|
| Imm  	| opcode 	| opcode 	| opcode 	| opcode 	| Unused 	| Unused 	| Unused 	| F 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	|

### Decoder

The Decoder has the following properties

It has the following inputs
- Clock
- Enable bit
- Instruction

And the following outputs
- ALU Operation
- Immediate
- Write enable
- rA select
- rB select
- rD select

Opcodes

| OpCode 	| Operation 	| Form   	| WritesRegister? 	| Comments                                                   	|
|--------	|-----------	|--------	|-----------------	|------------------------------------------------------------	|
| 0000   	| ADD       	| RRR    	| Yes             	|                                                            	|
| 0001   	| SUB       	| RRR    	| Yes             	|                                                            	|
| 0010   	| OR        	| RRR    	| Yes             	|                                                            	|
| 0011   	| XOR       	| RRR    	| Yes             	|                                                            	|
| 0100   	| AND       	| RRR    	| Yes             	|                                                            	|
| 0101   	| NOT       	| RRd    	| Yes             	|                                                            	|
| 0110   	| READ      	| RRd    	| Yes             	|                                                            	|
| 0111   	| WRITE     	| RRs    	| No              	|                                                            	|
| 1000   	| LOAD      	| RImm   	| Yes             	| Flag bit indicates high or low load                        	|
| 1001   	| CMP       	| RRR    	| Yes             	| Flag bit indicates comparison signedness                   	|
| 1010   	| SHL       	| RRR    	| Yes             	|                                                            	|
| 1011   	| SHR       	| RRR    	| Yes             	|                                                            	|
| 1100   	| JUMP      	| R, Imm 	| No              	| Flag bit indicates a jump to register or jump to immediate 	|
| 1101   	| JUMPEQ    	| RRs    	| No              	|                                                            	|
| 1110   	| RESERVED  	| –      	| –               	|                                                            	|
| 1111   	| RESERVED  	| –      	| –               	|                                                            	|

### Ram

The Ram has the following properties

- Similar to register module
- Has 32 addresses
- Every address points to a store of 16 bits
- Total size is 512 bits or 64 bytes

It has these inputs

- Clock
- Write enable
- Address
- Data

It has these outputs

- Data