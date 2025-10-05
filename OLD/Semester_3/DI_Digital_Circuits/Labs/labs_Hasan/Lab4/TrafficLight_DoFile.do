# compile project TrafficLight
vlib work
vcom -93 -work work TrafficLight.vhd 
# simulate TrafficLight
vsim TrafficLight  
view wave 			     
radix hex  			    

# show input signals
add wave -divider -height 32 Inputs
add wave -height 30 -radix default CLK
add wave -height 30 -radix default D_N
add wave -height 30 -radix default RESETN

# display output waves
add wave -divider -height 32 Outputs
add wave -height 32 -radix default MR_A
add wave -height 32 -radix default MR_P
add wave -height 32 -radix default SR_A
add wave -height 32 -radix default SR_P



# generate input stimuli + start sim for 500ns
#force ARESETN   0 0ns, 1 50ns   -r 100ns
#force CLK 0 0ns, 1 50ns   -r 100ns
#force CNTEN  0 0ns, 1 50ns  -r 200ns
#force DIR 0 0ns, 1 50ns  -r 150ns
#run 500ns

force RESETN  0 0ns, 1 100ns, 0 200ns, 1 300ns, 0 400ns, 1 500ns
force CLK 1 0ns, 0 50ns, 1 150ns, 0 250ns, 1 350ns, 0 450ns   
force D_N  1 0ns, 0 100ns, 1 250ns, 0 350ns, 1 490ns
run 500ns






# show internal signals
#add wave -divider -height 32 Internal

# show output signals
#add wave -divider -height 32 Outputs
#add wave -height 30 -radix default S

# generate input stimuli
