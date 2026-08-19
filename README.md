# low-power-weighted-fir-filter
Design and Analysis of Low-Power and High-Speed Weighted FIR Filter using Feed-forward Cutset Retiming in Verilog HDL
# Design and Analysis of Low-Power and High-Speed Weighted FIR Filter using Feed-forward Cutset Retiming

This repository contains the Verilog HDL implementation and testbench for a high-performance, low-power, and high-speed weighted Finite Impulse Response (FIR) filter utilizing feed-forward cutset retiming.

## Project Description

FIR filters are critical components in digital signal processing (DSP) applications. However, they can be highly power-consuming and speed-limited when implemented with traditional architectures due to long critical paths in multiplication and addition stages.

This design implements a **weighted FIR filter** that leverages **Feed-forward Cutset Retiming**. By strategically inserting pipeline registers (pipeline retiming) into the data path, the critical path delay is significantly minimized, enabling:
- **High-Speed Operation:** Higher clock frequencies by shortening the critical path.
- - **Low-Power Consumption:** Reduced glitching activity and lowered power metrics through pipelined stages.
 
  - ## Repository Structure
 
  - - **`rtl/fir_filter_retimed.v`**: The main Verilog module implementing the 4-tap weighted FIR filter with feed-forward cutset retiming.
    - - **`sim/tb_fir_filter.v`**: Testbench for simulating the FIR filter design, verifying impulse and step response behavior.
     
      - ## Implementation Details
     
      - ### Parameters:
      - - `DATA_WIDTH`: 16 bits (default)
        - - `COEFF_WIDTH`: 16 bits (default)
          - - `TAPS`: 4
           
            - ### Coefficients (Weighted Taps):
            - - $H_0 = 0.1$ (`16'sh0CCD`)
              - - $H_1 = 0.2$ (`16'sh199A`)
                - - $H_2 = 0.3$ (`16'sh2666`)
                  - - $H_3 = 0.4$ (`16'sh3333`)
                   
                    - ## Verification & Simulation
                   
                    - The testbench (`sim/tb_fir_filter.v`) simulates:
                    - 1. **Impulse Test:** Applying an impulse signal (`16'sh7FFF`) to observe the impulse response.
                      2. 2. **Step Input Test:** Applying a step input (`16'sh1000`) to observe the filter step response settling.
