$(function(){
  $('.add-space-link').bind('click', function(){
    addToPage(this.rel);
    return(false);
  });
});

var CobotFb = {
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
  },
  
  renderPlans: function(space, plans){
    var $plans = $('#plans'),
    planTemplate = $('#planTemplate').html();
    // welcome text
    $('#welcome').html((new Markdown.Converter()).makeHtml(space.description));

    var display_gross = function(){
      return space.display_price == "gross";
    };

    var gross_price = function(price){
      var tax_multiplier = (1 + parseFloat(space.tax_rate) / 100);
      return (Math.round(tax_multiplier * parseFloat(price)) * 100) / 100.0;
    };

    var price_to_display_price = function(price){
      if(display_gross){
        return gross_price(price);
      } else {
        return price;
      }
    };

    $.each(plans, function(){
      // no hidden plans
      if(!this.hidden){
        this.cycle_costs = function(){
          return this.price_per_cycle > 0;
        };
        this.display_day_pass_price = price_to_display_price(this.day_pass_price);
        this.display_price_per_cycle = price_to_display_price(this.price_per_cycle);
        this.url = space.url + '/users/new?plan_id='+ this.id;
        var planHtml = Mustache.to_html(planTemplate, this);
        $plans.append(planHtml);
        if(FB){
          FB.Canvas.setSize();
        }
      }
    });

  }
};

