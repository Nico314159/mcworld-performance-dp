# BEFORE MAKING YOUR TEST, Please create a fork, and a branch on that fork called `test-<your-test-comparison>`.
# For example: `test-entity-relation-vs-macros`
# This way I can easily merge it into the main repo, and it will be easy to find and swap out for other users.

function settings {
	# How many ticks to run the tests for. Higher values provide more accurate data, but take longer. (Default: 1200)
	# At 1200 (about 60 seconds per test at 50ms/t) there is a +-0.1% margin of error.
	# At 20 (about a second per test at 50ms/t) there is a +-3.00% margin of error.
	scoreboard players set .tick_count v 1000
	# Maximum time to use per tick (Default/Max 50).
	scoreboard players set .max_ms_per_tick v 20
	# The name of the first test. This is used to identify the test in the results.
	data modify storage perf_tool:ram test_a_name set value '{"text": "My Test A"}'
	# The name of the second test. This is used to identify the test in the results.
	data modify storage perf_tool:ram test_b_name set value '{"text": "My Test B"}'
}

dir a {
	function test {
		scoreboard players add __math__.N value 1
		# tellraw @s [{"text":"Input: ","color":"aqua"},{"score":{"name":"__math__.N","objective":"value"},"color":"red"}]
		function tests:a/test/main 
		# tellraw @s [{"text":"Output: ","color":"aqua"},{"score":{"name":"__math__.x_n","objective":"value"},"color":"red"}]
	}

	dir test {
		function main {
			scoreboard players set __math__.x_n value 1225
			function tests:a/test/newton_raphson
			scoreboard players operation __main__.x_n_sq value = __math__.x_n value
			scoreboard players operation __main__.x_n_sq value *= __math__.x_n value
			execute if score __main__.x_n_sq value > __math__.N value run scoreboard players remove __math__.x_n value 1
			scoreboard players add __math__.times_called value 1
		}
		function newton_raphson {
			scoreboard players operation __math__.x value = __math__.x_n value
			scoreboard players operation __math__.x_n value = __math__.N value
			scoreboard players operation __math__.x_n value /= __math__.x value
			scoreboard players operation __math__.x_n value += __math__.x value
			scoreboard players operation __math__.x_n value /= 2 value
			scoreboard players operation __math__.different value = __math__.x value
			scoreboard players operation __math__.different value -= __math__.x_n value
			execute unless score __math__.different value matches 0..1 run scoreboard players add __math__.total_iterations value 1
			execute unless score __math__.different value matches 0..1 run function tests:a/test/newton_raphson
		}
	}

	function setup {
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Algorithm: ","color":"aqua"}, {"text":"Newton-Raphson","color":"yellow"}]
		scoreboard players set 2 value 2
		scoreboard players set __math__.total_iterations value 0
		scoreboard players set __math__.times_called value 0
		scoreboard players set __math__.N value 0
	}
	function cleanup {
		scoreboard players operation __math__.average_iterations value = __math__.total_iterations value
		scoreboard players operation __math__.average_iterations value /= __math__.times_called value
		tellraw @a [{"text":"Average Iterations: ","color":"gold"},{"score":{"name":"__math__.average_iterations","objective":"value"},"color":"red"}]
	}
}

dir b {
	function test {
		scoreboard players add $input value 1
		# Initialize output
		scoreboard players set $output value 0

		# Run iterations
		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 32768
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 32768

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 16384
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 16384

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 8192
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 8192

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 4096
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 4096

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 2048
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 2048

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 1024
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 1024

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 512
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 512

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 256
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 256

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 128
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 128

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 64
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 64

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 32
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 32

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 16
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 16

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 8
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 8

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 4
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 4

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 2
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 2

		scoreboard players operation $math_root value = $output value
		scoreboard players add $math_root value 1
		scoreboard players operation $math_root value *= $math_root value
		execute if score $math_root value <= $input value run scoreboard players add $output value 1
	}

	dir test {
	}

	function setup {
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Algorithm: ","color":"aqua"}, {"text":"Binary Decomposition","color":"yellow"}]
		scoreboard players reset * value
		scoreboard players set $input value 0
	}

	function cleanup {
	}
}