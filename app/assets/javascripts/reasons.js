$( document ).ready(function() {
    $('body').on('click', '.agree-link', function(){
        var reasonId = $(this).data('reason-id');

        if($(this).html() == 'Agree'){
          $(this).html('Nevermind');
          modifyAgreement(reasonId, true);
        }else if($(this).html() == 'Nevermind'){
          $(this).html('Agree');
          modifyAgreement(reasonId, false);
        }else{
          throw 'Unknown state: ' + $(this).html();
        }
    });

    function modifyAgreement(reasonId, agree){
      $.ajax({
        contentType: 'application/json',
        data: JSON.stringify(
              { "agree" : agree }
          ),
        dataType: 'json',
        type: 'POST',
        url: '/reasons/' + reasonId + '/agree'
      });
    }

});
