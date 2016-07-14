run_tests = function(tests) {
    failures = c()
    for (test in tests) {
        tryCatch({
            test()
            print('.')
        }, 'condition' = function(error) {
            failures <<- append(failures, c(get('message', error)))
            print('F')
        })
    }

    print('Failures:')
    for (failure in failures) {
        print(failure)
    }
}

get_all_tests = function(files) {
    all_tests = c()
    for (file in files) {
        tests = get_tests_from_file(file)
        all_tests = append(all_tests, tests)
    }
    return(all_tests)
}

get_tests_from_file = function(file) {
    env = new.env()
    source(file, env)
    return(get_tests_from_env(env))
}

get_tests_from_env = function(env) {
    all_names = ls(env)

    pattern = '^test|test$'
    test_names = all_names[grep(pattern, all_names)]

    is_function = function(name) mode(get(name, env)) == 'function'
    function_names = Filter(is_function, test_names)

    test_functions = mget(function_names, env)
    return(test_functions)
}

get_test_files = function(path) {
    pattern = 'test\\w*.R$'
    files = list.files(path, pattern=pattern, recursive=TRUE, full.names=TRUE)
    return(files)
}

get_path = function() {
    args = commandArgs(trailingOnly=TRUE)
    if (length(args) > 0) {
        return(args[1])
    }
    return('.')
}

test = function() {
    path = get_path()
    files = get_test_files(path)
    tests = get_all_tests(files)
    run_tests(tests)
}

