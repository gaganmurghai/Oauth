<?php
require(APPPATH.'/libraries/REST_Controller.php');
 
class Api extends REST_Controller
{
	function __construct()
	{
		parent::__construct();
		$this->load->library('OAuthClient');
		$this->load->model('user_model');
		
	}
   
  
    function user_get()
    {
        if(!$this->get('id'))
        {
            $this->response(array('error' => 'User not found.'), 400);
        }
 
        $user = $this->user_model->get_user( $this->get('id') );
         
        if($user)
        {
            $this->response($user, 200); // 200 being the HTTP response code
        }
 
        else
        {
            $this->response(array('error' => 'User not found.'), 404);
        }
    }
    function user_login_get()
	{
		  $data['email']			= $this->get('email');
		  $data['password']			= $this->get('password');
		  $result = $this->user_model->login($data);
		  if($result === FALSE)
		  {
			  $this->response(array('status' => 'login failed'),404);
		  }
		  else
		  {
			  $this->response($result,200);
		  }
	}
	function register_user_get()
	{
		$data['id']                 = $this->get('id');
		$data['name']			    = $this->get('name');
		$data['email']				= $this->get('email');
		$data['phone']				= $this->get('phone');
		$data['password']			= $this->get('password');
		$data['created']            = date("Y-m-d H:i:s");  
		
		$result = $this->user_model->register_user($data);
		if($result === FALSE)
        {
            $this->response(array('status' => 'failed'),404);
        }
       else if($result === "already_exists")  
       {
       	
       	    $this->response(array(),200);
       }
        else
        {			
            $this->response($result,200);
        }
		
	}
    function register_user_id_get()
    {
    	
    	$data['osr_consumer_key']     = $this->get('consumer_key');
    	$data['osr_consumer_secret']  = $this->get('consumer_secret');
    	
    	$result = $this->user_model->get_user_id($data);
    	
    	if($result === FALSE)
    		{
    			$this->response(array('status'=>'0'),404);
    		}
    	else 
    	    {
    	    	$this->response(array('status'=>'1','value'=>$result),200);
    	    }
    }
    
    function register_user_value_get()
    {
    	 $data['id'] = $this->get('id');
    	 $result  = $this->user_model->get_user_detail($data);
    	 if($result === FALSE)
    	 {
    	 	$this->response(array('status' => 'login failed'),404);
    	 }
    	 else
    	 {
    	 	$this->response($result,200);
    	 }
    	
    }
 
}
?>