$(function(){
  // ul作成用のHTMLBuildメソッド
  function UlBuildHTML(){
    var html = `<ul id="post-result-list">`
    return html;
  }

  //li作成用のHTMLBuildメソッド
  function ListBuildHTML(data){
    var html = `<li class="post_contents_content">
                  <a href="/users/${data.postr_id}/show_profile">
                    <img class="post_contents_content_image" height="48px" width="48px" src="${data.post_avatar}">
                    <div class="post_contents_content_text">
                      <i class="fas ${data.post}"></i>
                        ${data.stance}
                      <p>${data.post_nickname}</p>
                      <p>${data.comment}</p>
                      <div class="post_contents_content_text_time">
                        <i class="far fa-lg fa-clock"></i>
                        <p>${data.created_at}</p>
                      </div>
                    </div>
                    <div class="post_contents_content_link-icon">
                      <i class="fas fa-lg fa-angle-right"></i>
                    </div>
                  </a>
                </li>`
    return html;
  }

  //データが何も無い時用のHTMLBuildメソッド
  function NoneListBuildHTML(message){
    var html = `<div class="post_contents_none" id="post-result-none">
                  <h3>
                    ${message}
                  </h3>
                </div>`
    return html;
  }

  //Ajaxの本体
  //idに特定のキーワードが含まれた要素をクリックした時に発火する
  $("[id^='post-tab-']").on('click',function(e){
    //"post-tab-"に前方一致するidをもつ全ての要素から"selected-tab"クラス削除
    $("[id^='post-tab-']").removeClass('selected-tab');
    //clickされたタブに"selected-tab"クラスを追加
    $(this).addClass('selected-tab');

    //カスタムdata属性に仕込んだ検索対象の評価種別(all/normal/good/bad)を取得する
    var target = $(this).data('post');

    //ajaxを発火させる
    //検体条件となる評価種別は明示的にdataとして埋め込む
    //ユーザ情報も必要だけど、私はdeviseを使っているのでサーバー側でcurrent_user.idを使うから不要
    $.ajax({
      url:     '/posts/index_api',
      type:    "GET",
      data:     {post: target},
      dataType:'json',
    })
    .done(function(list){
      // Ajaxが正常に戻ってきたので一旦リストを空にする
      var result_all  = $('#post-all');
      result_all.empty();
      // 取得データの状況によって表示内容を切り替える
      if ( list.length > 0 ){
        //データがあった場合はリスト表示開始
        //まずulタグをビルド
        var ul_html = UlBuildHTML();
        result_all.append(ul_html);
        var result_list = $('#post-list');
        //生成したulタグにデータ数分のliを追加
        list.forEach(function(data){
          var html = ListBuildHTML(data);
          result_list.append(html);
        });
      }else{
        //データがない場合は無いよとメッセージを出してあげる
        var message ='評価はまだありません'
        var html = NoneListBuildHTML(message);
        result_all.empty();
        result_all.append(html);
      }
    })
    .fail(function(){
      alert('データ取得に失敗しました');
    });
  });
});