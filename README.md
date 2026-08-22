# low-power-weighted-fir-filter
Design and Analysis of Low-Power and High-Speed Weighted FIR Filter using Feed# Design and Analysis of Low-Power and High-Speed Weighted FIR Filter

[![Verilog HDL](https://github.com/srivatsadg-afk/low-power-weighted-fir-filter)](https://github.com/srivatsadg-afk/low-power-weighted-fir-filter)
[![License: MIT](https://github.com/srivatsadg-afk/low-power-weighted-fir-filter)](https://github.com/srivatsadg-afk/low-power-weighted-fir-filter)
[![Field: Digital VLSI](https://github.com/srivatsadg-afk/low-power-weighted-fir-filter)](https://github.com/srivatsadg-afk/low-power-weighted-fir-filter)

## 📌 Overview
This repository contains the Verilog HDL implementation and verification environment for a **Low-Power, High-Speed Weighted Finite Impulse Response (FIR) Filter**. The design leverages **Feed-forward Cutset Retiming** and pipelined arithmetic architectures to break long critical path delays across multiplier-accumulator chains, achieving higher operational clock frequencies and reduced dynamic switching activity.

---

## 🏗 Architecture & Retiming Analysis

### 1. Mathematical Formulation
An $N$-tap FIR filter calculates the output sequence $y[n]$ as:
$$y[n] = \sum_{k=0}^{N-1} h[k] \cdot x[n-k]$$

For this 4-tap weighted filter implementation:
* $h[0] = 0.1 \approx \text{16'sh0CCD}$
* $h[1] = 0.2 \approx \text{16'sh199A}$
* $h[2] = 0.3 \approx \text{16'sh2666}$
* $h[3] = 0.4 \approx \text{16'sh3333}$
* ### 2. Critical Path Optimization (Cutset Retiming)
* **Direct-Form FIR:** Critical path involves $T_{\text{mult}} + (N-1) \cdot T_{\text{add}}$, which limits the maximum clock frequency $F_{\text{max}}$.
* **Retimed Architecture:** Registers are redistributed across the feed-forward cutsets, isolating the multipliers from the adder tree. This bounds the critical path to:
*   $$T_{\text{crit}} = \max(T_{\text{mult}}, T_{\text{add\_stage}})$$
*
*   ```
    x_in ───► [x_reg0] ───► [x_reg1] ───► [x_reg2]
    │          │            │            │
    (x) H0     (x) H1       (x) H2       (x) H3
    │          │            │            │
    [m0_reg]   [m1_reg]     [m2_reg]     [m3_reg]
    └───(+)────┘            └───(+)────┘
    │                       │
    [add_stage1_reg]        [add_stage2_reg]
    └──────────(+)──────────┘
    │
    y_out
    ```

  ---

  ## 📁 Repository Structure

  ```
  low-power-weighted-fir-filter/
  ├── rtl/
  │   └── fir_filter_retimed.v     # Retimed 4-tap FIR filter RTL module
  ├── sim/
  │   └── tb_fir_filter.v          # Testbench with impulse and step stimuli
  ├── docs/                        # Architecture diagrams and timing waveforms
  ├── .gitignore
  ├── LICENSE                      # MIT License
  └── README.md                    # Project documentation
  ```

  ---

  ## ⚙ Hardware Specifications

  | Parameter | Value | Description |
  | :--- | :--- | :--- |
  | **Input Word Length (`DATA_WIDTH`)** | 16-bit | Signed fixed-point input sample |
  | **Coefficient Word Length (`COEFF_WIDTH`)** | 16-bit | Signed fixed-point tap weights |
  | **Output Word Length** | 33-bit | Full-precision accumulator output |
  | **Filter Order / Taps** | 4-Tap | Weighted filter configuration |
  | **Pipeline Latency** | 3 Cycles | Multiplier + 2 Adder stages |

  ---

  ## 🚀 Simulation & Verification

  ### Using Icarus Verilog & GTKWave

      1. **Compile RTL and Testbench:**
      2.    ```bash
           iverilog -o sim/fir_sim rtl/fir_filter_retimed.v sim/tb_fir_filter.v
           ```

       2. **Run Simulation:**
       3.    ```bash
            vvp sim/fir_sim
             ```

        3. **View Waveforms:**
           ```bash
            gtkwave sim/fir_wave.vcd
            ```

### Using Xilinx Vivado / ModelSim
* Create a new project targeting your FPGA board (e.g., Artix-7 / Spartan-7).
* Add `rtl/fir_filter_retimed.v` as Design Source.
* Add `sim/tb_fir_filter.v` as Simulation Source.
* Run Behavioral Simulation and Synthesis to inspect Timing Reports and Power Utilization.
---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.) filter utilizing feed-forward cutset retiming.

## Project Description

FIR filters are critical components in digital signal processing (DSP) applications. However, they can be highly power-consuming and speed-limited when implemented with traditional architectures due to long critical paths in multiplication and addition stages.

This design implements a **weighted FIR filter** that leverages **Feed-forward Cutset Retiming**. By strategically inserting pipeline registers (pipeline retiming) into the data path, the critical path delay is significantly minimized, enabling:
- **High-Speed Operation:** Higher clock frequencies by shortening the critical path.
- **Low-Power Consumption:** Reduced glitching activity and lowered power metrics through pipelined stages.
- ## Repository Structure
- **`rtl/fir_filter_retimed.v`**: The main Verilog module implementing the 4-tap weighted FIR filter with feed-forward cutset retiming.
- **`sim/tb_fir_filter.v`**: Testbench for simulating the FIR filter design, verifying impulse and step response behavior.
- ## Implementation Details
  
- ### Parameters:
- `DATA_WIDTH`: 16 bits (default)
- `COEFF_WIDTH`: 16 bits (default)
- `TAPS`: 4
           
- ### Coefficients (Weighted Taps):
- $H_0 = 0.1$ (`16'sh0CCD`)
- $H_1 = 0.2$ (`16'sh199A`)
- $H_2 = 0.3$ (`16'sh2666`)
- $H_3 = 0.4$ (`16'sh3333`)
                   
- ## Verification & Simulation
                   
- The testbench (`sim/tb_fir_filter.v`) simulates:
- 1. **Impulse Test:** Applying an impulse signal (`16'sh7FFF`) to observe the impulse response.
2. 2. **Step Input Test:** Applying a step input (`16'sh1000`) to observe the filter step response settling.
