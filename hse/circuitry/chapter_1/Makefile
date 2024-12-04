all: testbench

testbench:
	iverilog -o testbench -s testbench lab_1.v testbench.v

run_testbench: testbench
	./testbench

clean:
	rm dump.vcd testbench
