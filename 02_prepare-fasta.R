library(Biostrings)

# read inputs
crap <- readAAStringSet("fasta/cRAP.fasta")
myco <- readAAStringSet(list.files(path = "fasta", pattern = "_m", full.names = TRUE))
hs <- readAAStringSet(list.files(path = "fasta", pattern = "_hsapiens", full.names = TRUE))

# append CONTAMINANTS to cRAP
names(crap) <- sapply(names(crap), function(x) paste0(x, "_CONTAMINANT"))

# check for Mycoplasma duplicates
if (any(Biostrings::duplicated(myco))) {
  message("Duplicated sequences removed from Myco_tagged.fasta")
  myco <- myco[!Biostrings::duplicated(myco)]
}

# append MYCOPLASMA_CONTAMINANTS to myco
names(crap) <- sapply(names(crap), function(x) paste0(x, "MYCOPLASMA_CONTAMINANT"))

# merge all fastas
combined <- c(hs, crap, myco)

# check for duplicates
if (any(Biostrings::duplicated(combined))) {
  message("Duplicated sequences removed from combined.fasta")
  combined <- combined[!Biostrings::duplicated(combined)]
}

# write outputs
Biostrings::writeXStringSet(crap, "fasta/cRAP_tagged.fasta")
Biostrings::writeXStringSet(myco, "fasta/Myco_tagged.fasta")
Biostrings::writeXStringSet(combined, "fasta/combined.fasta")
