#!/bin/bash
GET_KESTREL=1;
DW_VIRUSES=1;
RUN_KESTREL=1;
#==============================================================================
# GET KESTREL
if [[ "$GET_KESTREL" -eq "1" ]]; then
  rm -fr kestrel KESTREL
  git clone https://github.com/pratas/kestrel.git
  cd kestrel/src/
  cmake .
  make
  cp KESTREL ../../
  cd ../../
fi
#==============================================================================
# DOWNLAOD VIRUSES
if [[ "$DW_VIRUSES" -eq "1" ]]; then
  #https://www.ncbi.nlm.nih.gov/genome/genomes/10271?
  NPATH="ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000"
  wget $NPATH/845/085/GCF_000845085.1_ViralProj14518/GCF_000845085.1_ViralProj14518_genomic.fna.gz
  wget $NPATH/857/865/GCF_000857865.1_ViralProj15107/GCF_000857865.1_ViralProj15107_genomic.fna.gz
  wget $NPATH/858/645/GCF_000858645.1_ViralProj15113/GCF_000858645.1_ViralProj15113_genomic.fna.gz
  wget $NPATH/859/465/GCF_000859465.1_ViralProj15106/GCF_000859465.1_ViralProj15106_genomic.fna.gz
  zcat GCF_000845085.1_ViralProj14518_genomic.fna.gz > V1.fa
  zcat GCF_000857865.1_ViralProj15107_genomic.fna.gz > V2.fa
  zcat GCF_000858645.1_ViralProj15113_genomic.fna.gz > V3.fa
  zcat GCF_000859465.1_ViralProj15106_genomic.fna.gz > V4.fa
fi
#==============================================================================
# RUN KESTREL
if [[ "$RUN_KESTREL" -eq "1" ]]; then
  ./KESTREL -v -l 36 -t 0.5 -n 10 -o DV1.fq V1.fa ~/DATABASE/DENISOVA/DENI
  ./KESTREL -v -l 36 -t 0.5 -n 10 -o DV2.fq V2.fa ~/DATABASE/DENISOVA/DENI
  ./KESTREL -v -l 36 -t 0.5 -n 10 -o DV3.fq V3.fa ~/DATABASE/DENISOVA/DENI
  ./KESTREL -v -l 36 -t 0.5 -n 10 -o DV4.fq V4.fa ~/DATABASE/DENISOVA/DENI
fi
#==============================================================================

