function [] = outputData(companies_data, students_data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    filename = 'data_output/outputData.xlsx';
    
    companies_table = struct2table(companies_data);
    companies_table.requiresMasters = [];
    companies_table.courses = [];
    
    for i = 1:length(companies_data)
        
        students_IDs = '';
        
        for j = 1:length(companies_data(i).students)
            
            students_IDs = strcat(students_IDs,'/',companies_data(i).students(j));
            
        end
        companies_table(i,4) = {char(students_IDs)};
    end
    writetable(companies_table, filename, 'Sheet', 1, 'WriteVariableNames', true)
    
    students_table = struct2table(students_data);
    students_table.year = [];
    students_table.course = [];
    students_table.average = [];
    
    for i = 1:length(students_data)
        
        students_choices = '';
        
        for j = 1:length(students_data(i).choices)
            
            students_choices = strcat(students_choices,'/',students_data(i).choices(j));
            
        end
        
        students_table(i,2) = {char(students_choices)};
        
    end
    writetable(students_table, filename, 'Sheet', 2, 'WriteVariableNames', true)
    
    
    
    
    
end

