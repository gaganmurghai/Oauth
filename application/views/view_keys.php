<?php include('header.php'); ?>
<h3>Please keep these keys for future use!!!</h3>
<label for="consumer_key">Consumer  Key</label>
<?php echo " : ".$consumer['consumer_key'];?><br/>
<label for="consumer_key">Consumer Secret Key</label>
<?php echo " : ".$consumer['consumer_sec']?><br><br>
<a href="<?php echo site_url('secure/request_token')?>">Get OAuth Token</a>
<?php include('footer.php');?>