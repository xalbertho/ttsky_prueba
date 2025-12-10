## How it works

This design implements an 8-bit counter with carry using the Tiny Tapeout interface.

- The top module is `tt_um_sumador`.
- The internal module `sumador` is an 8-bit counter with a carry output.
- `ui_in[0]` is used as the enable signal for the counter.
- `uo_out[7:0]` shows the current 8-bit count value.
- `uio_out[7]` outputs the carry (`cout`) when the counter overflows from `0xFF` to `0x00`.
- The remaining `uio_out[6:0]` bits are kept at 0 and are not used.
- `rst_n` is an active-low reset: when it is 0, the counter goes back to 0 and the carry is cleared.

When `ena` is high and `rst_n` is released, each clock cycle will increment the counter if `ui_in[0]` is set to 1.

## How to test

### Simulation (RTL)

1. Make sure you have the Tiny Tapeout test dependencies installed (cocotb, icarus, etc.).
2. From the project root, go to the test directory:

   ```bash
   cd test
