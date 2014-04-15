<?php

class User_model extends CI_Model
{
	
   
	
	function get_user($id)
	{
	    $this->db->where('id', $id);
		$result = $this->db->get('users');
		return $result = $result->row();	
	}
	function login($data)
	{
		$this->db->select('id');
		$this->db->where('email', $data['email']);
		$this->db->where('password',  sha1($data['password']));
		$this->db->limit(1);
		$result = $this->db->get('users');
		if($result)
		{
		   return 	$result->row();
		}
		else 
		{
		    return FALSE;	
		}
	}
	function register_user($customer)
	{
		
		$email = $customer['email'];
		$query = $this->db->get_where('users', array('email' => $email));
		$result	= $query->result();

		foreach ($result as $a)
		{
			
		 $id =	$a->id;
		}
		 
  		if($result){
		
			$this->db->where('id', $id);
			$this->db->update('users', $customer);
			return "already_exists";
		  
	   }
		else
		{
			$this->db->insert('users', $customer);
			return $id  = $this->db->insert_id();
			
		}
	}
	function get_user_id($consumer) {
		
		$this->db->select('osr_usa_id_ref');
		$this->db->where('osr_consumer_key',$consumer['osr_consumer_key']);
		$this->db->where('osr_consumer_secret',$consumer['osr_consumer_secret']);
		$result = $this->db->get('oauth_server_registry');
		$rows = $result->num_rows();
			if($rows > 0)
		{
			return $result->row()->osr_usa_id_ref;
		}	
		else 
			return FALSE;
	}
	
	function get_user_detail($user)
	{
		 $this->db->select('id,name,phone,email');
		 $this->db->where('id',$user['id']);
		 $result = $this->db->get('users');
		 if($result)
		 {
		 	return 	array('id'=>$result->row()->id,'name'=>$result->row()->name,'phone'=>$result->row()->phone,'email'=>$result->row()->email);
		 }
		 else
		 {
		 	return FALSE;
		 }
	}
}