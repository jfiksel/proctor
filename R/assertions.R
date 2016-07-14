assert_equal = function(actual, expected) {
    if (actual != expected) {
        message = paste('Expected', actual, 'to equal', expected)
        stop(message)
    }
}

assert_true = function(expr) {
    if (!expr) {
        message = paste('Expected', expr, 'to be true')
        stop(message)
    }
}

