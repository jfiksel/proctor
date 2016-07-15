run_tests = function(test_envs) {
    failures = print_test_results(test_envs)
    print_failures(failures)
}

print_test_results= function(test_envs) {
    failures = new.env()
    for (env in ls(test_envs, all.names=TRUE)) {
        for (test in ls(test_envs[[env]])) {
            tryCatch({
                test_envs[[env]][[test]]()
                cat('.')
            }, 'condition' = function(error) {
                failures[[paste(env, test, sep='::')]] = c(get('message', error))
                cat('F')
            })
        }
    }
    return(failures)
}

print_failures = function(failures) {
    cat('\nFailures:\n')
    for (failure in ls(failures, all.names=TRUE)) {
        cat(paste(failure, failures[[failure]], '\n'))
    }
}

get_all_tests = function(files) {
    test_envs = new.env()
    for (file in files) {
        test_envs[[file]] = get_tests_from_file(file)
    }
    return(test_envs)
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

    remove(list=setdiff(all_names, function_names), pos=env)
    return(env)
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

