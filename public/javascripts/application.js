var cobotFb = function(plans){
  var $plans = $('#plans'),
  planTemplate = $plans.find(".plan").html();
  $plans.empty();
  $.each(plans, function(){
    // no hidden plans
    if(!this.hidden){
      this.cycle_costs = function(){
        return this.price_per_cycle > 0;
      };
      console.log(this);
      planHtml = Mustache.to_html(planTemplate, this);
      $plans.append(planHtml);
    }
  });

};


