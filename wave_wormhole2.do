onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench_wormhole/resetn
add wave -noupdate -format Logic /testbench_wormhole/clk
add wave -noupdate -format Literal /testbench_wormhole/pkt
add wave -noupdate -format Literal /testbench_wormhole/pkt2
add wave -noupdate -format Literal /testbench_wormhole/flit
add wave -noupdate -format Logic /testbench_wormhole/done
add wave -noupdate -format Logic /testbench_wormhole/done2
add wave -noupdate -format Logic /testbench_wormhole/ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 108
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ns} {200 ns}
