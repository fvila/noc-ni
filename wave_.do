onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench_ni/resetn
add wave -noupdate -format Logic /testbench_ni/clk
add wave -noupdate -format Literal /testbench_ni/slave_in
add wave -noupdate -format Literal /testbench_ni/slave_out
add wave -noupdate -format Logic /testbench_ni/ack
add wave -noupdate -format Logic /testbench_ni/i1/slv0/hready
add wave -noupdate -format Literal /testbench_ni/i1/slv0/curr_state
add wave -noupdate -format Literal /testbench_ni/i1/slv0/next_state
add wave -noupdate -format Logic /testbench_ni/i1/cnt0/inc
add wave -noupdate -format Literal -radix decimal /testbench_ni/i1/cnt0/value
add wave -noupdate -format Logic /testbench_ni/i1/slv0/start_flit
add wave -noupdate -format Logic /testbench_ni/i1/whs0/done
add wave -noupdate -format Literal -radix hexadecimal /testbench_ni/i1/whs0/flit_out
add wave -noupdate -format Logic /testbench_ni/i1/whs0/ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42062 ps} 0}
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
WaveRestoreZoom {0 ps} {349883 ps}
