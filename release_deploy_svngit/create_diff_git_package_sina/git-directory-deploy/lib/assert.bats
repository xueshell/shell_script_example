#!/usr/bin/env bats

load assert

@test 'assert asserts equality' {
	assert that 1 = 1
}
@test '       asserts equality with spaces' {
	assert that 'a b' = a b
}
@test '       asserts output content' {
	run echo abc
	assert that output contains b
}
@test '       refutes output content' {
	run echo abc
	assert that output does not contain d
}
