$(document).ready(function () {

  var $items = $('.item');

  $('#item_filter_category').on('change', function () {
    var currentCategory = this.value;
    $items.each(function (index, item) {
      $item = $(item);
      // ^ item here is wrapped as a jquery object with $()
      if ($item.data('category') === currentCategory) {
        $item.show();
      } else {
        $item.hide();
      }
    });
  });

});
