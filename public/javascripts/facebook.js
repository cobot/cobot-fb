
window.fbAsyncInit = function() {
  // init the FB JS SDK
  FB.init({
    appId: '108253272618609',
    status: true,
    cookie: true,
    version: 'v2.0'
  });
  FB.Canvas.setSize();
};

function addToPage(space_id) {
  var obj = {
    method: 'pagetab'
  };
  FB.ui(obj, function(response) {
    if (response != null && response.tabs_added != null) {
      console.log(response);
      $.each(response.tabs_added, function(page_id) {
        $.post('/spaces',{page_id: page_id, space_id: space_id}, function(){
          window.open('https://www.facebook.com/pages/random/'+page_id+'?v=app_108253272618609','_blank');
        });
      });
    }
  });
}

// Load the SDK asynchronously
(function(d, s, id){
   var js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement(s); js.id = id;
   js.src = "//connect.facebook.net/en_US/all.js";
   fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk'));
