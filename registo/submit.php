<?php // You need to add server side validation and better error handling here
$data = array();
$uploaddir = './curriculos/';
$uploaddir2 = './comprovativos/';
$a=1;
if(isset($_GET['files'])){	
	$error = false;
	$files = array();
	$n_aluno = $_POST['name2'];
	
	foreach($_FILES as $file){
		if($a==2){
			if(move_uploaded_file($file['tmp_name'], $uploaddir2.$n_aluno)){
				//$files[] = $uploaddir2 .$file['name'];
			}
			else{
				$error = true;
			}
		}else{
			if(move_uploaded_file($file['tmp_name'], $uploaddir.$n_aluno)){
			}
			else{
				$error = true;
			}
		}
		$a=2;
	}
	
	$data = ($error) ? array('error' => 'There was an error uploading your files') : array('files' => $files);
}
else{
	$data = array('success' => $a, 'formData' => $_POST);
}
echo json_encode($data);
?>