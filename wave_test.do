onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/d3/ni0/resetn
add wave -noupdate -format Logic /testbench/d3/ni0/clk
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ni0/slave_in.haddr
add wave -noupdate -format Logic /testbench/d3/ni0/net_out.rcon
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ni0/net_out.packet_out
add wave -noupdate -format Literal /testbench/d3/ni0/slv0/curr_state
add wave -noupdate -format Literal /testbench/d3/ni0/slv0/next_state
add wave -noupdate -format Logic /testbench/d3/ni0/slv0/hsel
add wave -noupdate -format Logic /testbench/d3/ni0/slv0/inc
add wave -noupdate -format Logic /testbench/d3/ni0/slv0/start_flit
add wave -noupdate -format Literal /testbench/d3/ni0/whs0/pkt
add wave -noupdate -format Literal /testbench/d3/ni0/whs0/flit_out
add wave -noupdate -format Literal /testbench/d3/ni0/whs0/fstart
add wave -noupdate -format Literal /testbench/d3/ni0/whs0/fend
add wave -noupdate -format Logic /testbench/d3/ni0/net_in.rok
add wave -noupdate -format Logic /testbench/d3/ni0/ack
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {1402081 ps}

force -drive sim:/testbench/d3/ni0/net_in.rok 1 0
force -drive sim:/testbench/d3/ni0/ack 1 355000ns
force -drive sim:/testbench/d3/ni0/ack 0 355050ns
