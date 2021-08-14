// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery
//= require jquery3
//= require jquery_ujs
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap-sprockets

// require rails-ujs [jquery_ujsを使用するため停止]
//= require activestorage
//= require turbolinks
//= require_tree .

// ▼無限スクロール
$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.scroll-list',  // 読み込んだ要素を追加するクラス
      nextSelector: 'span.next:last a'
    });
  }
});
// ▲無限スクロール

// ▼画像スライダー
$(function() {
  $('#slider').slick({
    dots: true, //スライドの下にドットのナビゲーションを表示
  });
});
// ▲画像スライダー

// ▼search画面検索条件
	function radio_search_target(){
		radio = document.getElementsByName('search_target') 
		if(radio[0].checked) {
			document.getElementById('hidden1').style.display = "block";
			document.getElementById('hidden2').style.display = "none";
		}else if(radio[1].checked) {
			document.getElementById('hidden1').style.display = "none";
			document.getElementById('hidden2').style.display = "block";
		}
	}
// ▲search画面検索条件