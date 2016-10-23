test_pass = function() {
    proctor::assert_equal(1, 1)
}

test_failure = function() {
    proctor::assert_equal(200, 100)
}

