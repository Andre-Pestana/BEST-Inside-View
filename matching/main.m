companies_data = readCompanyData('data_input/Info_Companies.xlsx');
students_data = readStudentsData('data_input/BIV-Form-Answers.xlsx');

[companies_data, students_data] = selectOnCompanyPreferences(companies_data, students_data);

[companies_data, students_data] = selectOnStudentPreferences(companies_data, students_data);

outputData(companies_data, students_data);

outputTaskReport(companies_data, students_data);