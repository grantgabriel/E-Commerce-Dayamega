<?php  
session_start();
$server = "localhost";
$user = "root";
$pass = "";
$db = "e-commerce-dayamega";

// Koneksi dan Menentukan Database di Server
$conn = mysqli_connect($server, $user, $pass, $db);
if (!$conn) {
    die("Koneksi Gagal: " . mysqli_connect_error());
}
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));

$month_num = $_POST['month_num'];

$total_sales_sql = "SELECT totalMonthlySales($month_num) AS totalSales";
$total_sales_query = mysqli_query($conn, $total_sales_sql);
$totalSales = mysqli_fetch_assoc($total_sales_query);
$totalSales = $totalSales['totalSales'];
?>

<script type="text/javascript">
    window.print()
</script>

<style type="text/css">
    #print {
        margin: 10px;
        text-align: center;
        font-family: "Calibri", Courier, monospace;
        width: 100%;
        font-size: 12px;
    }

    #print .title {
        margin: 20px;
        text-align: right;
        font-family: "Calibri", Courier, monospace;
        font-size: 12px;
    }

    #print span {
        text-align: center;
        font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
        font-size: 18px;
    }

    #print table {
        border-collapse: collapse;
        width: 95%;
        margin: 10px;
    }

    #print .table1 {
        border-collapse: collapse;
        width: 80%;
        text-align: center;
        margin: 10px;
    }

    #print table hr {
        border: 3px double #000;
    }

    #print .ttd {
        float: right;
        width: 250px;
        background-position: center;
        background-size: contain;
    }

    #print table th {
        color: #000;
        font-family: Verdana, Geneva, sans-serif;
        font-size: 12px;
    }

    #logo {
        width: 111px;
        height: 90px;
        padding-top: 10px;
        margin-left: 10px;
    }

    h2,
    h3 {
        margin: 0px 0px 0px 0px;
    }
</style>

<title>Laporan Penjualan</title>
<div id="print">
    <table class='table1'>
        <tr>
            <td><img src='./assets/img/logo.png' height="100" width="100"></td>
            <td>
                <h2>LAPORAN PENJUALAN</h2>
                <h2>PERUSAHAAN DAYAMEGA PRATAMA</h2>
                <p style="font-size:14px;"><i> Jl. koding.com</i></p>
            </td>
        </tr>
    </table>

    <table class='table'>
        <td><hr /></td>
    </table>

    <td><h3></h3></td>
    <tr>
        <td>
            <table border='1' class='table' width="90%">
                <tr>
                            <th width="20">No.</th>
                            <th width= "28">Order ID</th>
                            <th width= "40">Tanggal</th>
                            <th width= "60">Customer</th>
                            <th width= "120">Product ID & Product Name</th>
                            <th width= "65">Alamat</th>
                            <th width= "30">Dealer Prices</th>
                </tr>
                <?php
                        $data = mysqli_query($conn, "SELECT * FROM sales_report WHERE MONTH(order_date) = '$month_num'");
                        $q = 0;
                        while ($row = mysqli_fetch_array($data)) {
                            $q++; ?>
                            <tr>
                                <td><center><?php echo $q; ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['order_id'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['order_date'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['customer_name'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['product_name'] ?> (<?= $row['product_id'] ?>)</center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['delivery_address'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['total'] ?></center></td>
                            </tr>
                        <?php } ?>
                        <tr>
                    <td colspan="7" align="right" style="padding:20px 20px 20px 20px;">
                        <strong>Total Penjualan : <?= $totalSales ?></strong>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</div>

<div id="print">
    <table width="450" align="right" class="ttd">
        <tr>
            <td width="100px" style="padding:20px 20px 20px 20px;" align="center">
                <strong>Dayamega Pratama,</strong>
                <br><br><br><br>
                <strong><u>TTD</u><br></strong><small></small>
            </td>
        </tr>
    </table>
</div>
