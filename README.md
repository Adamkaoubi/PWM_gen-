Variable PWM (VHDL)

A simple and clean VHDL PWM generator with an adjustable duty cycle.
Works on Quartus, ModelSim, and any FPGA supporting VHDL.

📁 Project Files
Variable_PWM.vhd        → Main PWM module
Variable_PWM_tb.vhd     → Testbench for simulation
README.md               → Documentation (this file)

🚀 Overview

This design generates a PWM signal using:

8-bit Duty Cycle input

Internal counter 0 → 99

PWM comparison logic

Synchronous reset-free design

This module is ideal for:

LED dimming

Motor control

Simple DSP-based PWM

Introductory FPGA projects

🔧 Entity Description
Variable_PWM Ports
Signal Name	Dir	Type	Description
Dutycycle	in	std_logic_vector(7 downto 0)	0–99 recommended
clk	in	std_logic	System clock
counter	out	std_logic_vector(7 downto 0)	Shows internal counter
pwmout	out	std_logic	PWM output
🧠 How It Works
1️⃣ Counter (0 → 99)

On each rising edge of the clock:

if counter_reg < 99 then
    counter_reg <= counter_reg + 1;
else
    counter_reg <= (others => '0');
end if;

2️⃣ PWM Logic

PWM is HIGH when the counter is below the duty cycle OR at the last count:

if counter_reg < unsigned(Dutycycle) then
    pwm_reg <= '1';
elsif counter_reg = 99 then
    pwm_reg <= '1';
else
    pwm_reg <= '0';
end if;

📊 Duty Cycle Example
Dutycycle Value	PWM Ratio	Behavior
0	0%	Always LOW
50	50%	Half period ON
99	≈100%	Always HIGH
>99	Saturates	Treated as MAX duty
▶️ ModelSim Simulation Guide
Step 1 — Create library
vlib work
vmap work work

Step 2 — Compile VHDL
vcom Variable_PWM.vhd
vcom Variable_PWM_tb.vhd

Step 3 — Run simulation
vsim work.Variable_PWM_tb
add wave *
run 200 us

🛠️ Quartus Usage

Create a new Quartus project

Add Variable_PWM.vhd

Set top-level entity to:

Variable_PWM


Assign pwmout to an FPGA pin

Compile

Program your board ✔

🎨 Waveform Visualization (ASCII)
Dutycycle = 40

counter   : 000000000000000000000000000000001...................
pwmout    : ████████████████████_______________________________
             <--- 40 HIGH ---> <---------- 60 LOW ----------->

📌 Notes

Dutycycle is 8-bit but only 0–99 is used.

For full 8-bit PWM resolution, ask me — I can modify the design.

For FPGA, you may need a clock divider depending on your board clock.
