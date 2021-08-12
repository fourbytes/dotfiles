#!/usr/local/bin/fish

set CRATE $argv[1]
set LINKER $argv[2]

set RUSTC_ARGS "-Ztime-passes"

if test -n "$LINKER"
	set RUSTC_ARGS $RUSTC_ARGS "-Clink-arg=-fuse-ld=$LINKER"
end

set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "testing linker" | string pad -w15)
set_color normal; echo " $LINKER"
set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "rustc flags" | string pad -w15)
set_color normal; echo " $RUSTC_ARGS"
echo
echo -n "> "
for i in (seq 0 15)
	touch src/main.rs
	set result $result (cargo rustc --bin $CRATE -- \
		$RUSTC_ARGS \
		2>| rg run_linker \
		| string split -n \t \
		| string split -n ' ')[2]
	
	echo -n "$result[-1] "
end
echo
echo
set total 0
for i in $result
	set total (math $total + $i)
end
set average (math $total / (count $result))
set_color -o; set_color red; echo -n "# "; echo -ne (echo "average" | string pad -w15)
set_color normal; echo " $average secs"
