# Create simulation library
vlib work
vmap work work

# Compile the Verilog source
vlog part2.sv

# Load the mux2to1 design
vsim mux2to1

# Add all signals to the waveform
add wave -r *

# Test case 1: s=0, x=0, y=0 => m=0
force s 0
force x 0
force y 0
run 10

# Test case 2: s=0, x=1, y=0 => m=x=1
force s 0
force x 1
force y 0
run 10

# Test case 3: s=1, x=0, y=1 => m=y=1
force s 1
force x 0
force y 1
run 10

# Test case 4: s=1, x=1, y=0 => m=y=0
force s 1
force x 1
force y 0
run 10

# Zoom and finish
wave zoom full
