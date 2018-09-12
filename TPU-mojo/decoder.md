# Decoder

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

## Opcodes

| OpCode | Operation | Form   | WritesRegister? | Comments                                                   |
| ------ | --------- | ------ | --------------- | ---------------------------------------------------------- |
| 0000   | ADD       | RRR    | Yes             |                                                            |
| 0001   | SUB       | RRR    | Yes             |                                                            |
| 0010   | OR        | RRR    | Yes             |                                                            |
| 0011   | XOR       | RRR    | Yes             |                                                            |
| 0100   | AND       | RRR    | Yes             |                                                            |
| 0101   | NOT       | RRd    | Yes             |                                                            |
| 0110   | READ      | RRd    | Yes             |                                                            |
| 0111   | WRITE     | RRs    | No              |                                                            |
| 1000   | LOAD      | RImm   | Yes             | Flag bit indicates high or low load                        |
| 1001   | CMP       | RRR    | Yes             | Flag bit indicates comparison signedness                   |
| 1010   | SHL       | RRR    | Yes             |                                                            |
| 1011   | SHR       | RRR    | Yes             |                                                            |
| 1100   | JUMP      | R, Imm | No              | Flag bit indicates a jump to register or jump to immediate |
| 1101   | JUMPEQ    | RRs    | No              |                                                            |
| 1110   | RESERVED  | –      | –               |                                                            |
| 1111   | RESERVED  | –      | –               |                                                            |