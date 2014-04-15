<?php include('header.php');  ?>

<?php
$name		= array('id'=>'requester_name', 'class'=>'', 'name'=>'requester_name', 'value'=> set_value('requester_name'));
$email		= array('id'=>'requester_email', 'class'=>'', 'name'=>'requester_email', 'value'=>set_value('requester_email'));
$phone		= array('id'=>'requester_phone', 'class'=>'', 'name'=>'requester_phone', 'value'=> set_value('requester_phone'));

?>
<h1>Register server</h1>

<p>Register a server which is gonna act as an identity client.</p>

<?php echo form_open('secure/register'); ?>
     <input type="hidden" name="submitted" value="submitted" />
    <fieldset>
	<legend>About You</legend>
	
	<p>
	    <label for="requester_name">Your name</label><br/>
	    <input class="text" id="requester_name"  name="requester_name" type="text" value="" />
	</p>
	
	<p>
	    <label for="requester_email">Your email address</label><br/>
	    <input class="text" id="requester_email"  name="requester_email" type="text" value="" />
	</p>
    <p>
	    <label for="requester_email">Phone</label><br/>
	    <input class="text" id="requester_phone"  name="requester_phone" type="text" value="" />
	</p>
    <p>
	    <label for="requester_email">Password</label><br/>
	    <input class="text" id="requester_password"  name="requester_password" type="password" value="" />
	</p>
    <p>
	    <label for="requester_email">confirm Password</label><br/>
	    <input class="text" id="confirm"  name="confirm" type="password" value="" />
	</p>
    </fieldset>
      <br />
    <input type="submit" value="Register server" />
</form>
<?php include('footer.php');?>