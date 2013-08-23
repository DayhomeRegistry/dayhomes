function add_another_mangement() {
  //delete_button_check();
  
  $('.add_multiples_link').click(function(){
    var data_group = $(this).attr('data-group');
    var attribute_key = $(this).attr('data-attribute-key');

    clone($('.add_multiples[data-group='+data_group+']:visible').last(),attribute_key);
    
    //We don't want to keep the last one
    //delete_button_check();
    return false;
  });
  function clone(jQueryElement, attribute_key){
    var new_object_id = new Date().getTime();
    var new_elem = jQueryElement.clone(true).insertAfter(jQueryElement);
    var attribute_re = new RegExp("\\["+attribute_key+"\\]\\[([0-9])+\\]");
          
    // clear out textareas
    new_elem.children('textarea').each(function(){
      $(this).text('');
      $(this).attr('name', jQueryElement.attr('name').replace(attribute_re, '['+attribute_key+']['+new_object_id+']'));
    });
    
    // When you add another row - remove stuff you no want
    new_elem.children('.remove_contents').each(function(){
      $(this).remove();
    });
    
    
    // Clear out inputs
    new_elem.children('input').each(function(){
      if($(this).is(":visible")) {
        if(!$(this).attr('type').match(/radio|check/)) {
          $(this).attr('value', '');
        }else{
          this.checked=false;
        }
      }
      $(this).attr('name', $(this).attr('name').replace(attribute_re, '['+attribute_key+']['+new_object_id+']'));
    });

    return new_elem;
  }
  
  $('.remove_fieldset_link').on('click', function(){
    var parent = $(this).closest('.add_multiples');
    var destroy_elem = parent.find('input[type=checkbox]');
    var data_group = parent.attr('data-group');
    if($('.add_multiples[data-group='+data_group+']:visible').length==1) {
      clone(parent);
    }
    if(destroy_elem.length == 0){
      parent.remove();
    }else{
      destroy_elem.attr('checked', 'checked');
      parent.hide();
    }
    //We don't want to keep the last one
    //delete_button_check();
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