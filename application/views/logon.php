<?php include('header.php'); ?>
<h1>Login</h1>

<?php echo form_open(''); ?>
    <input type="hidden" name="submitted" value="submitted" />
    <input type="hidden" name="allow" value="allow" />

    <label for="email">Email</label><br />
    <input type="text" name="email" id="email" />
    
    <br /><br />

    <label for="password">Password</label><br />
    <input type="password" name="password" id="password" />

    <br /><br />
    
    <input type="submit" value="Login" />
</form>
<?php include('footer.php');?>