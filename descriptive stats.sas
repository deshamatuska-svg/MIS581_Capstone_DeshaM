data capstone.efcp_focus;
    set capstone.efcp_all;
    if CIPCODE in ('51.1201','52.0000','22.0101');
run;

proc contents data=capstone.efcp_focus;
run;

proc freq data=capstone.efcp_focus;
   tables YEAR CIPCODE SECTION LSTUDY;
run;

proc means data=capstone.efcp_focus n mean median std min max;
   var EFTOTLT;
run;

proc means data=capstone.efcp_focus n mean median min max;
   class YEAR;
   var EFTOTLT;
run;

proc means data=capstone.efcp_focus n mean median min max;
   class CIPCODE;
   var EFTOTLT;
run;

proc means data=capstone.efcp_focus n mean median min max;
   class SECTION;
   var EFTOTLT;
run;

proc means data=capstone.efcp_focus n mean median min max;
   class LSTUDY;
   var EFTOTLT;
run;

proc sgplot data=capstone.efcp_focus;
   vbox EFTOTLT / category=CIPCODE;
   yaxis label="Fall Enrollment";
   title "Distribution of Fall Enrollment by Program Category";
run;

proc sgplot data=capstone.efcp_focus;
   vbar YEAR / response=EFTOTLT stat=mean
               group=CIPCODE groupdisplay=cluster;
   yaxis label="Mean Fall Enrollment";
   xaxis label="Year";
   title "Mean Fall Enrollment by Program Category and Year";
run;

proc sgpanel data=capstone.efcp_m3_summary;
    panelby SECTION LSTUDY / columns=2;
    series x=YEAR y=Mean_Enrollment / group=CIPCODE markers;
    colaxis label="Year";
    rowaxis label="Mean Fall Enrollment";
    title "Mean Enrollment Trends by Program, Attendance Status (SECTION), and Student Level (LSTUDY)";
run;