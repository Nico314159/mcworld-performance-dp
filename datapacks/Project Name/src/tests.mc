dir a {
	function test {
		execute store result score $value value run random value 0..<%config.itemCount - 1%>
		!IF(config.usingTree) {
			function tests:a/test/0_<%config.itemCount - 1%>
		}
		!IF(!config.usingTree) {
			LOOP(config.iterator, i) {
				execute if score $value value matches <%i%> run function tests:a/test/<%i%>
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
					execute as Nico314 store result score $out value run data get storage test:input array[<%i%>] 1
				}
			}
		}
	}

	function setup {
		<%%
			let array = [];
			for (let i = 0; i < 100; i++) {
				array.push(Math.floor(Math.random() * 100));
			}
			emit(`data merge storage test:input {array: [${array}]}`)
		%%>
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
			$execute as @s store result score $out value run data get storage test:input array[$(value)] 1
		}
	}

	function setup {
		<%%
			let array = [];
			for (let i = 0; i < 100; i++) {
				array.push(Math.floor(Math.random() * 100));
			}
			emit(`data merge storage test:input {array: [${array}]}`)
		%%>
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Algorithm: ","color":"aqua"}, {"text":"Macro Insertion","color":"green"}]
		tellraw @a [{"text":"|◘ ","color":"dark_gray"}, {"text":"Number of Items: ","color":"aqua"}, {"text":"<%config.itemCount%>","color":"aqua"}]
	}

	function cleanup {
	}
}