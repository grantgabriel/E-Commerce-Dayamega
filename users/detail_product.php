<?php
require "../includes/db_connect.php";

$id = $_SESSION['id'];
$product_id = $_POST['product_id'];

$sql = "SELECT * FROM users WHERE user_id = '$id'";
$query = mysqli_query($connect, $sql);

if (!$query) {
	die("Query gagal" . mysqli_error($connect));
}

while ($row = mysqli_fetch_array($query)) {
	$name = $row['name'];
	$email = $row['email'];
}

$sql = "SELECT * FROM all_product_data WHERE product_id = '$product_id'";
$query = mysqli_query($connect, $sql);

if (!$query) {
	die("Query gagal" . mysqli_error($connect));
}

while ($row = mysqli_fetch_array($query)) {
	$product_name = $row['product_name'];
	$stock = $row['stock'];
	$category_id = $row['category_id'];
	$photo = $row['photo'];
	$user_prices = $row['user_prices'];
	$dealer_prices = $row['dealer_prices'];
	$spec_display = $row['spec_display'];
	$spec_ram = $row['spec_ram'];
	$spec_proc = $row['spec_proc'];
	$spec_gpu = $row['spec_gpu'];
	$spec_storage = $row['spec_storage'];
	$spec_audio = $row['spec_audio'];
	$spec_battery = $row['spec_battery'];
	$spec_weight = $row['spec_weight'];
	$spec_connectivity = $row['spec_connectivity'];
	$spec_camera = $row['spec_camera'];
	$spec_extandable_ram = $row['spec_extandable_ram'];
	$spec_extandable_ssd = $row['spec_extandable_ssd'];
	$spec_dimension = $row['spec_dimension'];
	$description = $row['description'];
	$operating_system = $row['operating_system'];
	$antivirus = $row['antivirus'];
	$category = $row['category'];
	$sold_products = $row['sold_products'];
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Product's Details</title>

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
	<link rel="icon" type="image/png" href="../assets/img/dayamega.jpeg">


	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

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
					<li><a href="#"><i class="fa fa-user-o"></i> <?= $name ?> </a></li>
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
					<li class="active"><a href="#">Products</a></li>
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
					<ul class="breadcrumb-tree">
						<li><a href="#">Home</a></li>
						<li><a href="#">Products</a></li>
						<li class="active"><?= $product_name ?></li>
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
				<!-- Product main img -->
				<div class="col-md-5 col-md-push-2">
					<div id="product-main-img">
						<div class="product-preview">
							<img src="../media/laptop-photos/<?= $photo ?>" alt="">
						</div>
					</div>
				</div>
				<!-- /Product main img -->

				<!-- Product thumb imgs -->
				<div class="col-md-2  col-md-pull-5">
					<div id="product-imgs">
						<div class="product-preview" style="visibility: hidden;">
							<img src="./img/product01.png" alt="">
						</div>

						<div class="product-preview">
							<img src="../media/laptop-photos/<?= $photo ?>" alt="Laptop Photo">
						</div>

						<div class="product-preview" style="visibility: hidden;">
							<img src="./img/product06.png" alt="">
						</div>
					</div>
				</div>
				<!-- /Product thumb imgs -->

				<!-- Product details -->
				<div class="col-md-5">
					<div class="product-details">
						<h2 class="product-name"><?= $product_name ?></h2>
						<div>
							<div class="product-rating">
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star-o"></i>
							</div>
							<a class="review-link" href="#"><?= $sold_products ?> Sold(s) | Buy your own!</a>
						</div>
						<div>
							<h3 class="product-price">Rp <?= $dealer_prices ?>,-</h3>
							<span class="product-available"><?= $stock ?> In Stock</span>
						</div>
						<p><?= $description ?></p>
						<div class="add-to-cart">
							<form action="checkout.php" method="POST">
								<input hidden name='product_id' type='text' value="<?= $data['product_id'] ?>">
								<button class="add-to-cart-btn" type="submit"><i class="fa fa-shopping-cart"></i> add to cart</button>
							</form>
						</div>
						<ul class="product-btns">
							<li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
							<li><a href="#"><i class="fa fa-exchange"></i> add to compare</a></li>
						</ul>

						<ul class="product-links">
							<li>Category:</li>
							<li><a href="#"><?= $category ?></a></li>
							<li><a href="#"><?= $category_id ?></a></li>
						</ul>

						<ul class="product-links">
							<li>Share:</li>
							<li><a href="#"><i class="fa fa-facebook"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
							<li><a href="#"><i class="fa fa-envelope"></i></a></li>
						</ul>

					</div>
				</div>
				<!-- /Product details -->

				<!-- Product tab -->
				<div class="col-md-12">
					<div id="product-tab">
						<!-- product tab nav -->
						<ul class="tab-nav">
							<li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
							<li><a data-toggle="tab" href="#tab2">Details</a></li>
						</ul>
						<!-- /product tab nav -->

						<!-- product tab content -->
						<div class="tab-content">
							<!-- tab1  -->
							<div id="tab1" class="tab-pane fade in active">
								<div class="row">
									<div class="col-md-12">
										<p><?= $description ?></p>
									</div>
								</div>
							</div>
							<!-- /tab1  -->

							<!-- tab2  -->
							<div id="tab2" class="tab-pane fade in">
								<div class="row">
									<table class="table">
										<thead class="thead-dark">
											<tr>
												<th scope="col"><b><i>Specification</i></b></th>
												<th scope="col"><b><i>Details</i></b></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>Display</td>
												<td><?= $spec_display ?></td>
											</tr>
											<tr>
												<td>Processor Unit</td>
												<td><?= $spec_proc ?></td>
											</tr>
											<tr>
												<td>RAM</td>
												<td><?= $spec_ram ?></td>
											</tr>
											<tr>
												<td>Graphics Card</td>
												<td><?= $spec_gpu ?></td>
											</tr>
											<tr>
												<td>Storage</td>
												<td><?= $spec_storage ?></td>
											</tr>
											<tr>
												<td>Audio</td>
												<td><?= $spec_audio ?></td>
											</tr>
											<tr>
												<td>Battery</td>
												<td><?= $spec_battery ?></td>
											</tr>
											<tr>
												<td>Weight</td>
												<td><?= $spec_weight ?></td>
											</tr>
											<tr>
												<td>Connectivity</td>
												<td><?= $spec_connectivity ?></td>
											</tr>
											<tr>
												<td>Camera</td>
												<td><?= $spec_camera ?></td>
											</tr>
											<tr>
												<td>Extandable RAM</td>
												<td><?= $spec_extandable_ram ?></td>
											</tr>
											<tr>
												<td>Extandable Storage</td>
												<td><?= $spec_extandable_ssd ?></td>
											</tr>
											<tr>
												<td>Dimension</td>
												<td><?= $spec_dimension ?></td>
											</tr>
											<tr>
												<td>Operating System (OS)</td>
												<td><?= $operating_system ?></td>
											</tr>
											<tr>
												<td>Anti Virus</td>
												<td><?= $antivirus ?></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- /tab2  -->
						</div>
						<!-- /product tab content  -->
					</div>
				</div>
				<!-- /product tab -->
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