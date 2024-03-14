#!/bin/sh
COVERAGE_FILE=$1
MINIMUM_COVERAGE=$2

echo "Coverage file: $COVERAGE_FILE"
echo "Minimum coverage: $MINIMUM_COVERAGE"

# Ensure the file exists
if [ ! -f "$COVERAGE_FILE" ]; then
    echo "The file $COVERAGE_FILE does not exist."
    exit 1
fi

# Initialize counters
total_lines=0
hit_lines=0

# Process each line containing "LF:" (Lines Found) and "LH:" (Lines Hit)
while IFS= read -r line; do
    if [[ $line == LF:* ]]; then
        # Extract and sum total lines
        total_lines=$((total_lines + ${line#*:}))
    elif [[ $line == LH:* ]]; then
        # Extract and sum hit lines
        hit_lines=$((hit_lines + ${line#*:}))
    fi
done < "$COVERAGE_FILE"

# Calculate coverage percentage
if [ "$total_lines" -gt 0 ]; then
    coverage=$(echo "scale=2; $hit_lines * 100 / $total_lines" | bc)
    if [ $(echo "$coverage < $MINIMUM_COVERAGE" | bc) -eq 1 ]; then
        echo "Coverage is below the minimum threshold of $MINIMUM_COVERAGE%"
        exit 1
    fi
    echo "Total Line Coverage: $coverage%"
    exit 0
else
    echo "No coverage data found."
    exit 1
fi
