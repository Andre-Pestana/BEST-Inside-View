function [] = outputTaskReport(companies_data, students_data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


    filename = "data_output/outputTaskReport.txt";

    num_companies = length(companies_data);
    num_students = length(students_data);
    
    num_placements = 0;
    num_companies_with_no_placements = 0;
    num_choice_placements = 0;
    
    for i = 1:num_companies
        num_placements = num_placements + length(companies_data(i).students);
        
        if (isempty(companies_data(i).students))
            
            num_companies_with_no_placements = num_companies_with_no_placements + 1;
            
        end
        
    end
    
    for i = 1:num_students
       
        match_vector = ismember(cellfun(@str2num,students_data(i).choices), students_data(i).slot);
        
        if (any(match_vector))
            
            num_choice_placements = num_choice_placements + 1; 
            
        end
    end
    
    
    fid = fopen(filename, 'w');
    fprintf(fid, "TOTAL NUMBER OF COMPANIES: " + num_companies);
    fprintf(fid,'\n');
    fprintf(fid, "TOTAL NUMBER OF STUDENTS: " + num_students);
    fprintf(fid,'\n');
    fprintf(fid, "TOTAL NUMBER OF PLACEMENTS: " + num_placements);
    fprintf(fid,'\n');
    fprintf(fid, "TOTAL NUMBER OF PLACEMENTS IN CHOSEN COMPANIES: %d", num_choice_placements);
    fprintf(fid,'\n');
    fprintf(fid, "TOTAL NUMBER OF COMPANIES WITH NO PLACEMENTS: %d", num_companies_with_no_placements);
    fprintf(fid,'\n');
    fclose(fid);


end

