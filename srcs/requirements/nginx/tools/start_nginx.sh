#!/bin/bash

echo "Nginx started."

# The '$@' is the CMD in the Dockerfile.
exec "$@"
