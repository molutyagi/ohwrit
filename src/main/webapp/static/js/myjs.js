/* 
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
* Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
*/


function doLike(pid, uid) {
	const d = {
		pid: pid,
		uid: uid,
		operation: 'like'
	};

	console.log("dolike ajax")

	$.ajax({
		url: "likeservlet",
		data: d,
		success: function(data, textStatus, jqXHR) {

			console.log(d);
			console.log(data.trim());
			if (data.trim() === 'liked') {

				console.log(d);
				console.log(data.trim());
				let c = $(".like-counter" + pid).html();
				c++;
				$('.like-counter' + pid).html(c);
				$("#liker"+pid).addClass('fa-thumbs-o-down').removeClass('fa-thumbs-o-up')
			} else if (data.trim() === 'disliked') {
				let c = $(".like-counter" + pid).html();
				c--;
				$('.like-counter' + pid).html(c);
				$('#liker'+pid).addClass('fa-thumbs-o-up').removeClass('fa-thumbs-o-down')
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(data);
		}
	});
}