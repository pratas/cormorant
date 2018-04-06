#!/bin/bash
#
# =================================================== #
#                                                     #
#          WARING: Run ONLY AFTER filter!             #
#                                                     #
# =================================================== #
#
GET_GOOSE=1;
GET_GECO=1;
PARSE_V1=1;
PARSE_V2=1;
PARSE_V3=1;
PARSE_V4=1;
COMPRESS_V1=1;
COMPRESS_V2=1;
COMPRESS_V3=1;
COMPRESS_V4=1;
COMPRESS_SELF_V1=1;
COMPRESS_SELF_V2=1;
COMPRESS_SELF_V3=1;
COMPRESS_SELF_V4=1;
PLOT=1;
#
#==============================================================================
# GET GOOSE
if [[ "$GET_GOOSE" -eq "1" ]]; then
  rm -fr goose/ goose-*
  git clone https://github.com/pratas/goose.git
  cd goose/src/
  make
  cd ../../
  cp goose/src/goose-* .
  cp goose/scripts/*.sh .
fi
#==============================================================================
# GET FALCON
if [[ "$GET_GECO" -eq "1" ]]; then
  git clone https://github.com/pratas/geco.git
  cd geco/src/
  cmake .
  make
  cp GeCo ../../
  cd ../../
fi
#==============================================================================
###############################################################################
#==============================================================================
# PARSE
if [[ "$PARSE_V1" -eq "1" ]]; then
  cat DV1.fq \
  | ./goose-FastqMinimumLocalQualityScoreForward -k 5 -w 15 -m 33 \
  | ./goose-FastqMinimumReadSize 35 \
  | ./goose-FastqExcludeN 5 \
  | ./goose-FastqMinimumQualityScore 15 \
  > FDV1.fq
fi
#==============================================================================
# PARSE
if [[ "$PARSE_V2" -eq "1" ]]; then
  cat DV2.fq \
  | ./goose-FastqMinimumLocalQualityScoreForward -k 5 -w 15 -m 33 \
  | ./goose-FastqMinimumReadSize 35 \
  | ./goose-FastqExcludeN 5 \
  | ./goose-FastqMinimumQualityScore 15 \
  > FDV2.fq
fi
#==============================================================================
# PARSE
if [[ "$PARSE_V3" -eq "1" ]]; then
  cat DV3.fq \
  | ./goose-FastqMinimumLocalQualityScoreForward -k 5 -w 15 -m 33 \
  | ./goose-FastqMinimumReadSize 35 \
  | ./goose-FastqExcludeN 5 \
  | ./goose-FastqMinimumQualityScore 15 \
  > FDV3.fq
fi
#==============================================================================
# PARSE
if [[ "$PARSE_V4" -eq "1" ]]; then
  cat DV4.fq \
  | ./goose-FastqMinimumLocalQualityScoreForward -k 5 -w 15 -m 33 \
  | ./goose-FastqMinimumReadSize 35 \
  | ./goose-FastqExcludeN 5 \
  | ./goose-FastqMinimumQualityScore 15 \
  > FDV4.fq
fi
#==============================================================================
###############################################################################
#==============================================================================
# COMPRESS
if [[ "$COMPRESS_V1" -eq "1" ]]; then
  (time ./GeCo -v -e -rm 6:1:0:0/0 -rm 13:10:0:0/0 -rm 14:50:0:3/1 -rm 20:100:1:5/10 -c 150 -r FDV1.fq V1.fa ) &> REPORT-FDV1 ;
fi
#==============================================================================
# COMPRESS
if [[ "$COMPRESS_V2" -eq "1" ]]; then
  (time ./GeCo -v -e -rm 6:1:0:0/0 -rm 13:10:0:0/0 -rm 14:50:0:3/1 -rm 20:100:1:5/10 -c 150 -r FDV2.fq V2.fa ) &> REPORT-FDV2 ;
fi
#==============================================================================
# COMPRESS
if [[ "$COMPRESS_V3" -eq "1" ]]; then
  (time ./GeCo -v -e -rm 6:1:0:0/0 -rm 13:10:0:0/0 -rm 14:50:0:3/1 -rm 20:100:1:5/10 -c 150 -r FDV3.fq V3.fa ) &> REPORT-FDV3 ;
fi
#==============================================================================
# COMPRESS
if [[ "$COMPRESS_V4" -eq "1" ]]; then
  (time ./GeCo -v -e -rm 6:1:0:0/0 -rm 13:10:0:0/0 -rm 14:50:0:3/1 -rm 20:100:1:5/10 -c 150 -r FDV4.fq V4.fa ) &> REPORT-FDV4 ;
fi
#==============================================================================
###############################################################################
#==============================================================================
# COMPRESS SELF
if [[ "$COMPRESS_SELF_V1" -eq "1" ]]; then
  cp V1.fa V1-SELF.fa
  (time ./GeCo -v -e -tm 4:1:0:0/0 -tm 8:1:0:0/0 -tm 13:10:1:1/1 -tm 16:50:1:3/1 -c 10 V1-SELF.fa ) &> REPORT-SELF-FDV1 ;
fi
#==============================================================================
# COMPRESS SELF
if [[ "$COMPRESS_SELF_V2" -eq "1" ]]; then
  cp V2.fa V2-SELF.fa
  (time ./GeCo -v -e -tm 4:1:0:0/0 -tm 8:1:0:0/0 -tm 13:10:1:1/1 -tm 16:50:1:3/1 -c 10 V2-SELF.fa ) &> REPORT-SELF-FDV2 ;
fi
#==============================================================================
# COMPRESS SELF
if [[ "$COMPRESS_SELF_V3" -eq "1" ]]; then
  cp V3.fa V3-SELF.fa
  (time ./GeCo -v -e -tm 4:1:0:0/0 -tm 8:1:0:0/0 -tm 13:10:1:1/1 -tm 16:50:1:3/1 -c 10 V3-SELF.fa ) &> REPORT-SELF-FDV3 ;
fi
#==============================================================================
# COMPRESS SELF
if [[ "$COMPRESS_SELF_V4" -eq "1" ]]; then
  cp V4.fa V4-SELF.fa
  (time ./GeCo -v -e -tm 4:1:0:0/0 -tm 8:1:0:0/0 -tm 13:10:1:1/1 -tm 16:50:1:3/1 -c 10 V4-SELF.fa ) &> REPORT-SELF-FDV4 ;
fi
#==============================================================================
###############################################################################
#==============================================================================
# PLOT
if [[ "$PLOT" -eq "1" ]]; then
  #
  #
  ./goose-UpperBound 2.0 < V1.fa.iae > V1.fa.upper
  ./goose-UpperBound 2.0 < V2.fa.iae > V2.fa.upper
  ./goose-UpperBound 2.0 < V3.fa.iae > V3.fa.upper
  ./goose-UpperBound 2.0 < V4.fa.iae > V4.fa.upper
  #
  ./goose-UpperBound 2.0 < V1-SELF.fa.iae > V1-SELF.fa.upper
  ./goose-UpperBound 2.0 < V2-SELF.fa.iae > V2-SELF.fa.upper
  ./goose-UpperBound 2.0 < V3-SELF.fa.iae > V3-SELF.fa.upper
  ./goose-UpperBound 2.0 < V4-SELF.fa.iae > V4-SELF.fa.upper
  #
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V1.fa.upper > V1.fa.fil
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V2.fa.upper > V2.fa.fil
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V3.fa.upper > V3.fa.fil
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V4.fa.upper > V4.fa.fil
  #
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V1-SELF.fa.upper > V1-SELF.fa.fil
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V2-SELF.fa.upper > V2-SELF.fa.fil
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V3-SELF.fa.upper > V3-SELF.fa.fil
  ./goose-filter -w 11 -d 2 -wt 2 -1 < V4-SELF.fa.upper > V4-SELF.fa.fil
  #
  #
gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V1.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V1.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V2.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V2.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V3.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V3.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V4.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V4.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

# SELF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V1_self.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V1-SELF.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V2_self.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V2-SELF.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V3_self.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V3-SELF.fa.fil" u 1:2 w l ls 2 title "normal"
EOF
      
gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_V4_self.pdf"
  set auto
  set size ratio 0.08
  set key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "V4-SELF.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

fi
#==============================================================================
