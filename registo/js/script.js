$(function()
{
	// Variable to store your files
	var files;
		var files2;
	var name;
	// Add events
	$('#file').on('change', prepareUpload);
	$('#file2').on('change', prepareUpload2);
	$('#trigger').on('change', uploadFiles);

	// Grab the files and set them to our variable
	
	function final(){
		if(document.getElementById("spinner").classList.contains('hidden')==0) document.getElementById("spinner").classList.toggle('hidden');
		document.getElementById("text").innerHTML='';
		document.getElementById("botao").disabled = false;
	}
	
	function prepareUpload(event){
		files = event.target.files;	
		console.log(files[0].name);
		if(files[0].name!=""){
			status=1;
		}else status=0;
	}
	
	function prepareUpload2(event){
		files2 = event.target.files;	
		if(files2[0].name!=""){
			status2=1;
		}else status2=0;
	}

	// Catch the form submit and upload the files
	function uploadFiles(event)
	{
		event.stopPropagation(); // Stop stuff happening
        event.preventDefault(); // Totally stop stuff happening

        // START A LOADING SPINNER HERE
		var t=files[0].name.split('.');
		name=document.getElementById('Nº').value+'.'+t[1];
        // Create a formdata object and add the files
		var data = new FormData();

		$.each(files, function(key, value)
		{
			data.append(key, value);
		});
		
		if(status2==1){
			$.each(files2, function(key, value)
			{
				data.append(1, value);
			});
		}
		data.append('name2', name);

        
        $.ajax({
            url: 'submit.php?files',
            type: 'POST',
            data: data,
            cache: false,
            dataType: 'json',
            processData: false, // Don't process the files
            contentType: false, // Set content type to false as jQuery will tell the server its a query string request
            success: function(data, textStatus, jqXHR)
            {
            	if(typeof data.error === 'undefined')
            	{
            		// Success so call function to process the form
            		submitForm(event, data);
            	}
            	else
            	{
            		// Handle errors here
            		console.log('ERRORS: ' + data.error);
            	}
            },
            error: function(jqXHR, textStatus, errorThrown)
            {
            	// Handle errors here
            	console.log('ERRORS: ' + textStatus);
            	// STOP LOADING SPINNER
            }
        });
    }

    function submitForm(event, data)
	{
		// Create a jQuery object from the form
		$form = $(event.target);
		
		// Serialize the form data
		var formData = $form.serialize();
		
		// You should sterilise the file names
		$.each(data.files, function(key, value)
		{
			formData = formData + '&filenames[]=' + value;
		});

		$.ajax({
			url: 'submit.php',
            type: 'POST',
            data: formData,
            cache: false,
            dataType: 'json',
            success: function(data, textStatus, jqXHR)
            {
            	if(typeof data.error === 'undefined')
            	{
            		// Success so call function to process the form
            		console.log('SUCCESS: ' + data.success);
					alertify.success('Formulário submetido com sucesso! Obrigado.');
					final();
            	}
            	else
            	{
            		// Handle errors here
            		console.log('ERRORS: ' + data.error);
					alertify.error('ERRORS: ' + data.error);
					final();
            	}
            },
            error: function(jqXHR, textStatus, errorThrown)
            {
            	// Handle errors here
            	console.log('ERRORS: ' + textStatus);
				alertify.error('ERRORS: ' + textStatus);
				final();
            },
            complete: function()
            {
				final();
            	// STOP LOADING SPINNER
            }
		});
	}
});