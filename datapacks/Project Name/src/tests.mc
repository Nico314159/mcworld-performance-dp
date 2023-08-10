dir a {
	function test {
		execute store result score #value v run random value 0..<%config.itemCount - 1%>
		!IF(config.usingTree) {
			function tests:a/test/0_<%config.itemCount - 1%>
		}
		!IF(!config.usingTree) {
			LOOP(config.iterator, i) {
				execute if score #value v matches <%i%> run return run function tests:a/test/<%i%>
			}
		}
	}

	dir test {
		!IF(config.usingTree) {
			LOOP(config.functions, func) {
				function <%func.id%> {
					<%%
						emit(func.content.join('\n'))
					%%>
				}
			}
		}
		!IF(!config.usingTree) {
			LOOP(config.iterator, i) {
				function <%i%> {
					scoreboard players set #out v <%i%>
				}
			}
		}
	}

	function setup {
		!IF(config.usingTree) {
			tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Algorithm: ","color":"aqua"}, {"text":"Logarithmic Search","color":"yellow"}]
		}
		!IF(!config.usingTree) {
			tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Algorithm: ","color":"aqua"}, {"text":"Linear Search","color":"red"}]	
		}
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Number of Items: ","color":"aqua"}, {"text":"<%config.itemCount%>","color":"aqua"}]
	}
	function cleanup {
	}
}

dir b {

	function test {
		execute store result storage test:input value int 1 run random value 0..<%config.itemCount - 1%>
		function tests:b/test/choose with storage test:input
	}

	dir test {
		function choose {
			$function tests:b/test/$(value)
		}
		LOOP(config.iterator, i) {
			function <%i%> {
				scoreboard players set #out v <%i%>
			}
		}
	}

	function setup {
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Algorithm: ","color":"aqua"}, {"text":"Macro Insertion","color":"green"}]
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Number of Items: ","color":"aqua"}, {"text":"<%config.itemCount%>","color":"aqua"}]
	}

	function cleanup {
	}
}