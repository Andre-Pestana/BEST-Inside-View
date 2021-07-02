function [companies_data] = readCompanyData(company_file)
%This function returns a struct with all the company relevant data...

    raw_data = table2struct(readtable(company_file));
    
    slots = [5 5 3 6 2 4 2 3 2];
    
    for i = 1:length(raw_data)
        companies_data(i).ID = raw_data(i).n;
        companies_data(i).name = raw_data(i).empresa;
        
        if raw_data(i).anos == 'm'
            companies_data(i).requiresMasters = 1;
        elseif raw_data(i).anos == 't'
            companies_data(i).requiresMasters = 0;
        else
            raw_data(i).requiresMasters = null;
        end
        
        courses_vector = struct2cell(raw_data(i));
        courses_vector(1:3) = [];
        courses_vector(cellfun('isempty',courses_vector)) = [];
        companies_data(i).courses = courses_vector;
        
        companies_data(i).slots = slots(i);
        
        companies_data(i).students = {};
        
    end 
    
    
    
end