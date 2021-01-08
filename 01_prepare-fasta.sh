#!/bin/bash

url='ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/RELEASE.metalink'

# extract name of current UniProt release
RELEASE=$(curl --silent ${url} | grep -Eo '[0-9]{4}_[0-9]{2}')
echo Current UniProt Release = ${RELEASE}

# download Homo sapiens reference proteome (SwissProt only)
mkdir fasta
hs_query='http://www.uniprot.org/uniprot/?query=taxonomy:9606+keyword:1185+reviewed:yes&format=fasta'
wget -nv ${hs_query} -O "fasta/${RELEASE}_hsapiens.fasta"

# download GPM cRAP fasta specific to this Galaxy tutorial

# download several Mycoplasma proteomes and combine them
mo_query='http://www.uniprot.org/uniprot/?query=taxonomy:2121+keyword:1185&format=fasta'
wget -nv ${mo_query} -O "fasta/${RELEASE}_morale.fasta"

mhy_query='http://www.uniprot.org/uniprot/?query=taxonomy:1118964+keyword:1185&format=fasta'
wget -nv ${mhy_query} -O "fasta/${RELEASE}_mhyorhinis.fasta"

mho_query='http://www.uniprot.org/uniprot/?query=taxonomy:347256+keyword:1185&format=fasta'
wget -nv ${mho_query} -O "fasta/${RELEASE}_mhominis.fasta"

mf_query='http://www.uniprot.org/uniprot/?query=taxonomy:496833&format=fasta'
wget -nv ${mf_query} -O "fasta/${RELEASE}_mfermentans.fasta"

ma_query='http://www.uniprot.org/uniprot/?query=taxonomy:2094+proteome:up000057258&format=fasta'
wget -nv ${ma_query} -O "fasta/${RELEASE}_marginini.fasta"

al_query='http://www.uniprot.org/uniprot/?query=taxonomy:441768+keyword:1185&format=fasta'
wget -nv ${al_query} -O "fasta/${RELEASE}_alaidlawii.fasta"
