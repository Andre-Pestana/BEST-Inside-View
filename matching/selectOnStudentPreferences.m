function [companies_data, students_data] = selectOnStudentPreferences(companies_data, students_data)
%This function will assign the students to the companies, according to the
%students preferences...


    %First, sort the students by the companies that were chosen by the
    %student...
    for i = 1:length(students_data)
        for j = 1:length(companies_data)
            if(companies_data(j).slots > 0) && (students_data(i).slot == 0)
                match_vector = ismember(cellfun(@str2num,students_data(i).choices), companies_data(j).ID);
                if (any(match_vector))
                    companies_data(j).slots = companies_data(j).slots - 1;
                    companies_data(j).students(end+1) = {students_data(i).studentNumber};
                    students_data(i).slot = j;
                end
            end
        end 
    end
    
    %Then, sort the students that haven´t been chosen yet...
    for i = 1:length(students_data)
        for j = 1:length(companies_data)
            if(companies_data(j).slots > 0) && (students_data(i).slot == 0)
                companies_data(j).slots = companies_data(j).slots - 1;
                companies_data(j).students(end+1) = {students_data(i).studentNumber};
                students_data(i).slot = j;
            end
        end
    end
    
    
end

