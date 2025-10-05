# --- compilation
vlib work
vcom -93 -work work NBITADDER.vhd 
vsim NBITADDER 
# --- simulation
# view signal wave forms
view wave 			     
# number format is hex
radix hex  			    

# show input signals
add wave -divider -height 32 Inputs
add wave -height 30 -radix default A
add wave -height 30 -radix default B
add wave -height 30 -radix default C_IN

# show internal signals
add wave -divider -height 32 Internal
add wave -height 30 -radix default C_TMP

# show output signals
add wave -divider -height 32 Outputs
add wave -height 30 -radix default S

# generate input stimuli
# use hexadecimal notation to assign values to bit_vectors
# force SIG 00 0ns, FF 100ns, 3A 150ns etc.
force A     
force B  
force C_IN 
run
