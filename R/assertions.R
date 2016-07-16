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

stub = function(func, to_stub, return_value) {
    original_func = get(func, envir=parent.frame(), mode='function')
    env = environment(original_func)
    assign(to_stub, function(...) return(return_value), env)

    function_text = _get_function_text(original_func)
    new_function = eval(parse(text=function_text), env)
    assign(func, new_function, parent.frame())
}

_get_function_text = function(func) {
    functiin_output = capture.output(print(func))
    function_vector = head(function_output, -1)  # drop environment from output
    function_text = paste(function_vector, set='', collapse='')
    return(function_text)
}

