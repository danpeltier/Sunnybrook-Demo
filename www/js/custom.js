// JavaScript Document

var animating = 0;
var flashcount = 0;
var checking = 0;

function toggleNav(){
	if(animating == 0){
		animating = 1;
		if($(".navbar").position().top < 0){
			$(".navbar").animate({"top":"0px"},500,function(){
				animating = 0;
			});
		}
		else{
			$(".navbar").animate({"top":"-120px"},500,function(){
				animating = 0;
			});
		}
	}
}

$(".logo-spacer").on("mouseover",function(){
	toggleNav();
});

// when page loads, make users notice the remote control

var flashy = setInterval(function(){
	$(".remote-control").css({"border-color":"#ff0000","box-shadow": "0 6px 12px 0 rgba(255, 0, 0, 0.3), 0 10px 20px 0 rgba(255, 0, 0, 0.29)"});
	setTimeout(function(){
		$(".remote-control").css({"border-color":"#999999","box-shadow": "0 6px 12px 0 rgba(0, 0, 0, 0.3), 0 10px 20px 0 rgba(0, 0, 0, 0.29)"});
		flashcount ++;
		if(flashcount > 5){
			clearInterval(flashy);
		}
	},500);
},1000);
$(".remote-control").animate({"bottom":"15px"},3000);

$(".navbar-toggler").click(function(){
	if($(window).width() < 992){
		if($(".navbar").height() > 250){
			setTimeout(function(){
				$(".navbar").animate({"height":"110px"},500);
				$(".logo").fadeIn(1000);
			},50);
		}
		else{
			$(".logo").fadeOut(100);
			$(".navbar").animate({"height":"300px"},200);
		}
	}
});

function toggleSearch(){
	if($("#search-form").hasClass("d-none")){
		$("#search-icon").addClass("d-none");
		$("#search-form").removeClass("d-none");
	}
	else{
		$("#search-icon").removeClass("d-none");
		$("#search-form").addClass("d-none");
	}
}

$(".dropdown-toggle").click(function(){
	if(!$("#search-form").hasClass("d-none")){
		toggleSearch();
	}
});

function showCheckmark(obj){
	if(checking == 0){
		checking = 1;
		console.log("showing checkmark");
		$(obj + " .check-cover").animate({"width":"101%"},400,function(){
			$(obj + " .progress-bar").css({"display":"none"});
			$(obj).css({"background-image":"url('images/checkmark.png')"});
			$(obj + " .check-cover").animate({"width":"1%"},400,function(){
				console.log($(obj.replace("holder","status")).html().toString().trim());
				checking = 0;
				if($(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Not Available" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Weak" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Passwords DO NOT Match" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Password not entered" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Not a valid email address"){
					setTimeout("showXmark('" + obj + "')",100);
				}
			});
		});
	}
}

function showXmark(obj){
	if(checking == 0){
		checking = 1;
		console.log("showing xmark");
		$(obj + " .check-cover").animate({"width":"101%"},400,function(){
			$(obj + " .progress-bar").css({"display":"none"});
			$(obj).css({"background-image":"url('images/xmark.png')"});
			$(obj + " .check-cover").animate({"width":"1%"},400,function(){
				console.log($(obj.replace("holder","status")).html().toString().trim());
				checking = 0;
				if($(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Available" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Strong" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Medium" || $(obj.replace("holder","status")).html().toString().replace("&nbsp;","").trim() == "Passwords Match"){
					setTimeout("showCheckmark('" + obj + "')",100);
				}
			});
		});
	}
}

function showProgress(obj){
	$(obj + " .progress-bar").css({"display":"block"});
	$(obj + " .check-cover").css({"width":"1%"});
}

function hideProgress(obj){
		$(obj + " .progress-bar").css({"display":"none"});
}

if($("#reg-btn").length){
	setInterval(function(){
		var d = 0;
		if($("#fname").length){
			if($("#fname").val().replace("&nbsp;","").trim() == "") d = 1;
			if($("#lname").val().replace("&nbsp;","").trim() == "") d = 2;
			if($("#emailaddr-status").html().replace("&nbsp;","").trim() != "Available") d = 3;
			if($("#uname-status").html().replace("&nbsp;","").trim() != "Available") d = 4;
		}
		if($("#pword-status").html().replace("&nbsp;","").trim() != "Strong" && $("#pword-status").html().replace("&nbsp;","").trim() != "Medium") d = 5;
		if($("#cpword-status").html().replace("&nbsp;","").trim() != "Passwords Match") d = 6;
		
		if(d > 0){
			$("#reg-btn").attr("disabled",true);
		}
		else{
			$("#reg-btn").removeAttr("disabled");
		}
		
	},100);
}
