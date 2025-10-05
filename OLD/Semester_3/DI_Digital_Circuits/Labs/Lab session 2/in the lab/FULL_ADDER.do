# compile project FULL_ADDER
vlib work
vcom -93 -work work FULL_ADDER.vhd

# simulate FULL_ADDER
vsim FULL_ADDER
view wave
radix hex 

# display input waves
add wave -divider -height 32 Inputs
add wave -height 32 -radix default A
add wave -height 32 -radix default B
add wave -height 32 -radix default CIN
# display output waves
add wave -divider -height 32 Outputs
add wave -height 32 -radix default S
add wave -height 32 -radix default COUT

# generate input stimuli + start sim for 500ns
force A   0 0ns, 1 50ns   -r 100ns
force B   0 0ns, 1 100ns  -r 200ns
force CIN 0 0ns, 1 200ns  -r 400ns
run 500ns

# possible syntax for vectors
# force INP(0) 0 10ns, ...
# force INP(1) 0 20ns, ...
# or
# force INP 2C 10ns, AF 20ns, ...
