<?php
session_start();
include_once("config.php");

//empty cart by distroying current session
if(isset($_GET["emptycart"]) && $_GET["emptycart"]==1)
{
	session_destroy();
}

//add item in shopping cart
if(isset($_POST["type"]) && $_POST["type"]=='add')
{
	$id			 	= filter_var($_POST["id"], FILTER_SANITIZE_STRING); //product code
	$cota 			= filter_var($_POST["cota"], FILTER_SANITIZE_STRING); //product code
	$echipa 		= filter_var($_POST["echipa"], FILTER_SANITIZE_NUMBER_INT); //product code
	$return_url 	= base64_decode($_POST["return_url"]); //return url

	//MySqli query - get details of item from db using product code
	$results = $mysqli->query("SELECT * FROM pari_edit WHERE id='$id'");
	$obj = $results->fetch_object();
	
	if ($results) { //we have the product info 
		
		//prepare array for the session variable
		$new_product = array(array('id'=>$obj->id, 'clan1'=>$obj->clan1, 'clan2'=>$obj->clan2, 'code'=>$id, 'cota'=>$cota, 'echipa'=>$echipa, 'price'=>$obj->price));
		
		if(isset($_SESSION["products"])) //if we have the session
		{
			$found = false; //set found item to false
			
			foreach ($_SESSION["products"] as $cart_itm) //loop through session array
			{
				if($cart_itm["id"] == $id){ //the item exist in array

					$product[] = array('id'=>$id, 'clan1'=>$cart_itm["clan1"], 'clan2'=>$cart_itm["clan2"], 'cota'=>$cota, 'echipa'=>$echipa);
					$found = true;
				}else{
					//item doesn't exist in the list, just retrive old info and prepare array for session var
					$product[] = array('id'=>$cart_itm["id"], 'clan1'=>$cart_itm["clan1"], 'clan2'=>$cart_itm["clan2"], 'cota'=>$cart_itm["cota"], 'echipa'=>$cart_itm["echipa"]);
				}
			}
			
			if($found == false) //we didn't find item in array
			{
				//add new user item in array
				$_SESSION["products"] = array_merge($product, $new_product);
			}else{
				//found user item in array list, and increased the quantity
				$_SESSION["products"] = $product;
			}
			
		}else{
			//create a new session var if does not exist
			$_SESSION["products"] = $new_product;
		}
		
	}
	
	//redirect back to original page
	header('Location:'.$return_url);
}

//remove item from shopping cart
if(isset($_GET["removep"]) && isset($_GET["return_url"]) && isset($_SESSION["products"]))
{
	$id 			= $_GET["removep"]; //get the product code to remove
	$return_url 	= base64_decode($_GET["return_url"]); //get return url

	
	foreach ($_SESSION["products"] as $cart_itm) //loop through session array var
	{
		if($cart_itm["id"]!=$id){ //item does,t exist in the list
			$product[] = array('id'=>$cart_itm["id"], 'clan1'=>$cart_itm["clan1"], 'clan2'=>$cart_itm["clan2"], 'cota'=>$cart_itm["cota"], 'echipa'=>$cart_itm["echipa"]);
		}
		
		//create a new product list for cart
		$_SESSION["products"] = $product;
	}
	
	//redirect back to original page
	header('Location:'.$return_url);
}
?>