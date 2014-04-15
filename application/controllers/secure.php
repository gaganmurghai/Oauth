<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//require APPPATH.'/libraries/REST_Controller.php';

class Secure extends CI_Controller {

   
	function __construct()
	{
		parent::__construct();
		$this->load->library('OAuthClient');
		$this->load->library('form_validation');
	}

    function index()
	{
	  
	    $this->load->view('index');	
	}
	function login()
	{   
	   
	    $oauth_token         =    $this->uri->segment(3);
	    if(!empty($oauth_token))
		echo "Custom Oauth Token : ". $oauth_token; 
		$oauth_callback = urlencode(base64_decode(urldecode($this->uri->segment(4))));
		
		$obj= new OAuthRequest();
		$obj->setParam('oauth_token',$oauth_token,true);
		$obj->setParam('oauth_callback',$oauth_callback,true);
		
	    /************************/
		$db = new PDO('mysql:host=localhost;dbname=Auth_Project', 'localadmin', 'password');
        // Create a new instance of OAuthStore and OAuthServer
        $store = OAuthStore::instance('PDO', array('conn' => $db));
        $server = new OAuthServer();
		
        
        $server->auth_token 	= $oauth_token;
        $server->auth_callback 	= $oauth_callback;
        
		/***********************/
		 $this->load->library('rest', array(
        'server' => site_url().'/api/',
        'http_user' => 'admin',
        'http_pass' => '1234',
        'http_auth' => 'basic' // or 'digest' or 'basic'
		));
		/***********************/
		
	    $this->load->helper('form');
		$data['redirect']	= $this->session->flashdata('redirect');
		
		$submitted 		= $this->input->post('submitted');
		if ($submitted)
		{
			$email		= $this->input->post('email');
			$password	= $this->input->post('password');
			$a['email']          =  $email;
			$a['password']       =  $password;
			/*$redirect	= $this->input->post('redirect');*/
			//$login		= $this->Customer_model->login($email, $password);
			$login_id = $this->rest->get('user_login', $a, 'application/json');
			if ($login_id)
			{
				
				//echo json_encode($login);
				// Check if there is a valid request token in the current request.
				// This returns an array with the consumer key, consumer secret, token,
				// token secret and token type.
				
			
				$allow = array('allow'=>'allow');
				$rs = $server->authorizeVerify();
				//print_r($rs);
				// See if the user clicked the 'allow' submit button (or whatever you choose)
				$authorized = array_key_exists('allow', $allow);
				
				// Set the request token to be authorized or not authorized
				// When there was a oauth_callback then this will redirect to the consumer
				$server->authorizeFinish($authorized, $login_id);
				
			}
			else
			{
				
					$this->session->set_flashdata('redirect', $redirect);
					$this->session->set_flashdata('error', "Login Failed");
					
					redirect('secure/login');
				
			}
		}
		$this->load->view('logon',$data);
	}

	function register()
	{
		
		$db = new PDO('mysql:host=localhost;dbname=Auth_Project', 'localadmin', 'password');
        // Create a new instance of OAuthStore and OAuthServer
        $store = OAuthStore::instance('PDO', array('conn' => $db));
        $server = new OAuthServer();
		
		/***********************/
		 $this->load->library('rest', array(
        'server' => site_url().'/api/',
        'http_user' => 'admin',
        'http_pass' => '1234',
        'http_auth' => 'basic' // or 'digest' or 'basic'
		));
		/***********************/
		
		
		$this->form_validation->set_error_delimiters('<div>', '</div>');
		$data['redirect']	= $this->session->flashdata('redirect');
		
		
		$data['requester_name']	        = '';
		$data['requester_email']		= '';
		$data['requester_phone']		= '';
		$data['requester_password']		= '';
		$data['confirm']		        = '';

		
		$this->form_validation->set_rules('requester_name', 'Name', 'trim|required|max_length[32]');
		$this->form_validation->set_rules('requester_email', 'Email', 'trim|required|valid_email|max_length[128]|callback_check_email');
		$this->form_validation->set_rules('requester_phone', 'Phone', 'trim|required|max_length[32]|numeric');
		$this->form_validation->set_rules('requester_password', 'Password', 'required|min_length[6]|sha1');
		$this->form_validation->set_rules('confirm', 'Confirm Password', 'required|matches[requester_password]');
		
		if ($this->form_validation->run() == FALSE)
		{
			//if they have submitted the form already and it has returned with errors, reset the redirect
			if ($this->input->post('submitted'))
			{
				$data['redirect']	= $this->input->post('redirect');				
			}
			$data['error'] = validation_errors();
			$this->load->view('register', $data);
		}
		else
		{
			$submitted = $this->input->post('submitted');
			if($submitted)
			{
			$save['id']		= false;
			
			$save['name']			    = $this->input->post('requester_name');
			$save['email']				= $this->input->post('requester_email');
			$save['phone']				= $this->input->post('requester_phone');
			$save['password']			= $this->input->post('requester_password');
			$save['created']            = date('Y-m-d');
			
		   
            $user_id = $this->rest->get('register_user', $save, 'application/json');
		    if(!empty($user_id))
		    {
			$key = $store->updateConsumer(array("requester_name"=>$save['name'],"requester_email"=>$save['email']), $user_id, true);
            $c = $store->getConsumer($key, $user_id);
			$c_key = $c['consumer_key'];
            $c_sec = $c['consumer_secret']; 
			$result['consumer'] = array('user_id'=>$user_id,'consumer_key'=>$c_key,'consumer_sec'=>$c_sec);
			
			$this->load->view('view_keys', $result);
		    }
		    else 
		    
		    {
		        $this->session->set_flashdata('error', "Email Already Exists");
		    	redirect('secure/register'); }
			
			}// end post submit
			//echo json_encode($result);
			
			
			
			//we're just going to make this secure regardless, because we don't know if they are
			//wanting to redirect to an insecure location, if it needs to be secured then we can use the secure redirect in the controller
			//to redirect them, if there is no redirect, the it should redirect to the homepage.
			//redirect($redirect);
		}
            
            	
		
	}
	
	function request_token()
	{
		define('OAUTH_HOST',site_url('secure'));
		
		/***********************/
		$this->load->library('rest', array(
				'server' => site_url().'/api/',
				'http_user' => 'admin',
				'http_pass' => '1234',
				'http_auth' => 'basic' // or 'digest' or 'basic'
		));
		/***********************/ 
		
			 if (empty($_GET['oauth_token'])) {
		 	
		 	$this->form_validation->set_error_delimiters('<div>', '</div>');
		 	$data['consumer_secret']	= '';
		 	$data['consumer_key']		= '';
		 	
		 	$this->form_validation->set_rules('consumer_key', 'Consumer Key', 'trim|required');
		 	$this->form_validation->set_rules('consumer_sec_key', 'Consumer Secret Key', 'trim|required');
		 	
		 	if ($this->form_validation->run() == FALSE)
		 	{
		 		
		 		
		 		//if they have submitted the form already and it has returned with errors, reset the redirect
		 		if ($this->input->post('submitted'))
		 		{
		 			$data['redirect']	= $this->input->post('redirect');
		 		}
		 		$data['error'] = validation_errors();
		 		$this->load->view('request_token', $data);
		 	}
		 	else {
		 		
		 		$options['consumer_secret']	    = $this->input->post('consumer_sec_key');
		 		$options['consumer_key']		= $this->input->post('consumer_key');
		 		
		 		$result = $this->rest->get('register_user_id', $options, 'application/json'); 
		 	    if( $result->status ==  0)
		 	    {
		 	    	$this->session->set_flashdata('error', "There is no existing user for this set of key's !!!");
		 	    	redirect('secure/request_token'); 	    	
		 	    }
		 	    $id  = $result->value;
		 	$options = array(
		 			'consumer_key' => $this->input->post('consumer_key'),
		 			'consumer_secret' => $this->input->post('consumer_sec_key'),
		 			'server_uri' => OAUTH_HOST,
		 			'request_token_uri' => OAUTH_HOST . '/request_tokens',
		 			'authorize_uri' => OAUTH_HOST . '/login',
		 			'access_token_uri' => OAUTH_HOST . '/access_token'
		 	);
		 	
		 	OAuthStore::instance('Session', $options);
	
	     $tokenResultParams = OAuthRequester::requestRequestToken($options['consumer_key'], $id);	
	    
	     $this->session->set_userdata(array('id'=>$id,'token_secret'=>$tokenResultParams['token_secret'],'consumer_secret'=>$this->input->post('consumer_sec_key')));
		 $oauth_token  =  $tokenResultParams['token'];
		 $callback_url =  base64_encode(urlencode(OAUTH_HOST.'/request_token'));
		 redirect("secure/login/$oauth_token/$callback_url");
		
		     }//end else
		 }
		 else{
		 	
		 	echo "abc";
		 	
		 	$id = $this->session->userdata('id');
		 	$consumer_sec_key =  $this->session->userdata('consumer_secret');
		 	$token_sec                =  $this->session->userdata('token_secret');
		 	$oauthToken = $_GET['oauth_token'];
		 	$consumer_key = $_GET['consumer_key'];
		 	$tokenResultParams = $_GET;
	
		 	$options = array(
		 			'consumer_key' => $consumer_key,
		 			'consumer_secret' => $consumer_sec_key,
		 			'server_uri' => OAUTH_HOST,
		 			'request_token_uri' => OAUTH_HOST . '/request_tokens',
		 			'authorize_uri' => OAUTH_HOST . '/login',
		 			'access_token_uri' => OAUTH_HOST . '/access_token'
		 	);
		 	
		 	OAuthStore::instance('Session', $options);
		 	
		 	OAuthRequester::requestAccessToken($consumer_key,$tokenResultParams['oauth_token'],$token_sec, $id, 'POST', $_GET);
		   
		 	$request = new OAuthRequester(OAUTH_HOST . '/test_request', 'GET', $tokenResultParams);
		 
		 	$result = $request->doRequest($id);
		 	
		 	if ($result['code'] == 200) {
		 		//var_dump($result['body']);
		 		$option['id'] =  $this->session->userdata('id');
		 		$result = $this->rest->get('register_user_value', $option, 'application/json');
		 		var_dump($result);
		 	}
		 	else {
		 		echo 'Error';
		 	}
		 	
		 }
		 
		
	}
	
	function request_tokens()
	{
		$db = new PDO('mysql:host=localhost;dbname=Auth_Project', 'localadmin', 'password');
        // Create a new instance of OAuthStore and OAuthServer
        $store = OAuthStore::instance('PDO', array('conn' => $db));
        $server = new OAuthServer();
		
		$server->requestToken();
	}
	
	function access_token()
	{
		$db = new PDO('mysql:host=localhost;dbname=Auth_Project', 'localadmin', 'password');
        // Create a new instance of OAuthStore and OAuthServer
        $store = OAuthStore::instance('PDO', array('conn' => $db));
        $server = new OAuthServer();
		
		$server->accessToken();
	}
	
	function test_request()
	{
	
		if (OAuthRequestVerifier::requestIsSigned()) {
			try {
			
			   
				$req = new OAuthRequestVerifier();
				
				$id = $req->verify();
		        
				// If we have an ID, then login as that user (for this requeste
				if ($id) {
					echo 'Hello ' . $id;
				}
			}
			catch (OAuthException $e) {
				// The request was signed, but failed verification
				header('HTTP/1.1 401 Unauthorized');
				header('WWW-Authenticate: OAuth realm=""');
				header('Content-Type: text/plain; charset=utf8');
		
				echo $e->getMessage();
				exit();
			}
		}	
		
		
	
	}
	/*function get_user()
	{
		$id = 1;
		$new_name = "Syed Ammar Tariq";
		$new_email = "trq_syd@yahoo.co.in";
		$this->load->library('rest', array(
        'server' => 'http://localhost/ci_rest_oauth/index.php/api/',
        'http_user' => 'admin',
        'http_pass' => '1234',
        'http_auth' => 'basic' // or 'digest' or 'basic'
		));
		$a = array(
		'id'   => $id,
        'name' => $new_name,
        'email' => $new_email
        );
		$user = $this->rest->get('save_user', $a, 'application/json');
		echo $this->rest->debug();
		//echo $user->name; 
		var_dump($user);
	}*/
}
