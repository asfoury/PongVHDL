vsim -t ps -gINIT="000000001" movement
add wave *
force -freeze sim:/movement/clock 1 0, 0 {50 ps} -r 100
force reset 1
force dir 1
force enable 1
run
run
force reset 0
run
run
run
run
run
run
run
run
run
force dir 0
run
run
run
run
run
run
run
run
run
force dir 1
run
force enable 0
run
run
run
run
force enable 1
run
force enable 0
run
run
