function [companies_data, students_data] = selectOnCompanyPreferences(companies_data, students_data)
%This function will assign the students to the companies, according to the
%companies preferences...


    %First, sort the students by the companies that require master
    %degrees...
    for i = 1:length(companies_data)
        if (companies_data(i).requiresMasters == 1)
            for j = 1:length(students_data)
                if (students_data(j).year == 4) || (students_data(j).year == 5)
                    if any(strcmp(string(companies_data(i).courses),students_data(j).course)) &&...
                            (companies_data(i).slots > 0) &&...
                            (students_data(j).slot == 0)
                        companies_data(i).slots = companies_data(i).slots - 1;
                        companies_data(i).students(end+1) = {students_data(j).studentNumber};
                        students_data(j).slot = i;
                    end
                end
            end   
        end       
    end
    
    %Then, sort the students by the companies that don´t require master
    %degrees..
    for i = 1:length(companies_data)
        if (companies_data(i).requiresMasters == 0)
            for j = 1:length(students_data)
                if (students_data(j).year == 4) || (students_data(j).year == 5)
                    if any(strcmp(string(companies_data(i).courses),students_data(j).course)) &&...
                            (companies_data(i).slots > 0) &&...
                            (students_data(j).slot == 0)
                        companies_data(i).slots = companies_data(i).slots - 1;
                        companies_data(i).students(end+1) = {students_data(j).studentNumber};
                        students_data(j).slot = i;
                    end
                end
            end   
        end       
    end


end

