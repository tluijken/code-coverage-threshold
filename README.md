# code-coverage-threshold
Code coverage threshold action for github actions, which doesn't rely on deprecated nodejs versions.

## Why this project?
I've seen many code coverage threshold, all depending on NodeJS 12, which has
been deprecated by GitHub. To get rid of warnings, I created this workflow,
which simply checks for the total code coverage, based on a LCOV file, and
passes of failed, based on whether the threshold has been surpassed.


## How to use
Simply add this to your GitHub workflow.
```yaml
      - name: Check test coverage
        uses: tluijken/cove-coverage-threshold@v1
        with:
          coverage-file: coverage/tests.lcov
          minimum-coverage: 90
```

### Parameters
| Name             | Description                                                        |
|------------------|--------------------------------------------------------------------|
| coverage-file    | The LCOV input file to process and check the threshold against.    |
| minimum-coverage | The minimum coverage threshold in order for this workflow to pass. |
