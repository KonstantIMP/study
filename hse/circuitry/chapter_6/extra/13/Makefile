all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace \
		task13.v t_flip_flop.v shift_directional_register.v testbench.cpp  \
		-o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
