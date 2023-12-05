<?php
require "../includes/db_connect.php";

$id = $_SESSION['id'];

$sql = "SELECT * FROM users WHERE user_id = '$id'";
$query = mysqli_query($connect, $sql);

if (!$query) {
	die("Query gagal" . mysqli_error($connect));
}

while ($row = mysqli_fetch_array($query)) {
	$name = $row['name'];
	$email = $row['email'];
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="../assets/img/dayamega.jpeg">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Dayamega's E-Commerce</title>

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
					<li>
						<form action="" method="post" onsubmit="return confirm('Anda Yakin Mau Menghapus Akun?');">
							<button style="all: unset; color: white;" name="delete-account" type="submit"><i class="fa fa-user-o"></i> 
								<?= $name ?> 
							</button>
						</form>
						<?php
							if(isset($_POST['delete-account'])) {
								require "../includes/db_connect.php";
							
								$delete_acc = "CALL deleteCustomers('$id')";
								$delete_acc_query = mysqli_query($connect, $delete_acc);
								echo '<script>window.location.href = "../index.php";</script>';
							}
						?>
					</li>
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
							<form method="POST" action="search.php">
								<select class="input-select">
									<!-- <option value="0">All Categories</option>
									<option value="1">Category 01</option>
									<option value="1">Category 02</option> -->
								</select>
								<input class="input" name="product_name_search" type="text" placeholder="Search here">
								<button class="search-btn" name="search-button" type="submit">Search</button>
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
								<a class="dropdown-toggle" href="orders.php" aria-expanded="true">
									<i class="fa fa-shopping-cart"></i>
									<span>Your Purchase</span>
									<div class="qty">1</div>
								</a>
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
					<li class="active"><a href="#">Home</a></li>
					<li><a href="products.php">Products</a></li>
					<li><a href="#">Categories</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- shop -->
				<div class="col-md-4 col-xs-6">
					<div class="shop">
						<div class="shop-img">
							<img src="./img/shop01.png" alt="">
						</div>
						<div class="shop-body">
							<h3>Laptop<br>Collection</h3>
							<a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
				</div>
				<!-- /shop -->

				<!-- shop -->
				<div class="col-md-4 col-xs-6">
					<div class="shop">
						<div class="shop-img">
							<img src="./img/shop03.png" alt="">
						</div>
						<div class="shop-body">
							<h3>Accessories<br>Collection</h3>
							<a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
				</div>
				<!-- /shop -->

				<!-- shop -->
				<div class="col-md-4 col-xs-6">
					<div class="shop">
						<div class="shop-img">
							<img src="./img/shop02.png" alt="">
						</div>
						<div class="shop-body">
							<h3>Others<br>Collection</h3>
							<a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
				</div>
				<!-- /shop -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">

				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h3 class="title">New Products</h3>
						<div class="section-nav">
							<ul class="section-tab-nav tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">Laptops</a></li>
								<li><a data-toggle="tab" href="#tab1">Accessories</a></li>
								<li><a data-toggle="tab" href="#tab1">Others</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /section title -->

				<!-- Products tab & slick -->
				<div class="col-md-12">
					<div class="row">
						<div class="products-tabs">
							<!-- tab -->
							<div id="tab1" class="tab-pane active">
								<div class="products-slick" data-nav="#slick-nav-1">

									<?php
									require "../includes/db_connect.php";

									$product_carousel_sql = "SELECT * FROM product_carousels";
									$product_carousel_query = mysqli_query($connect, $product_carousel_sql);

									while ($data = mysqli_fetch_assoc($product_carousel_query)) {
									?>
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
									<?php } ?>

								</div>
								<div id="slick-nav-1" class="products-slick-nav"></div>
							</div>
							<!-- /tab -->
						</div>
					</div>
				</div>
				<!-- Products tab & slick -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->

	<!-- HOT DEAL SECTION -->
	<div id="hot-deal" class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<div class="hot-deal">
						<ul class="hot-deal-countdown">
							<li>
								<div>
									<h3>00</h3>
									<span>Days</span>
								</div>
							</li>
							<li>
								<div>
									<h3>00</h3>
									<span>Hours</span>
								</div>
							</li>
							<li>
								<div>
									<h3>00</h3>
									<span>Mins</span>
								</div>
							</li>
							<li>
								<div>
									<h3>00</h3>
									<span>Secs</span>
								</div>
							</li>
						</ul>
						<h2 class="text-uppercase">hot deal this week</h2>
						<p>Selebrasi Presentasi Tubes 🥳</p>
						<a class="primary-btn cta-btn" href="#">Shop now</a>
					</div>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /HOT DEAL SECTION -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-4 col-xs-6">
					<div class="section-title">
						<h4 class="title">Top selling YOGA</h4>
						<div class="section-nav">
							<div id="slick-nav-3" class="products-slick-nav"></div>
						</div>
					</div>
					<div class="products-widget-slick" data-nav="#slick-nav-3">
						<div>
							<?php
							require "../includes/db_connect.php";

							$thinkpad_sql = "SELECT * FROM product_by_popularity WHERE category = 'YOGA' LIMIT 3";
							$thinkpad_query = mysqli_query($connect, $thinkpad_sql);

							while ($data = mysqli_fetch_assoc($thinkpad_query)) {
							?>
								<div class="product-widget">
									<div class="product-img">
										<img src="../media/laptop-photos/<?= $data['photo'] ?>" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Sold: <b><?= $data['sold_products'] ?></b> </p>
										<h3 class="product-name"><?= $data['product_name'] ?></h3>
										<h4 class="product-price">Rp<?= $data['dealer_prices'] ?>,- <del class="product-old-price">Rp <?= $data['user_prices'] ?>,-</del></h4>
									</div>
								</div>
							<?php } ?>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-xs-6">
					<div class="section-title">
						<h4 class="title">Top selling ThinkPad</h4>
						<div class="section-nav">
							<div id="slick-nav-4" class="products-slick-nav"></div>
						</div>
					</div>
					<div class="products-widget-slick" data-nav="#slick-nav-4">
						<div>
							<?php
							require "../includes/db_connect.php";

							$thinkpad_sql = "SELECT * FROM product_by_popularity WHERE category = 'ThinkPad' LIMIT 3";
							$thinkpad_query = mysqli_query($connect, $thinkpad_sql);

							while ($data = mysqli_fetch_assoc($thinkpad_query)) {
							?>
								<div class="product-widget">
									<div class="product-img">
										<img src="../media/laptop-photos/<?= $data['photo'] ?>" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Sold: <b><?= $data['sold_products'] ?></b> </p>
										<h3 class="product-name"><?= $data['product_name'] ?></h3>
										<h4 class="product-price">Rp<?= $data['dealer_prices'] ?>,- <del class="product-old-price">Rp <?= $data['user_prices'] ?>,-</del></h4>
									</div>
								</div>
							<?php } ?>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-xs-6">
					<div class="section-title">
						<h4 class="title">Top selling IdeaPad</h4>
						<div class="section-nav">
							<div id="slick-nav-4" class="products-slick-nav"></div>
						</div>
					</div>
					<div class="products-widget-slick" data-nav="#slick-nav-4">
						<div>
							<?php
							require "../includes/db_connect.php";

							$thinkpad_sql = "SELECT * FROM product_by_popularity WHERE category = 'IdeaPad' LIMIT 3";
							$thinkpad_query = mysqli_query($connect, $thinkpad_sql);

							while ($data = mysqli_fetch_assoc($thinkpad_query)) {
							?>
								<div class="product-widget">
									<div class="product-img">
										<img src="../media/laptop-photos/<?= $data['photo'] ?>" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Sold: <b><?= $data['sold_products'] ?></b> </p>
										<h3 class="product-name"><?= $data['product_name'] ?></h3>
										<h4 class="product-price">Rp<?= $data['dealer_prices'] ?>,- <del class="product-old-price">Rp <?= $data['user_prices'] ?>,-</del></h4>
									</div>
								</div>
							<?php } ?>
						</div>
					</div>
				</div>
			</div>

			<div class="clearfix visible-sm visible-xs"></div>

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