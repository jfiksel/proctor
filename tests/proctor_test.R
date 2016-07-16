test_pass = function() {
    proctor::assert_equal(1, 1)
}

test_failure = function() {
    proctor::assert_equal(200, 100)
}

a = 15
f = function() 10
g = function() f() + a
test_stub = function() {
    proctor::assert_equal(g(), 25)
    proctor::stub('g', 'f', 20)
    proctor::assert_equal(g(), 35)
}
