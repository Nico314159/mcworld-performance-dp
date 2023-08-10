dir a {
	function test {
		execute store result score #value v run random value 0..49
		function tests:a/test/0_49
		# LOOP(50, i) {
		# 	execute if score #value v matches <%i%> run return run function tests:a/test/<%i%>
		# }
	}

	dir test {
		LOOP(config.functions, func) {
			function <%func.id%> {
				<%%
					emit(func.content.join('\n'))
				%%>
			}
		}
		# LOOP(50, i) {
		# 	function <%i%> {
		# 		scoreboard players set #out v <%i%>
		# 	}
		# }
	}

	function setup {
	}

	function cleanup {
	}
}

dir b {

	function test {
		execute store result storage test:input #value int 1 run random value 1..50
		function tests:b/test/choose with storage test:input
	}

	dir test {
		function choose {
			$function tests:b/test/$(value)
		}
		LOOP(50, i) {
			function <%i%> {
				scoreboard players set #out v <%i%>
			}
		}
	}

	function setup {
	}

	function cleanup {
	}
}