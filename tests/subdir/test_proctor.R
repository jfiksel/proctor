test_failure = function() {
    proctor::assert_equal(1, 2)
}

should_not_run = function() {
    stop('This function should not be run!')
}
