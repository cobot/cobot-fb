$(function(){
  $('.add-space-link').bind('click', function(){
    CobotFb.addToPage(this.rel);
    return(false);
  });
});

var CobotFb = {
  addToPage: function(space_id) {
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
  },

  renderSpaces: function(spaces){
    var spaceTemplate = $('#spaceTemplate').html();
    var $spaces = $('#spaces');

    var space_id = function(space_url){
      var regex = /api\/spaces\/([\w-]+)/;
      var match = regex.exec(space_url);
      return(match[1]);
    };
    if(spaces.length > 0){
      $.each(spaces, function(){
        this.space_id = space_id(this.space_link);
        var spaceHtml = Mustache.to_html(spaceTemplate, this);
        $spaces.append(spaceHtml);
      });
    }else{
      $('#text').text("Seems you don't manage any coworking spaces via cobot.");
    };
  }
};

