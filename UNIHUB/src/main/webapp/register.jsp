<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <form method="post" action="AddCustomers">
	<div class="form-floating mb-3">
  		<input type="text" class="form-control" id="floatingInput" name="fname" placeholder="m.d.john">
  		<label for="floatingInput">First Name</label>
	</div>
	
	<div class="form-floating mb-3">
  		<input type="text" class="form-control" id="floatingInput" name="lname" placeholder="m.d.john">
  		<label for="floatingInput">Last Name</label>
	</div>

	<div class="form-floating mb-3">
  		<input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com">
  		<label for="floatingInput">Email address</label>
	</div>

	<div class="form-floating">
  		<input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password">
  		<label for="floatingPassword">Password</label>
	</div>
	
	<div class="form-floating">
  		<input type="text" class="form-control" id="floatingPassword" name="contactnumber" placeholder="Password">
  		<label for="floatingPassword">Contact Number</label>
	</div>
	<button type="submit" class="btn btn-secondary">Submit</button>
	
   </form>
</body>
</html>