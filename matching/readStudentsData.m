function [students_data] = readStudentsData(students_file)
%This function returns a struct with all the students relevant data...

    raw_data = table2struct(readtable(students_file));
    
    for i = 1:length(raw_data)
        
        students_data(i).studentNumber = raw_data(i).N_;
        students_data(i).year = raw_data(i).ano;
        students_data(i).course = raw_data(i).curso;
        students_data(i).average = raw_data(i).media;
        
        choices_vector = strtrim(strsplit(raw_data(i).choices,'/'));
        
        students_data(i).choices = choices_vector;
        
        students_data(i).slot = 0;
        
        data_tmp = struct2table(students_data);
        data_tmp_srt = sortrows(data_tmp, 'average', 'descend');
        students_data = table2struct(data_tmp_srt);
        
        
    end
    
    
    
end

