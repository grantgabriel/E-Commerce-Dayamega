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

<title>Laporan Stok</title>
<div id="print">
    <table class='table1'>
        <tr>
            <td><img src='./assets/img/logo.png' height="100" width="100"></td>
            <td>
                <h2>LAPORAN STOK</h2>
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
                            <th width="30">No.</th>
                            <th width= "120">Product ID & Product Name</th>
                            <th width= "40">Stock</th>
                            <th width= "40">Sold Product</th>
                            <th width= "60">User Prices</th>
                            <th width= "60">Dealer Prices</th>
                </tr>
                <?php
                        $data = mysqli_query($conn, "SELECT * FROM stock_report");
                        $q = 0;
                        while ($row = mysqli_fetch_array($data)) {
                            $q++; ?>
                            <tr>
                                <td><center><?php echo $q; ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['product_name'] ?> (<?= $row['product_id'] ?>)</center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['stock'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['sold_products'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['user_prices'] ?></center></td>
                                <td><center>&nbsp;&nbsp;<?= $row['dealer_prices'] ?></center></td>
                            </tr>
                        <?php } ?>
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
