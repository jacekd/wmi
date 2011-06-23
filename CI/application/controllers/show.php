<?php 

class Show extends CI_Controller {

public function index() 
	{
		$this->load->model('list_model');
		$warehouses = $this->list_model->getWarehouses();
		$data['body'] = '';
		$data['jquery'] = '';
		foreach($warehouses as $warehouse_data) 
		{
			$warehouse = $warehouse_data->warehouse;
			$data['jquery'] .= '$("#equipment_acordeon_'. $warehouse .'").accordion({ header: "h3" });';
			$data['body'] .= '<h2 class="warehouseTitle">' . $warehouse .'</h2>';
			$data['body'] .= '<div id="equipment_acordeon_' . $warehouse . '">';
			$equipment = $this->list_model->getByWarehouse($warehouse);
			foreach($equipment as $equipment_data)
			{
				$equipment_table = '
					<div>
						<h3><a href="#">' . $equipment_data->name . '</a></h3>
							<div>
							<table id="equipment_data">
								<tr><td><b>IP</b></td><td>' . $equipment_data->ip . '</td></tr>
								<tr><td><b>Domain</b></td><td>' . $equipment_data->domain . '</td></tr>
								<tr><td><b>Manufacturer</b></td><td>' . $equipment_data->manufacturer . '</td></tr>
								<tr><td><b>Model</b></td><td>' . $equipment_data->model . '</td></tr>
								<tr><td colspan="2"><hr><i>Operating System Information<i></td></tr>
								<tr><td><b>OS Name</b></td><td>' . $equipment_data->os_caption . '</td></tr>
								<tr><td><b>OS Build Number</b></td><td>' . $equipment_data->os_buildnum . '</td></tr>
								<tr><td><b>OS Processor type</b></td><td>' . $equipment_data->os_build . '</td></tr>
								<tr><td><b>OS Serial Number</b></td><td>' . $equipment_data->os_serialnumber . '</td></tr>
				';
					// Disks data
					$disks = $this->list_model->getDisks($equipment_data->warehouse, $equipment_data->name, $equipment_data->ip);
				$equipment_table .= '<tr><td colspan="2"><hr><i>Disks Information</i></td></tr>
							<tr><td colspan="2">';
					$disk_table = '
							<table> 
							<tr><th>Device ID</th><th>File System Type</th><th>Serial Number</th><th>Size</th><th>Free Space</th><tr>
					';
					foreach($disks as $disks_data) 
					{
					$disk_table .= '
								<tr><td>' . $disks_data->device_id . '</td><td>' . $disks_data->file_system . '</td><td>' . $disks_data->serial_number . '</td><td>' . $disks_data->size . '</td><td>' . $disks_data->free_space . '</td></tr>
					';	
					}
					$disk_table .= '
							</table>
					';
				$equipment_table .= ''. $disk_table . '</td></tr>';
					// Software data 
					$software  = $this->list_model->getSoftware($equipment_data->warehouse, $equipment_data->name, $equipment_data->ip);
				$equipment_table .= '<tr><td colspan="2"><hr><i>Software Information</i></td></tr>
							<tr><td colspan="2">';
					$software_table = '
						<table>
						<tr><th>Vendor</th><th>Software Name</th><th></th></tr>	
					';
					$software_details = '';
					foreach($software as $software_data)
					{
					$software_table .= '
						<tr><td> ' . $software_data->vendor . '</td><td>' . $software_data->sname . '</td><td><p><a href="#" id="dialog_link_' . $software_data->id . '" class="ui-state-default ui-corner-all dialog_linking"><span class="ui-icon ui-icon-newwin"></span>Software Details</a></p></td></tr>

					';
					// JQUERY 
					$data['jquery'] .= "$('#dialog_" . $software_data->id ."').dialog({ autoOpen: false, width: 650 });";
					$data['jquery'] .= "$('#dialog_link_" . $software_data->id ."').click(function() { $('#dialog_" . $software_data->id ."').dialog('open'); return false; });";
					$software_details .= '
						<div id="dialog_' . $software_data->id . '" title="' . $equipment_data->name . '::' . $software_data->sname . '">
						<p>
							<table>
							<tr><td><b>Description</b></td><td>' . $software_data->description . '</td></tr>
							<tr><td><b>Install Date</b></td><td>' . $software_data->install_date . '</td></tr>
							<tr><td><b>Install Location</b></td><td>' . $software_data->install_location . '</td></tr>
							<tr><td><b>Package Code</b></td><td>' . $software_data->package_code . '</td></tr>
							<tr><td><b>Product ID</b></td><td>' . $software_data->product_id . '</td></tr>
							<tr><td><b>Registration Owner</b></td><td>' . $software_data->reg_owner . '</td></tr>
							<tr><td><b>Registration Company</b></td><td>' . $software_data->reg_company . '</td></tr>
							<tr><td><b>Software URL</b></td><td><a href="' . $software_data->url_info_about . '" target="_blank">' . $software_data->url_info_about . '</a></td></tr>
							</table>
						</p>
						</div>
						';	
					}
					$software_table .= '
							</table>
						</div>
					';
				$equipment_table .= ''. $software_table . '</td></tr>';
				$equipment_table .= '
							</table>
							</div>
					</div>
				';
				$data['body'] .= $equipment_table;	
				$data['body'] .= $software_details;
			}
			$data['body'] .= '</div>';
		}
		// Generate view
		$this->load->view('show', $data);
	}

}

?>
