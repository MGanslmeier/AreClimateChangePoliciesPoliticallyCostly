clear all
set varabbrev off

*set working directory
cd "/Users/michaelganslmeier/Dropbox/CCP2/11sub/6_EE/REPLICATION"

*load dataset
use "data/FINAL.dta",replace

*run scripts
do "code/1clean.do"
do "code/2setup.do"
do "code/3manuscript.do"
do "code/4appendix.do"
do "code/5appendix_IV_interactions.do"
