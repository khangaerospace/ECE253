vlib work
vlog part2.sv
vsim v7404

# Add signals to waveform
add wave -r *

# Apply test values to one inverter (pin1 -> pin2)
force pin1 0
run 10

force pin1 1
run 10

# Try another inverter in the same chip (pin3 -> pin4)
force pin3 0
run 10

force pin3 1
run 10

wave zoom full
