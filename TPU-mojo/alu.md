# Alu

We could do every operations and only output the requested result but we are using a case statement and an internal register to avoid this.

The Alu has the following properties

- Outputs in a single cycle

It has these inputs

- Clock
- Enable
- Data A
- Data B
- Data D Write-Enable
- ALU Operation
- Program Counter
- Immediate data

It has these outputs

- Data
- Output data register
- A bit indicating if we want to actually write the data
- A bit indicating if we should branch