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