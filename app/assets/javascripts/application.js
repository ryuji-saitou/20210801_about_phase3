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
//  require rails-ujs
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap-sprockets

//= require activestorage
//= require turbolinks
//= require_tree .

// ▼無限スクロール
// ▼[fix]20210817：tabごとにページ遷移する仕様に変更
//                 平行して "javascript" の記述を軽量化
$(document).on('turbolinks:load', function() {
  $('#tab1_link').click(function() {
    // console.log('tab1');
    window.location.href = '/?tab=timeline'
  })
  $('#tab2_link').click(function() {
    // console.log('tab2')
    window.location.href = '/?tab=new'
  })

  $('.jscroll').jscroll({
        contentSelector: '.scroll-list',  // .scroll-listに読み込んだ要素を追加
        nextSelector: 'span.next:last a'
  });
})
// ▲無限スクロール

// ▼画像スライダー
document.addEventListener("turbolinks:load", function(){
  $(function() {
    $('.slider').slick({
      dots: true //スライドの下にドットのナビゲーションを表示
    });
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

// ▼topアニメーション
document.addEventListener("turbolinks:load", function(){
  $(function() {
  	setTimeout(function(){
  		$('.start p').fadeIn(1600);
  	},500); //0.5秒後にロゴをフェードイン!
  	setTimeout(function(){
  		$('.start').fadeOut(500);
  	},2500); //2.5秒後にロゴ含め真っ白背景をフェードアウト！
  });
});
// ▲topアニメーション

// ▼aboutページ
// ページ表示とともに画像出現
setTimeout(() => {
  jQuery(function ($) {
    var fadeIn = $('.fade-in');
    // $(window).on('scroll', function () {
    $(fadeIn).each(function () {
      var offset = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > offset - windowHeight + 300) {
        $(this).addClass("scroll-in");
      }
    });
    // });
  });
}, 2800);

jQuery(function ($) {
  var fadeIn = $('.fade-in');
  $(window).on('scroll', function () {
    $(fadeIn).each(function () {
      var offset = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > offset - windowHeight + 150) {
        $(this).addClass("scroll-in");
      }
    });
  });
});
// ▲aboutページ