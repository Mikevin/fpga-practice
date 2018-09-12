# Registers

The registers are defined by the following properties

- The CPU will use 8 registers with 16-bit values.
- To select a register we use a 3-bit value
- We have a bit to enable writing to the registers
- Has a clock input
- Has an enable bit

The module is called reg16_8

We can select two outputs to using I_selA and I_selB. The values will appear at O_dataA and O_dataB respectively.

We can select which register to write to using I_selD. This will store I_dataD at the selected address.