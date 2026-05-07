libname capstone "/home/u63898700";

proc import datafile="/home/u63898700/mis581/ef2016cp_rv.csv"
    out=capstone.efcp2016 dbms=csv replace;
run;

proc import datafile="/home/u63898700/mis581/ef2018cp_rv.csv"
    out=capstone.efcp2018 dbms=csv replace;
run;

proc import datafile="/home/u63898700/mis581/ef2020cp_rv.csv"
    out=capstone.efcp2020 dbms=csv replace;
run;

proc import datafile="/home/u63898700/mis581/ef2022cp_rv.csv"
    out=capstone.efcp2022 dbms=csv replace;
run;

proc import datafile="/home/u63898700/mis581/ef2024cp.csv"
    out=capstone.efcp2024 dbms=csv replace;
run;

data capstone.efcp2016_keep;
    set capstone.efcp2016;
    YEAR = 2016;
    keep UNITID CIPCODE SECTION LSTUDY EFTOTLT EFTOTLM EFTOTLW YEAR;
run;

data capstone.efcp2018_keep;
    set capstone.efcp2018;
    YEAR = 2018;
    keep UNITID CIPCODE SECTION LSTUDY EFTOTLT EFTOTLM EFTOTLW YEAR;
run;

data capstone.efcp2020_keep;
    set capstone.efcp2020;
    YEAR = 2020;
    keep UNITID CIPCODE SECTION LSTUDY EFTOTLT EFTOTLM EFTOTLW YEAR;
run;

data capstone.efcp2022_keep;
    set capstone.efcp2022;
    YEAR = 2022;
    keep UNITID CIPCODE SECTION LSTUDY EFTOTLT EFTOTLM EFTOTLW YEAR;
run;

data capstone.efcp2024_keep;
    set capstone.efcp2024;
    YEAR = 2024;
    keep UNITID CIPCODE SECTION LSTUDY EFTOTLT EFTOTLM EFTOTLW YEAR;
run;


data capstone.efcp_all;
    set capstone.efcp2016_keep
        capstone.efcp2018_keep
        capstone.efcp2020_keep
        capstone.efcp2022_keep
        capstone.efcp2024_keep;
run;

proc freq data=capstone.efcp_all;
    tables YEAR SECTION LSTUDY / missing;
run;

proc means data=capstone.efcp_all n nmiss min p25 median p75 max;
    var EFTOTLT EFTOTLM EFTOTLW;
run;