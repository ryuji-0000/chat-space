$(document).on('turbolinks:load', function () {

  $('#user-search-field').on("keyup", function() {
    var input = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input },
      dataType: 'json'
    })

    .done(function(data) {
      $("#user-search-result").empty();
      if (data.users.length !== 0) {
        data.users.forEach(function(user){
          appendUser(user);
        });
      }
      else {
        appendNoUser("一致するユーザーはいません");
      }
    })
    .fail(function() {
      alert('ユーザー検索に失敗しました');
    });
  });

  $('#user-search-result').on("click", ".user-search-add", function(){
    $("#user-search-result").empty();
    var user = $(this).data();
    appendGroupUser(user);
  });

  $('#group-user').on("click", ".user-search-remove", function(){
    $(this).parent().remove();
  });

});

function appendUser(user) {
  var html = `<div class="chat-group-user clearfix">
                <p class="chat-group-user__name">${ user.name }</p>
                <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
              </div>`
  $("#user-search-result").append(html);
}

function appendNoUser(user) {
  var html =`<div class="chat-group-user clearfix">
              ${ user }
             </div>`
  $("#user-search-result").append(html);
}

function appendGroupUser(user) {
  var html =`<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-${ user.userId }'>
              <input name='group[user_ids][]' type='hidden' value='${ user.userId }'>
              <p class='chat-group-user__name'>${ user.userName }</p>
              <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
            </div>`
  $("#group-user").append(html);
}
