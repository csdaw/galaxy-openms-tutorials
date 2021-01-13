# peptide FDR filtering
# 1) annotate PSMs to see which are decoys
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 PeptideIndexer \
-in data/search/qExactive01819.idXML \
-fasta data/fasta/combined_TD.fasta \
-out data/search/qExactive01819_annot.idXML \
-write_protein_sequence \
-write_protein_description \
-enzyme:specificity 'none'

# 2) calculate PEP (required for Fido)
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 IDPosteriorErrorProbability \
-in data/search/qExactive01819_annot.idXML \
-out data/search/qExactive01819_pep.idXML \
-prob_correct

# 3) filter PSMs for 1% FDR
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 FalseDiscoveryRate \
-in data/search/qExactive01819_pep.idXML \
-out data/search/qExactive01819_filt.idXML \
-PSM 'true' \
-FDR:PSM '0.01' \
-protein 'false' \
-algorithm:add_decoy_peptides

# check what the exact name of the PEP UserParam is
# grep "AGM(Oxidation)THIVR" search/qExactive01819_pep.idxml -A 20
# grep "AGM(Oxidation)THIVR" search/qExactive01819_filt.idxml -A 20

# 4) set score back to PEP
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 IDScoreSwitcher \
-in data/search/qExactive01819_filt.idXML \
-out data/search/qExactive01819_final.idXML \
-new_score 'Posterior Probability_score' \
-new_score_orientation 'higher_better'

# check out our final file
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 FileInfo \
-in data/search/qExactive01819_final.idXML

# docker run -v ${PWD}:/data/ quay.io/biocontainers/openms:2.6.0--h4afb90d_0 IDScoreSwitcher --helphelp
