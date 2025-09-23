# Create and map work library
vlib work
vmap work work

# Compile the mux7to1 design
vlog part3.sv

# Load mux7to1 directly into simulator
vsim work.mux7to1

# Add all signals to waveform viewer
add wave -r *

# Drive inputs manually
force MuxIn 7'b1010101
force MuxSelect 3'b000
run 10ns

force MuxSelect 3'b001
run 10ns

force MuxSelect 3'b010
run 10ns

force MuxSelect 3'b011
run 10ns

force MuxSelect 3'b100
run 10ns

force MuxSelect 3'b101
run 10ns

force MuxSelect 3'b110
run 10ns

force MuxSelect 3'b111
run 10ns

# Zoom to see all activity
wave zoom full
