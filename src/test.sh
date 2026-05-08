#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_binary>"
    exit 1
fi

BINARY="$1"

if [ ! -f "$BINARY" ]; then 
    echo "Error: Binary file '$BINARY' not found"
    exit 1
fi 

if [ ! -x "$BINARY" ]; then
    echo "Error: Binary file '$BINARY' is not executable"
    exit 1
fi

echo "=== Starting integration tests ==="

for i in {1..6}; do
    case $i in
        1) expected="Learning to Linux" ;;
        2) expected="Learning to work with Network" ;;
        3) expected="Learning to Monitoring" ;;
        4) expected="Learning to extra Monitoring" ;;
        5) expected="Learning to Docker" ;;
        6) expected="Learning to CI/CD" ;;
    esac
    
    result=$("$BINARY" "$i")
    
    if [ "$result" = "$expected" ]; then
        echo -e "Test $i: \033[32mSUCCESS\033[0m (got: '$result')"
    else 
        echo -e "Test $i: \033[31mFAILED\033[0m"
        echo "  Expected: '$expected'"
        echo "  Got: '$result'"
    fi
done

for i in {7..10}; do
    expected="Bad number!"
    result=$("$BINARY" "$i")
    
    if [ "$result" = "$expected" ]; then
        echo -e "Test $i: \033[32mSUCCESS\033[0m (got: '$result')"
    else
        echo -e "Test $i: \033[31mFAILED\033[0m"
        echo "  Expected: '$expected'"
        echo "  Got: '$result'"
    fi
done

echo "=== Integration tests completed ==="