# Instruction Set Architecture (ISA)\

[Reference](http://labs.domipheus.com/blog/designing-a-cpu-in-vhdl-part-3-instruction-set-decoder-ram/)

The ISA has the following properties

- There are 14 instructions.
- Instructions are 16-bit.
- Opcodes are 4-bit.
- Immediate values are 8-bit.
- The Load instruction takes a 4-bit opcode, 3-bit destination register address and an 8-bit immediate value. This adds up to 4 + 3 + 8 = 15 bits, leaving 1 spare bit. This bit will be used to indicate whether we want to store the input in the high or low 8-bit part of the 16-bit destination register.

## Table of instructions

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

## Opcode Layout

| Form 	| Overview             	| Example Instruction       	|
|------	|----------------------	|---------------------------	|
| RRR  	| OpCode rD, rA, rB    	| Add                       	|
| RRd  	| OpCode rD, rA        	| Not                       	|
| RRs  	| OpCode rA, rB        	| Memory Write              	|
| R    	| OpCode rA            	| Branch to Register Value  	|
| RImm 	| OpCode rD, Immediate 	| Load                      	|
| Imm  	| OpCode Immediate     	| Branch to Immediate Value 	|

## Bit-layout

| Form 	| 15     	| 14     	| 13     	| 12     	| 11     	| 10     	| 9      	| 8 	| 7                     	| 6                     	| 5                     	| 4                     	| 3                     	| 2                     	| 1                     	| 0                     	|
|------	|--------	|--------	|--------	|--------	|--------	|--------	|--------	|---	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|-----------------------	|
| RRR  	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| rA                    	| rA                    	| rA                    	| rB                    	| rB                    	| rB                    	| Unused                	| Unused                	|
| RRs  	| opcode 	| opcode 	| opcode 	| opcode 	| Unused 	| Unused 	| Unused 	| F 	| rA                    	| rA                    	| rA                    	| rB                    	| rB                    	| rB                    	| Unused                	| Unused                	|
| RRd  	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| rA                    	| rA                    	| rA                    	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	|
| R    	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	| Unused                	|
| Rimm 	| opcode 	| opcode 	| opcode 	| opcode 	| rD     	| rD     	| rD     	| F 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	|
| Imm  	| opcode 	| opcode 	| opcode 	| opcode 	| Unused 	| Unused 	| Unused 	| F 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	| 8-bit Immediate Value 	|
