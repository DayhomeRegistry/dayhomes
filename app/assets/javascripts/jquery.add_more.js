function add_another_mangement() {
  delete_button_check();
  
  $('.add_multiples_link').click(function(){
    var data_group = $(this).attr('data-group');
    var attribute_key = $(this).attr('data-attribute-key');
    var new_object_id = new Date().getTime();
    var new_elem = $('.add_multiples[data-group='+data_group+']:visible').last().clone(true).insertAfter($('.add_multiples[data-group='+data_group+']:last'));
    var attribute_re = new RegExp("\\["+attribute_key+"\\]\\[([0-9])+\\]");
          
    // clear out textareas
    $('.add_multiples[data-group='+data_group+']:last textarea').each(function(){
      $(this).text('');
      $(this).attr('name', $(this).attr('name').replace(attribute_re, '['+attribute_key+']['+new_object_id+']'));
    });
    
    // When you add another row - remove stuff you no want
    $('.add_multiples[data-group='+data_group+']:last .remove_contents').each(function(){
      $(this).remove();
    });
    
    
    // Clear out inputs
    $('.add_multiples[data-group='+data_group+']:last input').each(function(){
      if(!$(this).attr('type').match(/radio|check/)) $(this).attr('value', '');
      $(this).attr('name', $(this).attr('name').replace(attribute_re, '['+attribute_key+']['+new_object_id+']'));
    });
    
    delete_button_check();
    return false;
  });
  
  $('.remove_fieldset_link').live('click', function(){
    var destroy_elem = $(this).closest('.add_multiples').find('input[type=checkbox]');
    
    if(destroy_elem.length == 0){
      $(this).closest('.add_multiples').remove();
    }else{
      destroy_elem.attr('checked', 'checked');
      $(this).closest('.add_multiples').hide();
    }
    delete_button_check();
    return false;
  });
}

function delete_button_check(){
  var data_groups = [];
  $('.add_multiples').each(function(){
    data_groups.push($(this).attr('data-group'));
  });
  
  $.each($.unique(data_groups), function(index, data_group){
    var parent = $('.add_multiples[data-group='+data_group+']');
    if($('.add_multiples[data-group='+data_group+']:visible').size() == 1){
      parent.find('.remove_fieldset_link').hide();
    }else{
      parent.find('.remove_fieldset_link').show();
    }
  });
}