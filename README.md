# Code Coverage Threshold for GitHub Actions

This project introduces a GitHub Action designed to enforce a code coverage
threshold without requiring outdated NodeJS versions.

## Project Rationale
The motivation behind this project stems from the observation that existing code
coverage threshold tools were reliant on NodeJS versions 12 or 16, both of which
have been deprecated by GitHub. This reliance led to frequent warnings and a
need for a more current solution. In response, I developed a workflow that
evaluates the overall code coverage using an LCOV file. It determines success or
failure based on whether the specified coverage threshold is met.

## Implementation Guide
To integrate this code coverage threshold check into your GitHub Actions
workflow, incorporate the following snippet:

```yaml
      - name: Check test coverage
        uses: tluijken/code-coverage-threshold@v1
        with:
          coverage-file: coverage/tests.lcov
          minimum-coverage: 90
```

### Configuration Parameters
The action can be customized using the following parameters:

| Parameter         | Description                                                       |
|-------------------|-------------------------------------------------------------------|
| `coverage-file`   | Specifies the LCOV file to be analyzed for code coverage metrics. |
| `minimum-coverage`| Defines the minimum percentage of code coverage required for the workflow to pass. |
