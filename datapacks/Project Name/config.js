const crypto = require('crypto')

const treeBranches = 8;
const itemCount = 5;
const usingTree = false; 
	// false = test A uses linear search, true = test A uses log search. test B is always macros

function generateSearchTree(items, trimmer) {
	const depth = () => Math.floor(Math.log(items.length) / Math.log(treeBranches))
	const remainingItems = [...items]
	let scoreIndex = 0
	function recurse(myDepth = 0) {
		const minScoreIndex = scoreIndex
		let maxScoreIndex = null
		const tree = []
		for (let i = 0; i < treeBranches; i++) {
			if (remainingItems.length === 0) break
			if (myDepth < depth() && remainingItems.length >= treeBranches - i) {
				const item = recurse(myDepth + 1)
				if (trimmer && item) {
					if (trimmer(item)) tree.push(item)
				} else if (item) tree.push(item)
			} else {
				const item = {
					type: 'leaf',
					item: remainingItems.shift(),
					scoreIndex: scoreIndex,
				}
				if (trimmer && item) {
					if (trimmer(item)) tree.push(item)
				} else if (item) tree.push(item)
				scoreIndex++
			}
		}
		maxScoreIndex = scoreIndex - 1
		if (tree.length === 1) {
			if (trimmer && !trimmer(tree[0])) return
			return tree[0]
		}
		return { minScoreIndex, maxScoreIndex, items: tree, type: 'branch' }
	}
	return recurse()
}
let list = []
for (let i = 0; i < itemCount; i++) {
	list.push(i)
}
const tree = generateSearchTree(list)

const functions = []
function recurse(branch) {
	switch (branch.type) {
		case 'leaf':
			functions.push({
				id: branch.scoreIndex,
				content: [`execute as @p store result score $out value run data get storage test:input array[${branch.item}]`],
			})
			break
		case 'branch':
			const content = []
			for (const item of branch.items) {
				recurse(item)
				if (item.type === 'leaf') {
					content.push(
						`execute if score $value value matches ${item.scoreIndex} run function tests:a/test/${item.scoreIndex}`
					)
				} else {
					content.push(
						`execute if score $value value matches ${item.minScoreIndex}..${item.maxScoreIndex} run function tests:a/test/${item.minScoreIndex}_${item.maxScoreIndex}`
					)
				}
			}
			functions.push({ id: `${branch.minScoreIndex}_${branch.maxScoreIndex}`, content })
			break
	}
}

recurse(tree)
// console.log(functions)

module.exports = {
	global: {
		onBuildSuccess: null,
	},
	mc: {
		dev: true,
		header: '# Developed by SnaveSutit\n# built using mc-build (https://github.com/mc-build/mc-build)',
		internalScoreboard: 'i',
		generatedDirectory: 'zzz',
		rootNamespace: null,
		treeBranches: treeBranches,
		functions: functions,
		itemCount: itemCount,
		usingTree: usingTree,
		iterator: [...Array(itemCount).keys()]
	},
}