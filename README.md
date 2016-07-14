# proctor
unit testing in R

### Installation
Start R with `sudo R`
```.R
# If you don't have devtools installed yet:
install.packages('devtools')

# Then:
library('devtools')
devtools::install_github('n-s-f/proctor')
```

### Running Tests
```.bash
# Run all tests in current directory including subdirectories
proctor

# Run all tests in some_directory including subdirectories
proctor some_directory
```

Proctor finds any files that match `test\w*.R$`, and then runs any functions in those files that match `^test|test$`.

**NOTE**: There are a few sample tests in `tests/` which can be run as described above.

### Writing Tests
An proctor test might look like:
```.R
test_addition = function() {
  sum = 1 + 1
  proctor::assert_equal(sum, 3)
}
```

### TODO
- Fixtures (setup, teardown, etc)
- Additional assertions
- Mocking
- Statistical tests
