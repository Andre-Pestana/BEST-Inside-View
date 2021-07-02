// Variable to hold request
var request;

	function start(){
		document.getElementById("spinner").classList.toggle('hidden');
		document.getElementById("text").innerHTML='(0/2) Submitting....';
		document.getElementById("botao").disabled = true;
	}
	
	function end(){
		document.getElementById("spinner").classList.toggle('hidden');
		document.getElementById("text").innerHTML='';
		document.getElementById("botao").disabled = false;
	}
	
	function clearFields(){
		document.getElementById("text").innerHTML='(1/2) Uploading CV...';
		$('#trigger').val('go').trigger('change');
	}
	
	function handleError(){
	}
	
// Bind to the submit event of our form
$("#foo").submit(function(event){

    // Abort any pending request
    if (request) {
        request.abort();
    }
	start();
	
	
	if(status==0){
		alertify.error("Don't forget to upload the CV!");
		event.preventDefault();
		end();
		return;
	}
	
	if(first.getAttribute("name")==""){
		alertify.error("You've to choose at least one company!");
		event.preventDefault();
		end();
		return;
	}
	
	if(document.getElementById('Reg').checked==false){
		alertify.error("You have to accept the terms and conditions!");
		event.preventDefault();
		end();
		return;
	}
	
    // setup some local variables
    var $form = $(this);

    // Let's select and cache all the fields
    var $inputs = $form.find("input, select, button, textarea");

    // Serialize the data in the form
    var serializedData = $form.serialize();

    // Let's disable the inputs for the duration of the Ajax request.
    // Note: we disable elements AFTER the form data has been serialized.
    // Disabled form elements will not be serialized.
    $inputs.prop("disabled", true);
	

    // Fire off the request to /form.php
    request = $.ajax({
       // url: "https://script.google.com/macros/s/AKfycbyj8sSs8SykcyVvCuqInY5qfI3_CuSsIv66UUv_cTZpwAjPENc/exec",
		url: "https://script.google.com/a/best.ist.utl.pt/macros/s/AKfycby230O92Ys0Xg2c3HwpI92rC7DTcHIurTAopjQK7mDv2Nq5L7A/exec",
        type: "post",
        data: serializedData
    });

    // Callback handler that will be called on success
    request.done(function (response, textStatus, jqXHR){
        // Log a message to the console
        console.log("Hooray, it worked!");
        console.log(response);
        console.log(textStatus);
        console.log(jqXHR);
		clearFields();
    });

    // Callback handler that will be called on failure
    request.fail(function (jqXHR, textStatus, errorThrown){
        // Log the error to the console
		handleError();
        console.error(
            "The following error occurred: "+
            textStatus, errorThrown
        );
    });

    // Callback handler that will be called regardless
    // if the request failed or succeeded
    request.always(function () {
        // Reenable the inputs
        $inputs.prop("disabled", false);
    });

    // Prevent default posting of form
    event.preventDefault();
});