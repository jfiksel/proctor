run_tests = function(test_envs) {
    failures = print_test_results(test_envs)
    print_failures(failures)
}

print_test_results= function(test_envs) {
    failures = list()
    for (env_name in names(test_envs)) {
        env = get(env_name, test_envs)
        test_names = get_tests_names_from_env(env)

        for (test_name in test_names) {
            test = get(test_name, env)

            tryCatch({
                test()
                cat('.')
            }, 'condition' = function(error) {
                qualified_test_name = paste(env_name, test_name, sep='::')
                error_message = c(get('message', error))
                failures[[qualified_test_name]] <<- error_message
                cat('F')
            })
        }
    }
    return(failures)
}

print_failures = function(failures) {
    cat('\nFailures:\n')
    for (failure in names(failures)) {
        cat(paste(failure, failures[[failure]], '\n'))
    }
}

load_files = function(files) {
    test_envs = list()
    for (file in files) {
        test_envs[[file]] = get_tests_from_file(file)
    }
    return(test_envs)
}

get_tests_from_file = function(file) {
    env = new.env()
    source(file, env)
    return(env)
}

get_tests_names_from_env = function(env) {
    test_names = ls(env, pattern='^test|test$')
    is_function = function(name) mode(get(name, env)) == 'function'
    return(Filter(is_function, test_names))
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
    test_envs = load_files(files)
    run_tests(test_envs)
}

