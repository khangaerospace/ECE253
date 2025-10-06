# =========================================================
# part2_test.do - Simulation for part2 ALU
# =========================================================

# 1️⃣ Delete old work library if it exists
if { [file exists work] } {
    vdel -lib work -all
}

# 2️⃣ Create a new work library
vlib work

# 3️⃣ Map it (important for Intel FPGA Edition)
vmap work work

# 4️⃣ Compile your SystemVerilog file
vlog -sv part2.sv

# 5️⃣ Load simulation
vsim work.part2

# 6️⃣ Add all signals
add wave -r /*

# Example forces
force -freeze sim:/part2/A 4'b0101
force -freeze sim:/part2/B 4'b0011
force -freeze sim:/part2/Function 2'b00
run 10ns

wave zoom full

