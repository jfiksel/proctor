test_pass = function() {
    proctor::assert_equal(1, 1)
}

test_failure = function() {
    proctor::assert_equal(200, 100)
}

test_stub = function() {
    f = function() 10
    g = function() f()
    proctor::stub('g', 'f', 20)
    proctor::assert_equal(g(), 20)
}
