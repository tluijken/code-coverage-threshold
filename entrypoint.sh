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
    case "$line" in
        LF:*) 
            # Extract and sum total lines
            total_lines=$((total_lines + ${line#*:}))
            ;;
        LH:*) 
            # Extract and sum hit lines
            hit_lines=$((hit_lines + ${line#*:}))
            ;;
    esac
done < "$COVERAGE_FILE"

# Compute coverage percentage
coverage_percentage=$(awk "BEGIN {printf \"%f\", ($hit_lines/$total_lines)*100}")

echo "Total Lines: $total_lines"
echo "Hit Lines: $hit_lines"
echo "Coverage: $coverage_percentage%"

# Check if coverage meets the minimum requirement
if [ "$(echo "$coverage_percentage >= $MINIMUM_COVERAGE" | bc)" -eq 1 ]; then
    echo "Code coverage requirement met."
    exit 0
else
    echo "Code coverage below minimum. Required: $MINIMUM_COVERAGE%, Found: $coverage_percentage%"
    exit 1
fi
