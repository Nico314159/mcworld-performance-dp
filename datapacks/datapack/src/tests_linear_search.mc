function load {
	data merge storage profiler {output_a:[], output_b:[]}
}

dir a {
	function test {
		execute store result score #value v run random value 0..48
		LOOP(48, i) {
			execute if score #value v matches <%i%> run return run function tests:a/test/<%i%>
		}
	}

	dir test {
		LOOP(48, i) {
			function <%i%> {
				data modify storage profiler output_a append value <%i%>
			}
		}
	}

	function setup {
		data merge storage a:test {}
		summon marker ~ ~ ~ {UUID:[I;-1025266400,-941079146,-1920536813,-401552137]}
	}

	function cleanup {
		data remove storage a:test {}
		kill c2e3ad20-c7e8-4596-8d86-ef13e810ccf7
	}
}

dir b {

	function test {
		execute store result storage test:input #value int 1 run random value 0..48
		function tests:b/test/choose with storage test:input
	}

	dir test {
		function choose {
			$function tests:b/test/$(value)
		}
		LOOP(48, i) {
			function <%i%> {
				data modify storage profiler output_b append value <%i%>
			}
		}
	}

	function setup {
		data merge storage b:test {}
		summon marker ~ ~ ~ {UUID:[I;-1025266400,-941079146,-1920536813,-401552137]}
	}

	function cleanup {
		data remove storage b:test {}
		kill c2e3ad20-c7e8-4596-8d86-ef13e810ccf7
	}
}