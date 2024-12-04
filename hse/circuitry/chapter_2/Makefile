all: rs_latch_testbench d_latch_testbench d_flip_flop_testbench jk_flip_flop_testbench

rs_latch_testbench:
	iverilog -s rs_latch_testbench -o rs_latch_testbench rs_latch.v rs_latch_testbench.v

d_latch_testbench:
	iverilog -s d_latch_testbench -o d_latch_testbench rs_latch.v d_latch.v d_latch_testbench.v

d_flip_flop_testbench:
	iverilog -s d_flip_flop_testbench -o d_flip_flop_testbench \
		rs_latch.v d_latch.v d_flip_flop.v d_flip_flop_testbench.v

jk_flip_flop_testbench:
	iverilog -s jk_flip_flop_testbench -o jk_flip_flop_testbench \
		jk_flip_flop.v jk_flip_flop_testbench.v

clean:
	rm -rf dump.vcd rs_latch_testbench d_latch_testbench d_flip_flop_testbench jk_flip_flop_testbench
