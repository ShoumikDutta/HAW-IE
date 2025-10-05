# --- compilation
vlib work
vcom -93 -work work Traffic_light.vhd 
vsim Traffic_light
# --- simulation
# view signal wave forms
view wave 			     
# number format is hex
radix hex  			    

# show input signals
add wave -divider -height 32 Inputs
add wave -height 30 -radix default RESET
add wave -height 30 -radix default CLK
add wave -height 30 -radix default DN


# show output signals
add wave -divider -height 32 Outputs
add wave -height 30 -radix default MAIN(4)
add wave -height 30 -radix default MAIN(3)
add wave -height 30 -radix default MAIN(2)
add wave -height 30 -radix default MAIN(1)
add wave -height 30 -radix default MAIN(0)
add wave -height 30 -radix default SEC(4)
add wave -height 30 -radix default SEC(3)
add wave -height 30 -radix default SEC(2)
add wave -height 30 -radix default SEC(1)
add wave -height 30 -radix default SEC(0)

# generate input stimuli
# use hexadecimal notation to assign values to bit_vectors
# force SIG 00 0ns, FF 100ns, 3A 150ns etc.
force CLK 0 0ns, 1 25ns -r 50ns    
force RESET  0 0ns, 1 20ns
force DN 1 0ns
## 1670ns -r 1680ns

run 1500ns
