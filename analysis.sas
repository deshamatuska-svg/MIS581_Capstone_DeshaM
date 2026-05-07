proc contents data=capstone.efcp_focus;
run;

proc freq data=capstone.efcp_focus;
   tables CIPCODE YEAR LSTUDY SECTION;
run;

proc means data=capstone.efcp_focus n mean median min max;
   var EFTOTLT;
run;

proc glm data=capstone.efcp_focus plots(maxpoints=20000)=diagnostics;
   class CIPCODE;
   model EFTOTLT = CIPCODE;
   means CIPCODE / hovtest=levene;
run;
quit;

proc format;
   value cipcodefmt
      22.0101 = "Law"
      51.1201 = "Medicine"
      52 = "Business";
run;

proc sgplot data=capstone.efcp_focus;
   format CIPCODE cipcodefmt.;
   vbar CIPCODE / response=EFTOTLT stat=mean;
   yaxis label="Mean Fall Enrollment";
   xaxis label="Program Category";
   title "Mean Fall Enrollment by Program Category";
run;

data capstone.efcp_business;
   set capstone.efcp_focus;
   where CIPCODE in (52)
     and LSTUDY in (2, 12);
run;

proc glm data=capstone.efcp_business plots(maxpoints=20000)=diagnostics;
   class LSTUDY;
   model EFTOTLT = LSTUDY;
run;
quit;

proc format;
   value lstudyfmt
      2 = "Undergraduate"
      12 = "Graduate";
run;

proc sgplot data=capstone.efcp_business;
   format LSTUDY lstudyfmt.;
   vbar LSTUDY / response=EFTOTLT stat=mean;
   yaxis label="Mean Fall Enrollment";
   xaxis label="Student Level";
   title "Mean Fall Enrollment by Student Level within Business Programs";
run;

data capstone.efcp_attendance;
   set capstone.efcp_focus;
   where SECTION in (1, 2);
run;

proc glm data=capstone.efcp_attendance plots(maxpoints=20000)=diagnostics;
   class CIPCODE SECTION;
   model EFTOTLT = CIPCODE SECTION CIPCODE*SECTION;
run;
quit;

proc format;
   value sectionfmt
      1 = "Full-time"
      2 = "Part-time";
run;

proc sgplot data=capstone.efcp_attendance;
   format CIPCODE cipcodefmt.;
   vbar CIPCODE / response=EFTOTLT stat=mean
                  group=SECTION groupdisplay=cluster;
   yaxis label="Mean Fall Enrollment";
   xaxis label="Program Category";
   title "Mean Enrollment by Program Category and Attendance Status";
run;

data capstone.efcp_level;
   set capstone.efcp_focus;
   where LSTUDY in (2, 12);
run;

proc glm data=capstone.efcp_level plots(maxpoints=20000)=diagnostics;
   class LSTUDY;
   model EFTOTLT = LSTUDY;
run;
quit;

proc sgplot data=capstone.efcp_level;
   format LSTUDY lstudyfmt.;
   vbar LSTUDY / response=EFTOTLT stat=mean;
   yaxis label="Mean Fall Enrollment";
   xaxis label="Student Level";
   title "Mean Fall Enrollment by Student Level (All Programs)";
run;

proc sgplot data=capstone.efcp_focus;
   reg x=YEAR y=EFTOTLT / degree=1;
   yaxis label="Total Fall Enrollment";
   xaxis label="Year";
   title "Overall Enrollment Trend Across Reporting Years";
run;

proc glm data=capstone.efcp_focus plots(maxpoints=20000)=diagnostics;
   class CIPCODE;
   model EFTOTLT = YEAR CIPCODE YEAR*CIPCODE;
run;
quit;

proc sgplot data=capstone.efcp_focus;
   vbar YEAR / response=EFTOTLT group=CIPCODE groupdisplay=cluster;
   yaxis label="Total Fall Enrollment";
   xaxis label="Year";
   title "Enrollment Trends Over Time by Program Category";
run;

proc glm data=capstone.efcp_focus plots(maxpoints=20000)=diagnostics;
   class CIPCODE;
   model EFTOTLT = CIPCODE;
   ods output ModelANOVA=anova_effects;
run;
quit;