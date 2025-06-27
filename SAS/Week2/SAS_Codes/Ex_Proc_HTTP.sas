/* Example: Using SAS PROC HTTP and JSON libname engine to process API data */

/* 1. Basic API Call with PROC HTTP */
filename response temp;

proc http 
    url="https://jsonplaceholder.typicode.com/users"
    method="GET"
    out=response;
    headers
        "Accept"="application/json"
        "User-Agent"="SAS";
run;

/* Method to examine the response */
data work.examine_response;
    infile response truncover;
    input raw_json $32767.;
    length_of_line = length(raw_json);
run;

proc print data=work.examine_response;
    title "Raw API Response Content";
run;

/* Check if the HTTP request was successful */
%put &=SYS_PROCHTTP_STATUS_CODE;
%put &=SYS_PROCHTTP_STATUS_PHRASE;

/* 2. Assign JSON libname to parse the response */
libname jsonlib json fileref=response;

/* 3. Explore the JSON structure */
proc datasets lib=jsonlib nolist;
quit;

/* 4. Convert JSON data to SAS dataset */
data work.users;
    set jsonlib.root;
    /* Clean and format data as needed */
    user_id = id;
    user_name = name;
    email_addr = email;
    phone_num = phone;
    website_url = website;
    
    /* Extract nested address information */
    if not missing(address_street) then do;
        full_address = catx(', ', address_street, address_city, address_zipcode);
    end;
    
    /* Keep only desired variables */
    keep user_id user_name email_addr phone_num website_url 
         address_street address_city address_zipcode full_address
         company_name company_catchphrase;
run;

/* 5. Advanced example with POST request and authentication */
filename postdata temp;
filename postres temp;

/* Create JSON payload for POST request */
data _null_;
    file postdata;
    put '{"title": "My New Post",';
    put '"body": "This is the content of my post.",';
    put '"userId": 1}';
run;

proc http 
    url="https://jsonplaceholder.typicode.com/posts"
    method="POST"
    in=postdata
    out=postres
    ct="application/json";
    headers
        "Authorization"="Bearer your-token-here"
        "Accept"="application/json";
run;

/* Parse the POST response */
libname postjson json fileref=postres;

data work.new_post;
    set postjson.root;
    created_date = today();
    format created_date date9.;
run;

/* 6. Error handling and robust API processing */
%macro process_api_data(url=, output_ds=);
    filename apiresp temp;
    
    proc http 
        url="&url"
        method="GET"
        out=apiresp;
        headers
            "Accept"="application/json"
            "User-Agent"="SAS/9.4";
    run;
    
    /* Check for successful response */
    %if &SYS_PROCHTTP_STATUS_CODE = 200 %then %do;
        libname apijson json fileref=apiresp;
        
        /* Check if data exists */
        %let dsid = %sysfunc(open(apijson.root));
        %if &dsid > 0 %then %do;
            %let nobs = %sysfunc(attrn(&dsid, nobs));
            %let rc = %sysfunc(close(&dsid));
            
            %if &nobs > 0 %then %do;
                data &output_ds;
                    set apijson.root;
                    api_extract_date = datetime();
                    format api_extract_date datetime19.;
                run;
                
                %put NOTE: Successfully created &output_ds with &nobs observations;
            %end;
            %else %do;
                %put WARNING: API returned empty dataset;
            %end;
        %end;
        %else %do;
            %put ERROR: Could not open JSON dataset;
        %end;
        
        libname apijson clear;
    %end;
    %else %do;
        %put ERROR: HTTP request failed with status &SYS_PROCHTTP_STATUS_CODE;
        %put ERROR: &SYS_PROCHTTP_STATUS_PHRASE;
    %end;
    
    filename apiresp clear;
%mend;

/* Use the macro */
%process_api_data(
    url=https://jsonplaceholder.typicode.com/posts,
    output_ds=work.all_posts
);

/* 7. Handling complex nested JSON structures */
filename complex temp;

proc http 
    url="https://jsonplaceholder.typicode.com/users/1/albums"
    method="GET"
    out=complex;
run;

libname cjson json fileref=complex;

/* When JSON has nested arrays or objects, multiple datasets may be created */
proc sql;
    select memname, nobs
    from dictionary.tables
    where libname = 'CJSON'
    order by memname;
quit;

/* 8. Working with paginated APIs */
%macro get_paginated_data(base_url=, max_pages=10, output_ds=);
    %local page_num continue_flag;
    %let page_num = 1;
    %let continue_flag = 1;
    
    /* Initialize output dataset */
    data &output_ds;
        length dummy 8;
        stop;
    run;
    
    %do %while(&continue_flag = 1 and &page_num <= &max_pages);
        filename pageresp temp;
        
        proc http 
            url="&base_url?_page=&page_num&_limit=10"
            method="GET"
            out=pageresp;
        run;
        
        %if &SYS_PROCHTTP_STATUS_CODE = 200 %then %do;
            libname pagejson json fileref=pageresp;
            
            /* Check if page has data */
            %let dsid = %sysfunc(open(pagejson.root));
            %if &dsid > 0 %then %do;
                %let nobs = %sysfunc(attrn(&dsid, nobs));
                %let rc = %sysfunc(close(&dsid));
                
                %if &nobs > 0 %then %do;
                    /* Append to main dataset */
                    data &output_ds;
                        set &output_ds
                            pagejson.root(in=new);
                        if new then page_number = &page_num;
                    run;
                    
                    %let page_num = %eval(&page_num + 1);
                %end;
                %else %do;
                    %let continue_flag = 0;
                %end;
            %end;
            %else %do;
                %let continue_flag = 0;
            %end;
            
            libname pagejson clear;
        %end;
        %else %do;
            %let continue_flag = 0;
        %end;
        
        filename pageresp clear;
    %end;
    
    %put NOTE: Retrieved data from &page_num pages;
%mend;

/* Example usage of paginated data retrieval */
%get_paginated_data(
    base_url=https://jsonplaceholder.typicode.com/posts,
    max_pages=5,
    output_ds=work.paginated_posts
);

/* Clean up */
libname jsonlib clear;
libname postjson clear;
filename response clear;
filename postdata clear;
filename postres clear;
filename complex clear;
