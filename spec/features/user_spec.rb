require "rails_helper"

feature "User", type: :feature do
  feature "ユーザー登録前" do
    scenario "ユーザー登録ができるか" do
      visit root_path
      click_on "Sign up"
      fill_in "ユーザー名", with: "user_name@user_name"
      fill_in "ユーザーID", with: "user_name_id@user_name_id"
      select "1989", from: "user[birthday(1i)]" # user[birthday(1i)]は、実際のページの"select name"から引っ張った。
      select "12", from: "user[birthday(2i)]"
      select "31", from: "user[birthday(3i)]"
      fill_in "メールアドレス", with: "email@email"
      fill_in "パスワード", with: "password"
      fill_in "パスワード確認", with: "password"
      # click_on "Sign up"  # 「Sign up」が2つ(ヘッダー&ボタン)存在しエラーが生じたため、id:"sign_up"をボタン側に追記後下記のように修正
      find("#sing_up").click
      # expect(page).to have_content("Home") headerのHomeにも反応してしまうため下記に修正
      expect(find(".page_title_Home")).to have_content("Home")

    end
  end
end