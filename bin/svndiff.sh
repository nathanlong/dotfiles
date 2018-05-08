#!/bin/sh

# Configure your favorite diff program here.
DIFF="nvim -d"

# Subversion provides the paths we need as the sixth and seventh
# parameters.
LEFT=${6}
RIGHT=${7}

# Call the diff command
$DIFF $LEFT $RIGHT
