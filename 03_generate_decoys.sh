#!/bin/bash

# docker pull quay.io/biocontainers/openms:2.6.0--h4afb90d_0
docker run -v ${PWD}/fasta:/fasta/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 DecoyDatabase -in fasta/combined.fasta -out fasta/combined_TD.fasta
