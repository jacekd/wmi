<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Network Audit report - BOND TM</title>
	<link type="text/css" href="<?php echo base_url(); ?>resources/jqueryui/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" />	
	<script type="text/javascript" src="<?php echo base_url(); ?>resources/jqueryui/js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="<?php echo base_url(); ?>resources/jqueryui/js/jquery-ui-1.8.13.custom.min.js"></script>
	<script type="text/javascript">
			$(function(){

				// Accordion
				<?php echo $jquery; ?>
			});
	</script>
	<style type="text/css">
	body{ font: 62.5% "Trebuchet MS", sans-serif; margin: 50px;}
	.warehouseTitle { margin-top: 2em; }
	#logo { margin: 0 auto; position: absolute; top: 0px; left: 75%;  height: 150px; display: block;}
	#content { margin-top: 120px; }
	.dialog_linking {padding: .2em 1em .2em 20px;text-decoration: none;position: relative; font-size: 9px; }
	.dialog_linking span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
	ul#icons {margin: 0; padding: 0;}
	ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
	ul#icons span.ui-icon {float: left; margin: 0 4px;}
	hr { color: #79b7e7; height: 1px; width: 80%; }
	table { width: 90%; margin 0 auto; }
	table th { text-align: left; }
	table tr td , table tr th { font-size: 13px; }
	</style>
<body>
<div id="logo"><img src="<?php echo base_url(); ?>/resources/logo.png"></div>
<div id="content">

	<?php echo $body; ?>
</div>	
</body>
</html>
