#!/bin/bash

url='ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/RELEASE.metalink'

# extract name of current UniProt release
RELEASE=$(curl --silent ${url} | grep -Eo '[0-9]{4}_[0-9]{2}')
echo Current UniProt Release = ${RELEASE}

# download Homo sapiens reference proteome (SwissProt only)
hs_query='http://www.uniprot.org/uniprot/?query=taxonomy:9606+keyword:1185+reviewed:yes&format=fasta'
mkdir fasta
wget -nv ${hs_query} -O "fasta/${RELEASE}_hsapiens.fasta"
