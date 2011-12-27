var cobotFb = function(space, plans){
  var $plans = $('#plans'),
  planTemplate = $plans.find(".plan").html();
  $plans.empty();

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
      planHtml = Mustache.to_html(planTemplate, this);
      $plans.append(planHtml);
    }
  });
};


