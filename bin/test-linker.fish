#!/usr/local/bin/fish

set LINKER $argv[1]

set -x RUSTFLAGS "-Ztime-passes"

if test -n "$LINKER"
	set -x RUSTFLAGS $RUSTFLAGS "-Clink-arg=-fuse-ld=$LINKER"
end
set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "crate: " | string pad -w16)
set_color normal; echo (pwd | string split '/')[-1]
set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "rustc version: " | string pad -w16)
set_color normal; echo (rustc -V)
set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "rustc target: " | string pad -w16)
set_color normal; echo (rustc -vV | grep host | string split -n ' ')[2]
set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "testing linker: " | string pad -w16)
set_color normal; echo "$LINKER"
set_color -o; set_color cyan; echo -n "# "; echo -ne (echo "rustc flags: " | string pad -w16)
set_color normal; echo "$RUSTFLAGS"
echo
for i in (seq 0 10)
	# touch src/main.rs
	set total 0
	set_color -d; echo -n "pass $i => "; set_color normal
	cargo clean
	cargo build 2>&1 | rg run_linker | while read -L line
		set time (echo $line \
			| string split -n \t \
			| string split -n ' ')[2]
		set total (math $total + $time)
	end
	echo -n "$total secs total"
	if test $i -eq 0
		echo " (skipped)"
	else 
		set -g result $result $total
		echo
	end
end
set total 0
for i in $result
	set total (math $total + $i)
end
set average (math $total / (count $result))
set_color -o; set_color red; echo -ne (echo "average => " | string pad -w16)
set_color normal; echo "$average secs"
echo
echo "---"
