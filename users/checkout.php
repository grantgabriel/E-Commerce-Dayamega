<?php
require "../includes/db_connect.php";

$id = $_SESSION['id'];
$product_id = $_POST['product_id'];

$sql = "SELECT * FROM customers_account WHERE user_id = '$id'";
$query = mysqli_query($connect, $sql);

if (!$query) {
	die("Query gagal" . mysqli_error($connect));
}

while ($row = mysqli_fetch_array($query)) {
	$name = $row['name'];
	$email = $row['email'];
	$user_id = $row['user_id'];
	$phone_number = $row['phone_number'];
	$address = $row['address'];
	$last_purchase = $row['last_purchase'];
}


function generateUniqueID()
{
	$characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$uniqueID = '';
	$idLength = 10;

	for ($i = 0; $i < $idLength; $i++) {
		$uniqueID .= $characters[rand(0, strlen($characters) - 1)];
	}

	return $uniqueID;
}

$sql = "SELECT * FROM all_product_data WHERE product_id = '$product_id'";
$query = mysqli_query($connect, $sql);

if (!$query) {
	die("Query gagal" . mysqli_error($connect));
}

while ($row = mysqli_fetch_array($query)) {
	$product_name = $row['product_name'];
	$photo = $row['photo'];
	$dealer_prices = $row['dealer_prices'];
	$description = $row['description'];
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Checkout page!</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />

	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="css/slick.css" />
	<link type="text/css" rel="stylesheet" href="css/slick-theme.css" />

	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="css/nouislider.min.css" />

	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="css/font-awesome.min.css">

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="css/style.css" />

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	<link rel="icon" type="image/png" href="../assets/img/dayamega.jpeg">

</head>

<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-left">
					<li><a href="#"><i class="fa fa-phone"></i> +62 812-1314-1516 </a></li>
					<li><a href="#"><i class="fa fa-envelope-o"></i> dayamegapratama@gmail.com</a></li>
					<li><a href="#"><i class="fa fa-map-marker"></i> Putri Hijau Road No. 29 </a></li>
				</ul>
				<ul class="header-links pull-right">
					<li><a href="#"><i class="fa fa-dollar"></i> Pricelist </a></li>
					<li><a href="#"><i class="fa fa-user-o"></i>
							<?= $name ?>
						</a></li>
				</ul>
			</div>
		</div>
		<!-- /TOP HEADER -->

		<!-- MAIN HEADER -->
		<div id="header">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<div class="col-md-3">
						<div class="header-logo">
							<a href="#" class="logo">
								<img src="../assets/img/dayamega.jpeg" alt="" height="70" width="70">
							</a>
						</div>
					</div>
					<!-- /LOGO -->

					<!-- SEARCH BAR -->
					<div class="col-md-6">
						<div class="header-search">
							<form>
								<select class="input-select">
									<!-- <option value="0">All Categories</option>
								<option value="1">Category 01</option>
								<option value="1">Category 02</option> -->
								</select>
								<input class="input" placeholder="Search here">
								<button class="search-btn">Search</button>
							</form>
						</div>
					</div>
					<!-- /SEARCH BAR -->

					<!-- ACCOUNT -->
					<div class="col-md-3 clearfix">
						<div class="header-ctn">
							<!-- Wishlist -->
							<div>
								<a href="#">
									<i class="fa fa-heart-o"></i>
									<span>Your Wishlist</span>
									<!-- <div class="qty"></div> -->
								</a>
							</div>
							<!-- /Wishlist -->

							<!-- Cart -->
							<div class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
									<i class="fa fa-shopping-cart"></i>
									<span>Your Cart</span>
									<div class="qty">1</div>
								</a>
								<div class="cart-dropdown">
									<div class="cart-list">
										<div class="product-widget">
											<div class="product-img">
												<img src="./img/product01.png" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">product name goes here</a></h3>
												<h4 class="product-price"><span class="qty">1x</span>$980.00</h4>
											</div>
											<button class="delete"><i class="fa fa-close"></i></button>
										</div>

										<div class="product-widget">
											<div class="product-img">
												<img src="./img/product02.png" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">product name goes here</a></h3>
												<h4 class="product-price"><span class="qty">3x</span>$980.00</h4>
											</div>
											<button class="delete"><i class="fa fa-close"></i></button>
										</div>
									</div>
									<div class="cart-summary">
										<small>3 Item(s) selected</small>
										<h5>SUBTOTAL: $2940.00</h5>
									</div>
									<div class="cart-btns">
										<a href="#">View Cart</a>
										<a href="#">Checkout <i class="fa fa-arrow-circle-right"></i></a>
									</div>
								</div>
							</div>
							<!-- /Cart -->

							<!-- Menu Toogle -->
							<div class="menu-toggle">
								<a href="#">
									<i class="fa fa-bars"></i>
									<span>Menu</span>
								</a>
							</div>
							<!-- /Menu Toogle -->
						</div>
					</div>
					<!-- /ACCOUNT -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- /MAIN HEADER -->
	</header>
	<!-- /HEADER -->


	<!-- NAVIGATION -->
	<nav id="navigation">
		<!-- container -->
		<div class="container">
			<!-- responsive-nav -->
			<div id="responsive-nav">
				<!-- NAV -->
				<ul class="main-nav nav navbar-nav">
					<li><a href="index.php">Home</a></li>
					<li><a href="#">Products</a></li>
					<li><a href="#">Categories</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->

	<!-- BREADCRUMB -->
	<div id="breadcrumb" class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<h3 class="breadcrumb-header">Checkout</h3>
					<ul class="breadcrumb-tree">
						<li><a href="index.php">Home</a></li>
						<li class="active">Checkout</li>
					</ul>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /BREADCRUMB -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<form method="POST" enctype="multipart/form-data">
					<div class="col-md-7">
						<!-- Billing Details -->
						<div class="billing-details">
							<div class="section-title">
								<h3 class="title">Billing Profile</h3>
							</div>
							<div class="form-group">
								<input class="input" type="text" name="address" placeholder="Address" value="<?= $address ?>">
							</div>
							<div class="form-group">
								<input class="input" type="text" name="phone_number" placeholder="Telephone" value="<?= $phone_number ?>">
							</div>
							<div class="form-group">
								<label for="order_proof" style="padding: 10px 15px; font-size: 15px; color: #333; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease;">
									<span>Upload Proof</span>
								</label>
								<input id="order_proof" class="input" type="file" name="image" accept="image/*" style="display: none;">
							</div>


						</div>
						<!-- /Billing Details -->
						<!-- Shiping Details -->
						<div class="shiping-details">
							<div class="section-title">
								<h3 class="title">Messages</h3>
							</div>
							<div class="input-checkbox">
								<input type="checkbox" id="shiping-address">
								<label for="shiping-address">
									<span></span>
									Got any messages?
								</label>
							</div>
						</div>
						<!-- /Shiping Details -->

						<!-- Order notes -->
						<div class="order-notes">
							<textarea class="input" placeholder="Order Notes" name="messages"></textarea>
						</div>
						<!-- /Order notes -->
					</div>

					<!-- Order Details -->
					<div class="col-md-5 order-details">
						<div class="section-title text-center">
							<h3 class="title">Your Order</h3>
						</div>
						<div class="order-summary">
							<div class="order-col">
								<div><strong>PRODUCT</strong></div>
								<div><strong>TOTAL</strong></div>
							</div>
							<div class="order-products">
								<div class="order-col">
									<div>1x <?= $product_name ?></div>
									<div>Rp <?= $dealer_prices ?>,-</div>
								</div>
							</div>
							<div class="order-col">
								<div>Shiping</div>
								<div><strong>FREE</strong></div>
							</div>
							<div class="order-col">
								<div><strong>TOTAL</strong></div>
								<div><strong class="order-total">Rp <?= $dealer_prices ?>,-</strong></div>
							</div>
						</div>
						<div class="payment-method">
							<div class="input-radio">
								<input type="radio" name="payment" id="payment-1">
								<label for="payment-1">
									<span></span>
									Direct Bank Transfer
								</label>
								<div class="caption">
									<p>Please upload your proof of transfers in the form asides</p>
								</div>
							</div>
							<div class="input-radio">
								<input type="radio" name="payment" id="payment-2">
								<label for="payment-2">
									<span></span>
									Cheque Payment
								</label>
								<div class="caption">
									<p>Please upload your proof of cheque in the form asides.</p>
								</div>
							</div>
						</div>
						<div class="input-checkbox">
							<input type="checkbox" id="terms">
							<label for="terms">
								<span></span>
								I've read and accept the <a href="#">terms & conditions</a>
							</label>
						</div>
						<input hidden name='product_id' type='text' value="<?= $product_id ?>">
						<button class="primary-btn order-submit" type="submit" name="order-button">Place Order!</button>
					</div>
					<!-- /Order Details -->
				</form>
				<?php
				require "../includes/db_connect.php";


				$newFileName = "";

				if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_FILES["image"]["name"])) {
					$uploadDir = 'C:/laragon/www/E-Commerce-Dayamega/media/structs/'; // Directory where uploaded images will be saved
					$randomStr = uniqid(); // Generate a random string
					$date = date('Y-m-d'); // Get current date
				
					// Get the file information
					$fileName = basename($_FILES["image"]["name"]);
					$fileTmp = $_FILES["image"]["tmp_name"];
				
					// Extract file extension
					$fileExtension = pathinfo($fileName, PATHINFO_EXTENSION);
				
					// Create a unique filename using current date, random string, and file extension
					$newFileName = $date . '-' . $randomStr . '.' . $fileExtension;
				
					// Move the uploaded file to the specified directory with the new filename
					$destination = $uploadDir . $newFileName;
					if (move_uploaded_file($fileTmp, $destination)) {
						echo "";
					} else {
						echo "Error uploading file.";
					}
				}
				
				if (isset($_POST['order-button'])) {
					$order_id = generateUniqueID();
					$product_id = $_POST['product_id'];
					$address = $_POST['address'];
					$phone_number = $_POST['phone_number'];
				
					$courier_sql = "SELECT getRandomCourierUserId() AS courier";
					$courier_query = mysqli_query($connect, $courier_sql);
					$courier = mysqli_fetch_assoc($courier_query);
					$courier = $courier['courier'];
				
					$status = 'Unconfirmed';
					$message = $_POST['messages'];
				
					$order_query = "INSERT INTO orders VALUES('$order_id', '$product_id', '$id', '$dealer_prices', '$address', '$phone_number', NOW(), '$courier', '$status', '$message', '$newFileName')";
					$order_sql = mysqli_query($connect, $order_query);
				
					echo '<script>window.location.href = "products.php";</script>';
				}
				
				?>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->

	<!-- FOOTER -->
	<footer id="footer">
		<!-- top footer -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">About Us</h3>
							<p>Dayamega is an IT company specializing in laptops supply chain and spare parts.</p>
							<ul class="footer-links">
								<li><a href="#"><i class="fa fa-map-marker"></i> Putri Hijau Road No. 29 </a></li>
								<li><a href="#"><i class="fa fa-phone"></i> +62 812-1314-1516 </a></li>
								<li><a href="#"><i class="fa fa-envelope-o"></i> dayamegapratama@gmail.com </a></li>
							</ul>
						</div>
					</div>

					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">Categories</h3>
							<ul class="footer-links">
								<li><a href="#">Hot deals</a></li>
								<li><a href="#">Laptops</a></li>
								<li><a href="#">Accessories</a></li>
								<li><a href="#">Others</a></li>
							</ul>
						</div>
					</div>

					<div class="clearfix visible-xs"></div>

					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">Information</h3>
							<ul class="footer-links">
								<li><a href="#">About Us</a></li>
								<li><a href="#">Contact Us</a></li>
								<li><a href="#">Privacy Policy</a></li>
								<li><a href="#">Orders and Returns</a></li>
								<li><a href="#">Terms & Conditions</a></li>
							</ul>
						</div>
					</div>

					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">Service</h3>
							<ul class="footer-links">
								<li><a href="#">My Account</a></li>
								<li><a href="#">View Cart</a></li>
								<li><a href="#">Wishlist</a></li>
								<li><a href="#">Track My Order</a></li>
								<li><a href="#">Help</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /top footer -->

		<!-- bottom footer -->
		<div id="bottom-footer" class="section">
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-12 text-center">
						<ul class="footer-payments">
							<li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
							<li><a href="#"><i class="fa fa-credit-card"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
						</ul>
						<span class="copyright">
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;
							<script>
								document.write(new Date().getFullYear());
							</script> All rights reserved | This
							template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://github.com/grantgabriel/E-Commerce-Dayamega" target="_blank">Group 5</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						</span>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /bottom footer -->
	</footer>
	<!-- /FOOTER -->

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>

</body>

</html>