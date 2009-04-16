onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench_ni/resetn
add wave -noupdate -format Logic /testbench_ni/clk
add wave -noupdate -divider <NULL>
add wave -noupdate -format Literal /testbench_ni/odata
add wave -noupdate -format Logic /testbench_ni/av_in
add wave -noupdate -divider <NULL>
add wave -noupdate -format Literal -expand /testbench_ni/net_out
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
WaveRestoreZoom {0 ps} {239205 ps}
