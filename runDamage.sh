#!/bin/bash
#
# wget https://github.com/ginolhac/mapDamage/archive/2.0.8.zip
# unzip 2.0.8.zip
# cp mapDamage-2.0.8/bin/mapDamage .
#
#
# rm -fr bwa/
# git clone https://github.com/lh3/bwa.git
# cd bwa/
# make
# cd ../
# cp bwa/bwa bwa-bin
# rm -fr bwa/
# mv bwa-bin bwa
#
#
# rm -f samtools-1.3.1.tar.bz2
# wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2
# tar -xvf samtools-1.3.1.tar.bz2
# cd samtools-1.3.1/
# ./configure --without-curses
# make
# cp samtools ../
# cd ..
# rm -fr samtools-1.3.1.*
#
#
rm -f *index*
echo "Creating index";
./bwa index V1.fa
echo "Running alignment";
./bwa mem -t 8 -I 0 -O 2 -N 0.02 -L 1024 -E 7 V1.fa FDV1.fq > Adeno.sam
echo "SAM->BAM"
./samtools view -Shb Adeno.sam > Adeno.bam
echo "Filtering only mapped reads"
./samtools view -b -F4 Adeno.bam > fil-Adeno.bam
./mapDamage -i fil-Adeno.bam -r V1.fa;
#
#
