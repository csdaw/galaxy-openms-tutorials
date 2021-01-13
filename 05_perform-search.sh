# perform peptide search with X!Tandem
# (need to use OpenMS container with third party software)
mkdir data-search
docker run -v ${PWD}:/data/ quay.io/biocontainers/openms-thirdparty:2.6.0--0 XTandemAdapter \
-in /data/raw/qExactive01819_centroid.mzML \
-out /data/search/qExactive01819.idXML \
-database /data/fasta/combined_TD.fasta \
-xtandem_executable /usr/local/bin/xtandem \
-fragment_mass_tolerance '10' \
-fragment_error_units 'ppm'