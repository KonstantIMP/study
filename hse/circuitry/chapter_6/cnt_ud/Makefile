all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace \
		counter.v ../adder.v ../d_flip_flop.v ../register.v ../mux.v ../substractor.v testbench.cpp  \
		-o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
