<?php include('header.php'); ?>
<h1>Get Oauth Token</h1>

<?php echo form_open(''); ?>
    <input type="hidden" name="allow" value="allow" />
    <input type="hidden" name="submitted" value="submitted" />
    <label for="consumer_key">Consumer Key</label>
    <input type="text" name="consumer_key" id="consumer_key" size="64" value="" />
    <br />
    <label for="consumer_key">Consumer Secret Key</label>
    <input type="text" name="consumer_sec_key" id=
    "consumer_sec_key" size="64" value="" /><br/>
    
    <input type="submit" value="Submit" />
</form>
<?php include('footer.php');?>