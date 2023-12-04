<?php
require "../includes/db_connect.php";

$id = $_SESSION['id'];
$category_name = $_POST['category'];

$sql = "SELECT * FROM users WHERE user_id = '$id'";
$query = mysqli_query($connect, $sql);

if (!$query) {
	die("Query gagal" . mysqli_error($connect));
}

while ($row = mysqli_fetch_array($query)) {
	$name = $row['name'];
	$email = $row['email'];
}

$total_products_sql = "SELECT totalProducts() AS totalProducts";
$total_products_query = mysqli_query($connect, $total_products_sql);
$totalProducts = mysqli_fetch_assoc($total_products_query);
$totalProducts = $totalProducts['totalProducts'];
?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Product Dayamega's</title>

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
									<option value="0">All Categories</option>
									<option value="1">Category 01</option>
									<option value="1">Category 02</option>
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
									<div class="qty">2</div>
								</a>
							</div>
							<!-- /Wishlist -->

							<!-- Cart -->
							<div class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
									<i class="fa fa-shopping-cart"></i>
									<span>Your Cart</span>
									<div class="qty">3</div>
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
					<li class=""><a href="index.php">Home</a></li>
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
						<li><a href="index.php">Home</a></li>
						<li><a href="#">Products</a></li>
						<li class="active">All products (<?= $totalProducts ?> Results)</li>
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
				<!-- ASIDE -->
				<div id="aside" class="col-md-3">
					<!-- aside Widget -->
					<div class="aside">
						<h3 class="aside-title">Categories</h3>
						<?php
						require "../includes/db_connect.php";

						$category_sql = "SELECT * FROM categories";
						$category_query = mysqli_query($connect, $category_sql);

						while ($data = mysqli_fetch_assoc($category_query)) {
						?>
							<div class="checkbox-filter">
								<div class="input-checkbox">
									<form action="categorized_product.php">
										<span>
											<button style="all: unset;" type="submit"><?= $data['category'] ?></button>
										</span>
										<small>
											(<?= $data['category_id'] ?>)
										</small>
										<input hidden name='category' type='text' value="<?= $data['category'] ?>">
									</form>
								</div>
							</div>
						<?php } ?>
					</div>
					<!-- /aside Widget -->

					<!-- aside Widget -->
					<div class="aside">
						<h3 class="aside-title">Top selling</h3>
						<?php
						require "../includes/db_connect.php";

						$popular_sql = "SELECT * FROM product_by_popularity LIMIT 3";
						$popular_query = mysqli_query($connect, $popular_sql);

						while ($data = mysqli_fetch_assoc($popular_query)) {
						?>
							<div class="product-widget">
								<div class="product-img">
									<img src="../media/laptop-photos/<?= $data['photo'] ?>" alt="">
								</div>
								<div class="product-body">
									<p class="product-category"><i><b><?= $data['category'] ?></b></i> - Sold: <b><?= $data['sold_products'] ?></p>
									<h3 class="product-name"><?= $data['product_name'] ?></h3>
									<h4 class="product-price">Rp<?= $data['dealer_prices'] ?>,-</h4>
								</div>
							</div>
						<?php } ?>
					</div>
					<!-- /aside Widget -->
				</div>
				<!-- /ASIDE -->

				<!-- STORE -->
				<!-- store products -->
				<div id="store" class="col-md-9">
					<!-- product -->
					<div class="row">
					<?php
					require "../includes/db_connect.php";

					$product_carousel_sql = "SELECT * FROM product_carousels WHERE category = '$category_name'";
					$product_carousel_query = mysqli_query($connect, $product_carousel_sql);

					while ($data = mysqli_fetch_assoc($product_carousel_query)) {
					?>
							<div class="col-md-4 col-xs-3">
								<form method="POST" action="detail_product.php">
									<div class="product">
										<div class="product-img">
											<img src="../media/laptop-photos/<?= $data['photo'] ?>" alt="">
											<div class="product-label">
												<!-- <span class="sale">-30%</span> -->
												<span class="new">NEW</span>
											</div>
										</div>
										<div class="product-body">
											<p class="product-category"><?= $data['category'] ?></p>
											<h3 class="product-name"><a href="#"><?= $data['product_name'] ?></a></h3>
											<h4 class="product-price">Rp <?= $data['dealer_prices'] ?>,-</h4>
											<div class="product-rating">
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
											</div>
											<div class="product-btns">
												<button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
												<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
												<button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
											</div>
										</div>
										<div class="add-to-cart">
											<input hidden name='product_id' type='text' value="<?= $data['product_id'] ?>">
											<button class="add-to-cart-btn" type="submit"><i class="fa fa-shopping-cart"></i>Detail!</button>
										</div>
									</div>
								</form>
								<div class="clearfix visible-sm visible-xs"></div>
							</div> 
							<?php } ?>
						</div>
					<!-- /store products -->

					<!-- store bottom filter -->
					<div class="store-filter clearfix">
						<span class="store-qty">Showing 20-100 products</span>
						<ul class="store-pagination">
							<li class="active">1</li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i></a></li>
						</ul>
					</div>
					<!-- /store bottom filter -->
				</div>
				<!-- /STORE -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->

	<!-- NEWSLETTER -->
	<div id="newsletter" class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<div class="newsletter">
						<p>Found a bug / mistakes? <strong>Report!</strong></p>
						<form method="POST">
							<input class="input" type="text" placeholder="Enter your complaint" name="report">
							<button class="newsletter-btn" name="report-button"><i class="fa fa-envelope"></i> Sends Report!</button>
						</form>
						<?php
						require "../includes/db_connect.php";

						if (isset($_POST['report-button'])) {
							$report = $_POST['report'];
							$report_query = "CALL reportsIssue('$id', '$report')";

							$report_sql = mysqli_query($connect, $report_query);
						}
						?>
						<ul class="newsletter-follow">
							<li>
								<a href="#"><i class="fa fa-facebook"></i></a>
							</li>
							<li>
								<a href="#"><i class="fa fa-twitter"></i></a>
							</li>
							<li>
								<a href="#"><i class="fa fa-instagram"></i></a>
							</li>
							<li>
								<a href="#"><i class="fa fa-pinterest"></i></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /NEWSLETTER -->

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