Outputing up the second to last observation by group                                                    
                                                                                                        
I assume a second to last exists                                                                        
                                                                                                        
Nuce aopllication of Paul Dorfmans DOW without a by on the second loop.                                 
                                                                                                        
github                                                                                                  
http://tinyurl.com/y2ovoanv                                                                             
https://github.com/rogerjdeangelis/utl-datastep-outputing-the-second-to-last-observation-by-group       
                                                                                                        
http://tinyurl.com/yxnpp58r                                                                             
https://communities.sas.com/t5/SAS-Programming/Picking-up-Every-Second-Last-Observation/m-p/549139      
                                                                                                        
Tom Profile                                                                                             
https://communities.sas.com/t5/user/viewprofilepage/user-id/159                                         
                                                                                                        
*_                   _                                                                                  
(_)_ __  _ __  _   _| |_                                                                                
| | '_ \| '_ \| | | | __|                                                                               
| | | | | |_) | |_| | |_                                                                                
|_|_| |_| .__/ \__,_|\__|                                                                               
        |_|                                                                                             
;                                                                                                       
                                                                                                        
proc sort data=sashelp.class(obs=10) out=class;                                                         
  by sex;                                                                                               
run;quit;                                                                                               
                                                                                                        
                                                                                                        
Picking up the Second Last Observation by group                                                         
                                                                                                        
                                                                                                        
Up to 40 obs WORK.CLASS total obs=10                                                                    
                                                                                                        
Obs    NAME       SEX    AGE    HEIGHT    WEIGHT                                                        
                                                                                                        
  1    Alice       F      13     56.5       84.0                                                        
  2    Barbara     F      13     65.3       98.0                                                        
  3    Carol       F      14     62.8      102.5                                                        
  4    Jane        F      12     59.8       84.5  * only output this record                             
  5    Janet       F      15     62.5      112.5                                                        
                                                                                                        
  6    Alfred      M      14     69.0      112.5                                                        
  7    Henry       M      14     63.5      102.5                                                        
  8    James       M      12     57.3       83.0                                                        
  9    Jeffrey     M      13     62.5       84.0  * only output this record                             
 10    John        M      12     59.0       99.5                                                        
                                                                                                        
                                                                                                        
*                                                                                                       
 _ __  _ __ ___   ___ ___  ___ ___                                                                      
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                     
| |_) | | | (_) | (_|  __/\__ \__ \                                                                     
| .__/|_|  \___/ \___\___||___/___/                                                                     
|_|                                                                                                     
;                                                                                                       
                                                                                                        
                                                                                                        
data want;                                                                                              
  do _n=1 by 1 until(last.sex);                                                                         
    set class;                                                                                          
    by sex;                                                                                             
end;                                                                                                    
put _n;                                                                                                 
do _n2=1 to _n;                                                                                         
  set class;                                                                                            
  by sex;                                                                                               
  if _n2 = _n-1 then output;                                                                            
end;                                                                                                    
drop _n _n2;                                                                                            
run;                                                                                                    
                                                                                                        
*            _               _                                                                          
  ___  _   _| |_ _ __  _   _| |_                                                                        
 / _ \| | | | __| '_ \| | | | __|                                                                       
| (_) | |_| | |_| |_) | |_| | |_                                                                        
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                       
                |_|                                                                                     
;                                                                                                       
                                                                                                        
Up to 40 obs from WANT total obs=2                                                                      
                                                                                                        
Obs    NAME       SEX    AGE    HEIGHT    WEIGHT                                                        
                                                                                                        
 1     Jane        F      12     59.8      84.5                                                         
 2     Jeffrey     M      13     62.5      84.0                                                         
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        