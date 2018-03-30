$(document).on('turbolinks:load', function () {

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      type: 'POST',
      url: url,
      data: formData,
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html);
      $('.submit__form__inputArea__text').val('');
      $('.submit__form__inputArea__image__file').val('');
      $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
      flash();
    })
    .fail(function(){
      alert('error');
    });
    return false;
  });

  var interval = setInterval(function() {
    var currentUrl = location.href;
    if (currentUrl.match(/\/groups\/\d+\/messages/)) {
      var lastMessageId = $('.messages__item').last().data('messageId')
      $.ajax({
        type: 'GET',
        url: currentUrl,
        data: { lastMessageId: lastMessageId },
        dataType: 'json'
      })
      .done(function(data){
        data.messages.forEach(function(message){
          var html = buildHTML(message);
          $('.messages').append(html);
        });
      })
      .fail(function(){
        alert('error');
      });
    } else {
      clearInterval(interval);
    }
  }, 5000 );

});

function buildHTML(message){
  var html = `<div class ="messages__item" data-message-id="${message.id}">
                <div class ="userName">
                  ${message.user_name}
                </div>
                <div class ="sentTime">
                  ${message.created_at}
                </div>
                <div class ="text">
                  ${message.text}
                </div>
                <div class ="image">
                  ${ message.image == null ? "" : '<img src="' + message.image + '">' }
                </div>`
  return html;
}

function flash() {
  var html =
    `<p class="notice">メッセージを送信しました</p>`
  $('.javascript_flash').append(html);
  $('.notice').fadeIn(500).fadeOut(2000);
  setTimeout(function(){
   $('.notice').remove();
  },2500);
}
