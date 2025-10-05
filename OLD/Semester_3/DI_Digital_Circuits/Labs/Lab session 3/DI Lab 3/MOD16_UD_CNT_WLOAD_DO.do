vlib work
vcom -93 -work work MOD16_UD_CNT_WLOAD.vhd

# simulate MOD16_UD_CNT_WLOAD.vhd
vsim MOD16_UD_CNT_WLOAD
view wave
radix hex

# display input waves
add wave -divider -height 32 Inputs
add wave -height 32 -radix default TCEN
add wave -height 32 -radix default CNTEN
add wave -height 32 -radix default DIR
add wave -height 32 -radix default LOAD
add wave -height 32 -radix default PRE
add wave -height 32 -radix default ARESETN
add wave -height 32 -radix default CLK

# display output waves
add wave -divider -height 32 Outputs
add wave -height 32 -radix default TC
add wave -height 32 -radix default CNT

# generate input stimuli
# use hexadecimal notation to assign values to bit_vectors
# force SIG 00 0ns, FF 100ns, 3A 150ns -r 250ns
# ...
# run 1000ns
#==============================================================================
# TC output enable (0 - TC output, 1 - no TC output)
force TCEN 0 0ns, 1 110ns, 0 130ns
# count enable (0 - enable, 1 - disable)
force CNTEN 0 0ns, 1 240ns, 0 320ns
# count direction (1 - up, 0 - down)
force DIR 0 0ns, 1 80ns, 0 160ns, 1 240ns
# PRE loading enable (0 - no action, 1 - load PRE value to S_REG (current state))
force LOAD 0 0ns, 1 400ns, 0 430ns
# PRE value (4-bit unsigned)
force PRE 0 0ns, B 400ns
# reset (1 - no reset, 0 - reset)
force ARESETN 0 0ns, 1 5ns, 0 540ns, 1 545ns
# clock (rising edge triggered)
force CLK 0 0ns, 1 20ns -r 40ns

run 700ns
