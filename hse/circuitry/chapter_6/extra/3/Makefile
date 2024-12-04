all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace \
		task3.v ../../led7.v ../../cnt_load/counter.v ../../mux.v ../../adder.v ../../register.v ../../d_flip_flop.v testbench.cpp  \
		-o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
