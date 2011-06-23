<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');


if(!class_exists('CI_Model')) { class CI_Model extends Model {} }


class list_model extends CI_Model {

function getWarehouses() {
	$this->db->distinct();
	$this->db->select('warehouse');	
	return $this->db->get('equipment')->result();
}


function getByWarehouse($warehouse) {
	$this->db->where('warehouse', $warehouse);
	$this->db->order_by('name');
	return $this->db->get("equipment")->result();
}


function getDisks($warehouse,$name,$ip) {
	$this->db->where('warehouse', $warehouse);
	$this->db->where('name', $name);
	$this->db->where('ip', $ip);
	return $this->db->get('disks')->result();
}

function getSoftware($warehouse, $name, $ip) {
	$this->db->where('warehouse', $warehouse);
	$this->db->where('name', $name);
	$this->db->where('ip', $ip);
	return $this->db->get('software')->result();

}
	


}

