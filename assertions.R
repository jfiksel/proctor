assert_equals = function(actual, expected) {
    if (actual != expected) {
        message = paste('Expected', actual, 'to equal', expected)
        stop(message)
    }
}

