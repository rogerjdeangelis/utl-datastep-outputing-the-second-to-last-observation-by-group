# utl-datastep-outputing-the-second-to-last-observation-by-group
    Outputing the second to last observation by group                                                         
                                                                                                              
    I assume a second to last exists                                                                          
                                                                                                              
      Two Solutions                                                                                           
                                                                                                              
          1. Elegant solution by  "Keintz, Mark" <mkeintz@WHARTON.UPENN.EDU>                                  
          2. DOW (without a by on the second loop)                                                            
          3. Curobs Paul Dorfman, Bartosz Jablonski, and Nat Wooding                                          
             Paul Dorfman sashole@bellsouth.net                                                               
             Bartosz Jablonski yabwon@gmail.com                                                               
             Nat Wooding <nathani@verizon.net>                                                                
        
    ******************************************                                   
    Recent gereral solution for nth last by                                      
                                                                                 
    Keintz, Mark                                                                 
    mkeintz@wharton.upenn.edu                                                    
    and                                                                          
    Yinglin (Max) Wu                                                             
    yinglinwu@gmail.com                                                          
                                                                                 
    data have;                                                                   
    input x y;                                                                   
    cards4;                                                                      
    1 2                                                                          
    1 2                                                                          
    1 4                                                                          
    1 4                                                                          
    1 4                                                                          
    2 4                                                                          
    3 5                                                                          
    3 6                                                                          
    3 6                                                                          
    3 6                                                                          
    3 5                                                                          
    ;;;;                                                                         
    run;quit;                                                                    
                                                                                 
    Mark, this method is so neat.                                                
                                                                                 
    Slightly modifying it could be used to handle n-th last                      
    and the case where the key value gets repeated fewer than n times.           
                                                                                 
    Just make sure the lag period is one less than the desired offset …          
    and that the second SET statement drops the by-variable.                     
                                                                                 
    %let x=5;                                                                    
    %let lag=%eval(&x-1);                                                        
                                                                                 
    data want;                                                                   
      set have(keep=grp);                                                        
      by grp;                                                                    
      if _n_>=&x then set have (drop=grp);                                       
      if last.grp and lag&lag(grp)=grp;                                          
    run;                                                                         
                                                                                 
    The “and group=lag&lag(group)” condition                                     
    makes sure that the by-group is of sufficient size.                          
    **************************************************                           
                                                                                 
     Other Solutions                                                                                                     
                                                                                                              
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
                                                                                                              
    1. Elegant solution by  "Keintz, Mark" <mkeintz@WHARTON.UPENN.EDU>                                        
                                                                                                              
       Too busy.  Utilize the ability to read observations offset from each other:                            
                                                                                                              
       data want;                                                                                             
         set class (keep=sex);                                                                                
         by sex;                                                                                              
         if _n_>=2 then set class;                                                                            
         if last.sex;                                                                                         
       run;                                                                                                   
                                                                                                              
       Of course the above assume each by group has 2 or more observations.                                   
       But you can easily avoid the problem of single member by                                               
       groups by changing the subsetting if to                                                                
                                                                                                              
       If last.sex  and not first.sex;                                                                        
                                                                                                              
                                                                                                              
     2. DOW (without a by on the second loop)                                                                 
                                                                                                              
        data want;                                                                                            
          do _n=1 by 1 until(last.sex);                                                                       
            set class;                                                                                        
            by sex;                                                                                           
        end;                                                                                                  
        put _n;                                                                                               
        do _n2=1 to _n;                                                                                       
          set class;                                                                                          
          if _n2 = _n-1 then output;                                                                          
        end;                                                                                                  
        drop _n _n2;                                                                                          
        run;                                                                                                  
                                                                                                              
     3. Curobs Paul Dorfman, Bartosz Jablonski, and Nat Wooding                                               
                                                                                                              
       data want ;                                                                                            
         do _n_ = 1 by 1 until (last.sex) ;                                                                   
           set class curobs = p ;                                                                             
           by sex ;                                                                                           
         end ;                                                                                                
         if _n_ > 1 ;                                                                                         
         p +- 1 ;                                                                                             
         set class point = p ;                                                                                
       run ;                                                                                                  
                                                                                                              
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
                                                                                                              
                                                                      
                                                                                                              
                                                                                
                                                                                                             
                                                                                                             
